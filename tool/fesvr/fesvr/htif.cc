// See LICENSE for license details.

#include "htif.h"
#include "rfb.h"
#include "elfloader.h"
#include "encoding.h"
#include <algorithm>
#include <assert.h>
#include <vector>
#include <queue>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <time.h>
#include <string>

// Projects
#include "htif_proj.h"

#if PROJ_NUM == ES1Y
#include "es1y/es1y.h"
#elif PROJ_NUM == DEMO
#include "demo/demo.h"
#elif PROJ_NUM == ES1X
#include "es1x/es1x.h"
#elif PROJ_NUM == PYGMY_E
#include "pygmy_e/pygmy_e.h"
#endif

// Tian
#include <map>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

/* Attempt to determine the execution prefix automatically.  autoconf
 * sets PREFIX, and pconfigure sets __PCONFIGURE__PREFIX. */
#if !defined(PREFIX) && defined(__PCONFIGURE__PREFIX)
# define PREFIX __PCONFIGURE__PREFIX
#endif

#ifndef TARGET_ARCH
# define TARGET_ARCH "riscv64-unknown-elf"
#endif

#ifndef TARGET_DIR
# define TARGET_DIR "/" TARGET_ARCH "/bin/"
#endif

#ifndef SNAP_PERIOD
#  define SNAP_PERIOD 40000000
#endif

#ifndef PLIC_PERIOD
#  define PLIC_PERIOD 100
#endif

void htif_t::OURSBUS_WRITE(uint64_t addr, uint64_t data)
{ 
  uint8_t  reg[8] = {0};
  reg[0] = ((data) >>  0) & 0xff;
  reg[1] = ((data) >>  8) & 0xff;
  reg[2] = ((data) >> 16) & 0xff;
  reg[3] = ((data) >> 24) & 0xff;
  if ((data) > 0xffffffff) {
    reg[4] = ((uint64_t)(data) >> 32) & 0xff;
    reg[5] = ((uint64_t)(data) >> 40) & 0xff;
    reg[6] = ((uint64_t)(data) >> 48) & 0xff;
    reg[7] = ((uint64_t)(data) >> 56) & 0xff;
  } else {
    reg[4] = 0;
    reg[5] = 0;
    reg[6] = 0;
    reg[7] = 0;
  }
  mem.write(addr, 8, (uint8_t*)reg);
}

void htif_t::OURSBUS_READ(uint64_t addr, uint64_t & data) 
{ 
  uint8_t  reg[8] = {0};
  mem.read(addr, 8, (uint8_t*)reg); 
  for (int iii = 0; iii < 8; iii++) 
    data = ((data) << 8) + reg[7 - iii]; 
}

void htif_t::OURSBUS_READ_4B(uint64_t addr, uint64_t & data) 
{ 
  uint8_t  reg[8] = {0};
  mem.read(addr, 4, (uint8_t*)reg); 
  for (int iii = 0; iii < 8; iii++) 
    data = ((data) << 8) + reg[7 - iii]; 
}

//#define OURSBUS_READ(addr,data) \
{ \
  mem.read(addr, 8, (uint8_t*)reg); \
  /*fprintf(stderr, "OURSBUS_READ is back, addr = %x\n", addr);*/\
  for (int iii = 0; iii < 8; iii++) \
    data = ((data) << 8) + reg[7 - iii]; \
}

//#define OURSBUS_READ_4B(addr,data) \
{ \
  mem.read(addr, 4, (uint8_t*)reg); \
  for (int iii = 0; iii < 8; iii++) \
    data = ((data) << 8) + reg[7 - iii]; \
}

void htif_t::OURSBUS_CHECK(uint64_t addr, uint64_t refdata, const char * msg)
{ 
  uint64_t data = 0;
  uint8_t  reg[8] = {0};
  mem.read(addr, 4, (uint8_t*)reg);
  for (int iii = 0; iii < 8; iii++)
    data = ((data) << 8) + reg[7 - iii];
  if (data != refdata)
    fprintf(stderr, "Data mismatch for address %llx actual %llx expect %llx %s\n", addr, data, refdata, msg);
  else
    fprintf(stderr, "Data matched for address %llx actual %llx expect %llx %s\n", addr, data, refdata, msg);
}

//#define OURSBUS_PULL(addr,data) OURSBUS_READ(addr,data)
#define OURSBUS_PULL(addr,data) 

static volatile bool signal_exit = false;
static void handle_signal(int sig)
{
  if (sig == SIGABRT || signal_exit) // someone set up us the bomb!
    exit(-1);
  signal_exit = true;
  signal(sig, &handle_signal);
}

#include <stdio.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <signal.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/time.h>
#include <memory.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <stdarg.h>
#include <unistd.h>

bool setup(int& sock, sockaddr_in serverAddress) {

    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        printf("\n Socket creation error \n");
        return false;
    }

    serverAddress.sin_family = AF_INET;
    serverAddress.sin_port = htons(2000);

    // Convert IPv4 and IPv6 addresses from text to binary form
    if(inet_pton(AF_INET, "127.0.0.1", &serverAddress.sin_addr)<=0)
    {
        printf("\nInvalid address/ Address not supported \n");
        return false;
    }

    // Connect to python
    if (connect(sock, (struct sockaddr *)&serverAddress, sizeof(serverAddress)) < 0)
    {
        //printf("\n(Not able to connect to Python debugger!)\n");
        return false;
    }
    return true;
}

htif_t::htif_t(const std::vector<std::string>& args)
  : mem(this), entry(DRAM_BASE), sig_addr(0), sig_len(0),
    tohost_addr(-1), fromhost_addr(0), exitcode(0), stopped(false),
    syscall_proxy(this)
{
  signal(SIGINT, &handle_signal);
  signal(SIGTERM, &handle_signal);
  signal(SIGABRT, &handle_signal); // we still want to call static destructors

  size_t i, j;

#if PROJ_NUM == ES1X
  es1x* es1x_proj = new es1x(this);
  projmap = {
     {es1x_proj->get_proj_id(), es1x_proj}
  };
#elif PROJ_NUM == DEMO
  demo* demo_proj = new demo(this);
  projmap = {
     {demo_proj->get_proj_id(), demo_proj}
  };
#elif PROJ_NUM == ES1Y
  es1y* es1y_proj = new es1y(this);
  projmap = {
     {es1y_proj->get_proj_id(), es1y_proj}
  };
#elif PROJ_NUM == PYGMY_E
  pygmy_e* pygmy_e_proj = new pygmy_e(this);
  projmap = {
     {pygmy_e_proj->get_proj_id(), pygmy_e_proj}
  };
#endif

  //auto it = proj->boot_sequence.begin();
  //for (;it != proj->boot_sequence.end(); ++i){
  //  argmap.insert({it->key.c_str(), ""});
  //} 
  argmap.insert({"filename1",""});
  argmap.insert({"filename2",""});
  argmap.insert({"filename3",""});
  argmap.insert({"load_2nd_file", ""});
  argmap.insert({"load_3rd_file", ""});
  argmap.insert({"proj=", ""});
  argmap.insert({"vcorelog", ""});
 //argmap = {
 //   {"numVcore=", ""},
 //   {"loopCount=", ""},
 //   {"trigger_afterwards", ""},
 //   {"background_traffic", ""},
 //   {"filename1", ""},
 //   {"filename2", ""},
 //   {"filename3", ""},
 //   {"load_rom", ""},
 //   {"reset_ddr", ""},
 //   {"ddr_train_1d", ""},
 //   {"ddr_bypass", ""},
 //   {"sdio_init", ""},
 //   {"program_pll=", ""},
 //   {"release_l2_reset", ""},
 //   {"config_l2=", ""},
 //   {"test_l2", ""}, // TODO
 //   {"set_0_to_l2_vldram", ""},
 //   {"release_l1_reset", ""},
 //   {"test_l1", ""}, // TODO
 //   {"set_0_to_l1_tagram", ""},
 //   {"l1_warmup", ""},
 //   {"load_pk", ""},
 //   {"test_magic_mem", ""}, // TODO
 //   {"set_magic_mem", ""},
 //   {"set_rst_pc=", ""},
 //   {"release_orv32_reset", ""},
 //   {"dram_tester_test", ""},
 //   {"load_image=", ""},
 //   {"load_weight=", ""},
 //   {"load_2nd_file", ""},
 //   {"load_3rd_file", ""},
 //   {"release_vp_reset=", ""},
 //   {"alloc_sp=", ""},
 //   {"perf_report", ""},
 //   {"mem_test=", ""},
 //   {"io_test", ""},
 //   {"dump_l2_after_loading=", ""}
 // };
  for (i = 0, j = 0; i < args.size(); i++) {
    if ((args[i].length() > 2) && (args[i][0] == '+') && (args[i][1] == '+')) {
      int found = 0;
      for (std::map<std::string, std::string>::iterator it = argmap.begin(); it != argmap.end(); ++it) {
        if (it->first == args[i].substr(2, it->first.length())) {
          if (it->first.length() == args[i].length() - 2)
            it->second = args[i].substr(2);
          else {
            if (strcmp((it->first).substr((it->first.length())-1).c_str(),"=")==0){
              it->second = args[i].substr(2 + it->first.length());
            }
            //it->second = args[i].substr(2 + it->first.length());
          }
          found = 1;
          break;
        }
      }
      if (found == 0) {
        if (j == 0) {
          argmap["filename1"] = args[i].substr(2);
          fprintf(stderr, "binary file = %s\n", argmap["filename1"].c_str());
        } else if (j == 1) {
          argmap["filename2"] = args[i].substr(2);
          fprintf(stderr, "binary file = %s\n", argmap["filename2"].c_str());
        } else if (j == 2) {
          argmap["filename3"] = args[i].substr(2);
          fprintf(stderr, "binary file = %s\n", argmap["filename3"].c_str());
        }
        j = j + 1;
      }
    }
  }
  hargs.insert(hargs.begin(), args.begin(), args.begin() + i);
  targs.insert(targs.begin(), argmap["filename1"]);
  targs.insert(targs.begin() + 1, argmap["filename2"]);
  targs.insert(targs.begin() + 2, argmap["filename3"]);
  targs.insert(targs.begin() + 3, argmap["load_image="]);
  targs.insert(targs.begin() + 4, argmap["load_weight="]);
  if (argmap["vcorelog"].length()>0){
    std::ofstream file{"vcore.log"};
    vfile = fopen("vcore.log", "rw+");
  }
  for (auto& arg : hargs)
  {
    if (arg == "+rfb")
      dynamic_devices.push_back(new rfb_t);
    else if (arg.find("+rfb=") == 0)
      dynamic_devices.push_back(new rfb_t(atoi(arg.c_str() + strlen("+rfb="))));
    else if (arg.find("+disk=") == 0)
      dynamic_devices.push_back(new disk_t(arg.c_str() + strlen("+disk=")));
    else if (arg.find("+signature=") == 0)
      sig_file = arg.c_str() + strlen("+signature=");
    else if (arg.find("+chroot=") == 0)
      syscall_proxy.set_chroot(arg.substr(strlen("+chroot=")).c_str());
  }

  device_list.register_device(&syscall_proxy);
  device_list.register_device(&bcd);
  for (auto d : dynamic_devices)
    device_list.register_device(d);

  // Save snap_period from argmap to variable
  if (argmap["snap_period="].length() > 0) {
    snap_period = (uint64_t)stoll(argmap["snap_period="]);
  }
  else {
    snap_period = 0;
  }
  if (argmap["snap_initial="].length() > 0) {
    snap_initial = (uint64_t)stoll(argmap["snap_initial="]);
  }
  else {
    snap_initial = 0;
  }
}

htif_t::~htif_t()
{
  for (auto d : dynamic_devices)
    delete d;
  auto it = projmap.begin();
  for(;it != projmap.end(); ++it){
    free(it->second);
  }
}

void htif_t::start()
{
  load_program();

  reset();
}

void htif_t::load_program()
{
  std::string proj_id;
#if PROJ_NUM == ES1Y
  proj_id = "es1y";
#elif PROJ_NUM == ES1X
  proj_id = "es1x";
#elif PROJ_NUM == PYGMY_E
  proj_id = "pygmy_e";
#endif
  if (argmap["filename1"].length() > 0) {
    if (access(argmap["filename1"].c_str(), F_OK) == 0)
      this->path = argmap["filename1"];
    else if (argmap["filename1"].find('/') == std::string::npos)
    {
      std::string test_path = PREFIX TARGET_DIR + argmap["filename1"];
      if (access(test_path.c_str(), F_OK) == 0)
        this->path = test_path;
    }

    if (this->path.empty())
      throw std::runtime_error("could not open " + argmap["filename1"]);
  }

  project = projmap[proj_id];
  project->setup();
}

void htif_t::stop()
{
  if (!sig_file.empty() && sig_len) // print final torture test signature
  {
    std::vector<uint8_t> buf(sig_len);
    mem.read(sig_addr, sig_len, &buf[0]);

    std::ofstream sigs(sig_file);
    assert(sigs && "can't open signature file!");
    sigs << std::setfill('0') << std::hex;

    const addr_t incr = 16;
    assert(sig_len % incr == 0);
    for (addr_t i = 0; i < sig_len; i += incr)
    {
      for (addr_t j = incr; j > 0; j--)
        sigs << std::setw(2) << (uint16_t)buf[i+j-1];
      sigs << '\n';
    }

    sigs.close();
  }
  

  stopped = true;
}

void htif_t::clear_chunk(addr_t taddr, size_t len, enum rw_target target)
{
  char zeros[chunk_max_size()];
  memset(zeros, 0, chunk_max_size());

  for (size_t pos = 0; pos < len; pos += chunk_max_size())
    write_chunk(taddr + pos, std::min(len - pos, chunk_max_size()), zeros);
}

// Tian: HACH This is in htif_proj as well, delete here after bg is moved to project
int weighted_random(std::map<int, int> wmap) {
  int wsum = 0;
  for (std::map<int, int>::iterator it = wmap.begin(); it != wmap.end(); ++it) {
    wsum += it->second;
  }
  int rand = random() % wsum;
  wsum = 0;
  for (std::map<int, int>::iterator it = wmap.begin(); it != wmap.end(); ++it) {
    wsum += it->second;
    if (wsum >= rand) {
      return it->first;
    }
  }
  return 0;
};

int htif_t::run()
{
  start();
  auto enq_func = [](std::queue<reg_t>* q, uint64_t x) { q->push(x); };
  std::queue<reg_t> fromhost_queue;
  std::function<void(reg_t)> fromhost_callback =
    std::bind(enq_func, &fromhost_queue, std::placeholders::_1);

  if (tohost_addr == -1) {
    while (true)
      idle();
  }
  int sock = 0;
  //struct sockaddr_in serverAddress;
  //memset(&serverAddress, '0', sizeof(serverAddress));
  //bool has_socket = setup(sock, serverAddress);
  bool has_socket = false;

  // Argmap variables
  bool freeze = this->argmap["freeze"].length() > 0;
  bool test_bp = this->argmap["test_bp="].length() > 0;
  bool test_instret = this->argmap["test_instret="].length() > 0;
  bool background_traffic = this->argmap["background_traffic"].length() > 0;
  bool log_step = this->argmap["log_step="].length() > 0;
  bool test_bg = this->argmap["test_bg="].length() > 0;

  count = 1;
  debug_interrupt = true;
  bool wfe_flag = false;
  while (!signal_exit && exitcode == 0)
  {
    if(test_bg) {
      size_t sz;
      char arg[100];
      sprintf(arg, "test_bg=");    
      int bg_cnt = std::stoul(this->argmap[arg], &sz, 10);
      fprintf(stderr, "Start Running background traffic, count = %0d\n", bg_cnt);
      for (int bg = 0; bg < bg_cnt; bg++) {
        project->bg();
      }
      fprintf(stderr, "Done %0d background traffic\n", bg_cnt);
    }
    if(freeze){
      mem.write_uint64(STATION_ORV32_S2B_DEBUG_STALL_ADDR, 1);
      while(mem.read_uint64(STATION_ORV32_B2S_DEBUG_STALL_OUT_ADDR) != 1){}
    }
    volatile uint64_t tohost = mem.read_uint64(tohost_addr);
    volatile uint64_t tohost_1 = mem.read_uint64(tohost_addr);

    if ((tohost == tohost_1) && (tohost != 0x0)) {
      mem.write_uint64(tohost_addr, 0);
      wfe_flag = true;
      command_t cmd(this, tohost, fromhost_callback);
      //fprintf(stderr, "tohost = %lx, cmd.cmd() = %x, cmd.payload() = %x\n", tohost, cmd.cmd(), cmd.payload());
      device_list.handle_command(cmd);
      if(freeze){
        mem.write_uint64(STATION_ORV32_S2B_DEBUG_STALL_ADDR, 0);
        mem.write_uint64(STATION_ORV32_S2B_DEBUG_RESUME_ADDR, 1);
      }
    } else {
      if(freeze){
        mem.write_uint64(STATION_ORV32_S2B_DEBUG_STALL_ADDR, 0);
        mem.write_uint64(STATION_ORV32_S2B_DEBUG_RESUME_ADDR, 1);
      }
      int rate = rand() % 100;
      if ((rate < 33) && (test_bp || test_instret)) {
        //  CHECK IF ORV32 OR ANY VP IS STALLED
        uint64_t orv32_stalled;
        uint64_t vp0_stalled;
        uint64_t vp1_stalled;
        uint64_t vp2_stalled;
        uint64_t vp3_stalled;
        uint64_t instret_0;
        uint64_t instret_1;
        uint64_t hpmcounter9_0; // IC HIT 
        uint64_t hpmcounter9_1; // IC HIT
        uint64_t hpmcounter10_0; // IC MISS  
        uint64_t hpmcounter10_1; // IC MISS 
        
        OURSBUS_READ(STATION_ORV32_B2S_DEBUG_STALL_OUT_ADDR, orv32_stalled);
#if PROJ_NUM != PYGMY_E
        OURSBUS_READ(STATION_VP_B2S_DEBUG_STALL_OUT_ADDR_0, vp0_stalled);
        OURSBUS_READ(STATION_VP_B2S_DEBUG_STALL_OUT_ADDR_1, vp1_stalled);
        OURSBUS_READ(STATION_VP_B2S_DEBUG_STALL_OUT_ADDR_2, vp2_stalled);
        OURSBUS_READ(STATION_VP_B2S_DEBUG_STALL_OUT_ADDR_3, vp3_stalled);
#endif
        if (orv32_stalled == 1){
          // Read some counters a few times to make sure the cpu has stalled
          OURSBUS_READ(STATION_ORV32_MINSTRET_ADDR, instret_0);
          OURSBUS_READ(STATION_ORV32_HPMCOUNTER_9_ADDR, hpmcounter9_0);
          OURSBUS_READ(STATION_ORV32_HPMCOUNTER_10_ADDR, hpmcounter10_0);

          OURSBUS_READ(STATION_ORV32_MINSTRET_ADDR, instret_1);
          OURSBUS_READ(STATION_ORV32_HPMCOUNTER_9_ADDR, hpmcounter9_1);
          OURSBUS_READ(STATION_ORV32_HPMCOUNTER_10_ADDR, hpmcounter10_1);
          // Resume
          if((instret_0 == instret_1) && (hpmcounter9_0 == hpmcounter9_1) &&
             (hpmcounter10_0 == hpmcounter10_1)) {
            OURSBUS_WRITE(STATION_ORV32_S2B_DEBUG_RESUME_ADDR, 0x00000001);
          } else {
            fprintf(stderr, "Breakpoint not happening correctly!\n");
          }
#if PROJ_NUM != PYGMY_E
        } else if (vp0_stalled == 1){
          // Read some counters a few times to make sure the cpu has stalled
          OURSBUS_READ(STATION_VP_MINSTRET_ADDR_0, instret_0);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_9_ADDR_0, hpmcounter9_0);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_10_ADDR_0, hpmcounter10_0);

          OURSBUS_READ(STATION_VP_MINSTRET_ADDR_0, instret_1);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_9_ADDR_0, hpmcounter9_1);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_10_ADDR_0, hpmcounter10_1);

          // Resume
          if((instret_0 == instret_1) && (hpmcounter9_0 == hpmcounter9_1) &&
             (hpmcounter10_0 == hpmcounter10_1)) {
            OURSBUS_WRITE(STATION_VP_S2B_DEBUG_RESUME_ADDR_0, 0x00000001);
          } else {
            fprintf(stderr, "Breakpoint not happening correctly!\n");
          }
        } else if (vp1_stalled == 1){
          // Read some counters a few times to make sure the cpu has stalled
          OURSBUS_READ(STATION_VP_MINSTRET_ADDR_1, instret_0);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_9_ADDR_1, hpmcounter9_0);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_10_ADDR_1, hpmcounter10_0);

          OURSBUS_READ(STATION_VP_MINSTRET_ADDR_1, instret_1);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_9_ADDR_1, hpmcounter9_1);
          OURSBUS_READ(STATION_VP_S2B_EN_BP_INSTRET_ADDR_1, instret_1);

          // Resume
          if((instret_0 == instret_1) && (hpmcounter9_0 == hpmcounter9_1) &&
             (hpmcounter10_0 == hpmcounter10_1)) {
            OURSBUS_WRITE(STATION_VP_S2B_DEBUG_RESUME_ADDR_1, 0x00000001);
          } else {
            fprintf(stderr, "Breakpoint not happening correctly!\n");
          }
        } else if (vp2_stalled == 1){
          // Read some counters a few times to make sure the cpu has stalled
          OURSBUS_READ(STATION_VP_MINSTRET_ADDR_2, instret_0);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_9_ADDR_2, hpmcounter9_0);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_10_ADDR_2, hpmcounter10_0);

          OURSBUS_READ(STATION_VP_MINSTRET_ADDR_2, instret_1);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_9_ADDR_2, hpmcounter9_1);
          OURSBUS_READ(STATION_VP_S2B_EN_BP_INSTRET_ADDR_2, instret_1);

          // Resume
          if((instret_0 == instret_1) && (hpmcounter9_0 == hpmcounter9_1) &&
             (hpmcounter10_0 == hpmcounter10_1)) {
            OURSBUS_WRITE(STATION_VP_S2B_DEBUG_RESUME_ADDR_2, 0x00000001);
          } else {
            fprintf(stderr, "Breakpoint not happening correctly!\n");
          }
        } else if (vp3_stalled == 1){
          // Read some counters a few times to make sure the cpu has stalled
          OURSBUS_READ(STATION_VP_MINSTRET_ADDR_3, instret_0);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_9_ADDR_3, hpmcounter9_0);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_10_ADDR_3, hpmcounter10_0);

          OURSBUS_READ(STATION_VP_MINSTRET_ADDR_3, instret_1);
          OURSBUS_READ(STATION_VP_HPMCOUNTER_9_ADDR_3, hpmcounter9_1);
          OURSBUS_READ(STATION_VP_S2B_EN_BP_INSTRET_ADDR_3, instret_1);

          // Resume
          if((instret_0 == instret_1) && (hpmcounter9_0 == hpmcounter9_1) &&
             (hpmcounter10_0 == hpmcounter10_1)) {
            OURSBUS_WRITE(STATION_VP_S2B_DEBUG_RESUME_ADDR_3, 0x00000001);
          } else {
            fprintf(stderr, "Breakpoint not happening correctly!\n");
          }
#endif
        }
      }
      else if (has_socket && (rate >= 33 && rate < 67)) {
        char const *status = "Ready";
        char *command = new char[1];
        char *size = new char[1];
        uint32_t sizeVal = 0;
        // if address doesn't look right change this to length of
        // what address should be
        char *address = new char[10];
        uint64_t addressVal = 0;
        char *data = new char [16];
        uint8_t reg[8];
        int retBytes = 0;
        bool success = true;
        char* sz;
        char *response = new char[17];
        char commands [3];
        sprintf(commands,"rw");        

        // Send notification to python
        if ((retBytes = send(sock , status , strlen(status) , 0 )) == -1) {
          printf("Error, cannot send status\n");
          success = false;
        }
        // Get command
        if (success && (retBytes = recv(sock, command, 1, 0) == -1)) {
          printf("Error cannot recieve command\n");
          success = false;
        }
        // Sometimes ghost values get sent over and break the program
        // this catches it and disposes of the junk values
        if (command[0]!=commands[0] && command[0]!=commands[1]) {
          fprintf(stderr, "Error, ghost value detected, disposing...\n");
          continue;
        }
        
        if (success && (retBytes = recv(sock, size, 1, 0) == -1)) {
          printf ("Error: cannot receive size!\n");
        } else {
          sizeVal = std::strtoll(size, &sz, 16);
        }
        
        if (success && (retBytes = recv(sock, address, 10, 0) == -1)) {
          printf ("Error: cannot receive address!\n");
          success = false;
        } else {
          addressVal = std::strtoll(address, &sz, 16);
        }
        if (success) {
          if (command[0]==commands[0]) {
            mem.read(addressVal, sizeVal, reg);
            sprintf(response, "%02x%02x%02x%02x%02x%02x%02x%02x", reg[7], reg[6], reg[5], reg[4], reg[3], reg[2], reg[1], reg[0]);
          } else if (command[0] ==commands[1]) {
            if (success && (retBytes = recv(sock, data, 16, 0) == -1)) {
              fprintf (stderr, "Error: cannot receive write data!\n");
              success = false;
            } else {
              
              char * tmp_str = new char[2];
              for (int i = 0; i < 8; i++) {
                tmp_str[1] = data[15 - i * 2];
                tmp_str[0] = data[15 - i * 2 - 1];
                reg[i] = std::strtoll(tmp_str, &sz, 16);
              }
            }
            mem.write(addressVal, sizeVal, reg);
            strcpy(response, "wrote");
          }
        }
        command[0] = '\0';
        send(sock, response, strlen(response), 0);
        free(data);
        free(address);
        free(size);
        free(command);
        free(response);
      } else if (background_traffic) {
        project->bg();
        //uint64_t wdata;
        //uint64_t rdata = 0;
        //uint64_t addr;
        //uint64_t orig_data = 0;
        //int todo = weighted_random(bg_target_weight_map);
        ////fprintf (stderr, "BG: todo = %0d\n", todo);
        //int target;
        //if (argmap["snapshot"].length() > 0) {
        //  //OURSBUS_READ_4B(STATION_VP_MINSTRET_ADDR_0, rdata);
        //  OURSBUS_READ(STATION_VP_MINSTRET_ADDR_0, rdata);
        //  if ((debug_interrupt) && (rdata == (SNAP_PERIOD * count))) {
        //    debug_interrupt = false;
        //    fprintf(stderr, "Sending debug interrupt %d\n", count);
        //    // Issue dbg interrupt
        //    //OURSBUS_WRITE(0x02002000, 1);
        //    OURSBUS_WRITE(0x00802000, 1);
        //    count++;
        //    idle();
        //  } else {
        //    idle();
        //  }
        //} else if (argmap["plic_interrupt"].length() > 0) {
        //  OURSBUS_READ(STATION_VP_MINSTRET_ADDR_0, rdata);
        //  if ((debug_interrupt) && (rdata == (PLIC_PERIOD * count))) {
        //    fprintf(stderr, "plic interrupt\n");
        //    debug_interrupt = false;
        //    OURSBUS_WRITE(STATION_DMA_S2B_PLIC_INTR_EN_ADDR__DEPTH_0, 0x1); // Enable intr src 0
        //    OURSBUS_WRITE(STATION_DMA_S2B_PLIC_INTR_CORE_ID_ADDR__DEPTH_0, 0x0); // CORE 0 handle the interrupt
        //    OURSBUS_WRITE(STATION_DMA_S2B_PLIC_DBG_EN_ADDR__DEPTH_0, 0x1); // Trigger dbg intr src 0
        //    count++;
        //    idle();
        //  } else {
        //    idle(); 
        //  }
        //} else {
        //  switch (static_cast<bg_target_e>(todo)) {
        //    case SLOW_IO:
        //      fprintf(stderr, "BG: SLOW IO\n");
        //      target = weighted_random(bg_target_slow_io_weight_map);
        //      switch (static_cast<bg_target_slow_io_e>(target)) {
        //        case SPIM:
        //          // SPIM
        //          OURSBUS_READ_4B(STATION_SLOW_IO_SPIM_BLOCK_REG_ADDR + 0x5c, rdata);
        //          if (rdata != 0x3430322a) {
        //            fprintf(stderr, "Error: spim version id wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_SLOW_IO_SPIM_BLOCK_REG_ADDR + 0x8, orig_data);
        //          OURSBUS_WRITE(STATION_SLOW_IO_SPIM_BLOCK_REG_ADDR + 0x8, 0x1);
        //          OURSBUS_READ_4B(STATION_SLOW_IO_SPIM_BLOCK_REG_ADDR + 0x8, rdata);
        //          if (rdata != 0x1) {
        //            fprintf(stderr, "Error: spim write access wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_WRITE(STATION_SLOW_IO_SPIM_BLOCK_REG_ADDR + 0x8, orig_data);
        //          break;
        //        case SPIS:
        //          // SPIS
        //          OURSBUS_READ_4B(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x5c, rdata);
        //          if (rdata != 0x3430312a) {
        //            fprintf(stderr, "Error: spis version id wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x8, orig_data);
        //          OURSBUS_WRITE(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x8, 0x1);
        //          OURSBUS_READ_4B(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x8, rdata);
        //          if (rdata != 0x1) {
        //            fprintf(stderr, "Error: spis write access wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_WRITE(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x8, orig_data);
        //          break;
        //        case I2CM:
        //          // I2CM
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2CM_BLOCK_REG_ADDR + 0xf8, rdata);
        //          if (rdata != 0x3230312a) {
        //            fprintf(stderr, "Error: i2cm version id wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2CM_BLOCK_REG_ADDR + 0x6c, orig_data);
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2CM_BLOCK_REG_ADDR + 0x6c, 0x1);
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2CM_BLOCK_REG_ADDR + 0x6c, rdata);
        //          if (rdata != 0x1) {
        //            fprintf(stderr, "Error: i2cm write access wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2CM_BLOCK_REG_ADDR + 0x6c, orig_data);
        //          break;
        //        case I2CS:
        //          // I2CS
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2CS_BLOCK_REG_ADDR + 0xf8, rdata);
        //          if (rdata != 0x3230312a) {
        //            fprintf(stderr, "Error: i2cs version id wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2CS_BLOCK_REG_ADDR + 0x6c, orig_data);
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2CS_BLOCK_REG_ADDR + 0x6c, 0x1);
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2CS_BLOCK_REG_ADDR + 0x6c, rdata);
        //          if (rdata != 0x1) {
        //            fprintf(stderr, "Error: i2cs write access wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2CS_BLOCK_REG_ADDR + 0x6c, orig_data);
        //          break;
        //        case UART:
        //          // UART
        //          OURSBUS_READ_4B(STATION_SLOW_IO_UART_BLOCK_REG_ADDR + 0x14, rdata);
        //          if (rdata != 0x60) {
        //            fprintf(stderr, "Error: uart lsr reg reset value wrong, rdata = 0x%x\n", rdata);
        //          }
        //          break;
        //        case GPIO:
        //          // GPIO
        //          OURSBUS_READ_4B(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x6c, rdata);
        //          if (rdata != 0x3231322a) {
        //            fprintf(stderr, "Error: gpio version id wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x30, orig_data);
        //          wdata = random();
        //          OURSBUS_WRITE(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x30, wdata);
        //          OURSBUS_READ_4B(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x30, rdata);
        //          if (rdata != (wdata & 0xff)) {
        //            fprintf(stderr, "Error: gpio write access wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_WRITE(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x30, orig_data);
        //          break;
        //        case I2SM:
        //          // I2SM
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x1f8, rdata);
        //          if (rdata != 0x3131302a) {
        //            fprintf(stderr, "Error: i2sm version id wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x0, orig_data);
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x0, 0x1);
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x0, rdata);
        //          if (rdata != 0x1) {
        //            fprintf(stderr, "Error: i2sm write access wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x0, orig_data);
        //          break;
        //        case I2SS0:
        //          // I2SS0
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x1f8, rdata);
        //          if (rdata != 0x3131302a) {
        //            fprintf(stderr, "Error: i2ss0 version id wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x0, orig_data);
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x0, 0x1);
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x0, rdata);
        //          if (rdata != 0x1) {
        //            fprintf(stderr, "Error: i2ss0 write access wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x0, orig_data);
        //          break;
        //        case I2SS1:
        //          // I2SS1
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x1f8, rdata);
        //          if (rdata != 0x3131302a) {
        //            fprintf(stderr, "Error: i2ss1 version id wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x0, orig_data);
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x0, 0x1);
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x0, rdata);
        //          if (rdata != 0x1) {
        //            fprintf(stderr, "Error: i2ss1 write access wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x0, orig_data);
        //          break;
        //        case I2SS2:
        //          // I2SS2
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x1f8, rdata);
        //          if (rdata != 0x3131302a) {
        //            fprintf(stderr, "Error: i2ss2 version id wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x0, orig_data);
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x0, 0x1);
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x0, rdata);
        //          if (rdata != 0x1) {
        //            fprintf(stderr, "Error: i2ss2 write access wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x0, orig_data);
        //          break;
        //        case I2SS3:
        //          // I2SS3
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS3_BLOCK_REG_ADDR + 0x1f8, rdata);
        //          if (rdata != 0x3131302a) {
        //            fprintf(stderr, "Error: i2ss3 version id wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS3_BLOCK_REG_ADDR + 0x0, orig_data);
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2SS3_BLOCK_REG_ADDR + 0x0, 0x1);
        //          OURSBUS_READ_4B(STATION_SLOW_IO_I2SS3_BLOCK_REG_ADDR + 0x0, rdata);
        //          if (rdata != 0x1) {
        //            fprintf(stderr, "Error: i2ss3 write access wrong, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_WRITE(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x0, orig_data);
        //          break;
        //      }
        //      break;
        //    case DDR:
        //      fprintf(stderr, "BG: DDR\n");
        //      OURSBUS_WRITE (STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0000 << 2), 0x0); // Enable access to PHY registers
        //      OURSBUS_WRITE (STATION_DDR_TOP_DDR_PHY_ADDR + (0xc0080 << 2), 0x7); // DWC_DDRPHYA_DRTUB0_UcclkHclkEnables
        //      OURSBUS_READ_4B(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0099 << 2), orig_data); //Enable access to SRAM by stall ARCv2
        //      fprintf(stderr, "BG: DDR Stall ARCv2 ICCMs, original MicroReset value = 0x%x\n", orig_data);
        //      wdata = orig_data | 0x1;
        //      OURSBUS_WRITE(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0099 << 2), wdata);
        //      target = weighted_random(bg_target_ddr_weight_map);
        //      int index;
        //      switch (static_cast<bg_target_ddr_e>(target)) {
        //        case CTRL:
        //          index = random() % 3;
        //          wdata = random();
        //          if (index == 0) {
        //            fprintf(stderr, "BG: DDR UMCTL2_REGS\n");
        //            addr = STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x30 << 2);
        //            OURSBUS_READ_4B(addr, orig_data); // PWRCTL
        //            OURSBUS_WRITE(addr, wdata);
        //            OURSBUS_READ_4B(addr, rdata);
        //            if ((rdata & 0x1ef) != (wdata & 0x1ef)) {
        //              fprintf(stderr, "Error: Reading UMCTL2_REGS with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, (wdata & 0x1ef), (rdata & 0x1ef));
        //            }
        //            OURSBUS_WRITE(addr, orig_data); //restore the original data
        //          } else if (index == 1) {
        //            fprintf(stderr, "BG: DDR UMCTL2_MP\n");      
        //            addr = STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x490 << 2);
        //            OURSBUS_READ_4B(addr, orig_data); // PCTRL_1
        //            OURSBUS_WRITE(addr, wdata);
        //            OURSBUS_READ_4B(addr, rdata);
        //            if ((rdata & 0x1) != (wdata & 0x1)) {
        //              fprintf(stderr, "Error: Reading UMCTL2_MP with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, (wdata & 0x1), (rdata & 0x1));
        //            }
        //            OURSBUS_WRITE(addr, orig_data); //restore the original data
        //          } else if (index == 2) {
        //            fprintf(stderr, "BG: DDR UMCTL2_REGS_FREQ1\n");      
        //            addr = STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x2050 << 2);
        //            OURSBUS_READ_4B(addr, orig_data); // RFSHCT0
        //            OURSBUS_WRITE(addr, wdata);
        //            OURSBUS_READ_4B(addr, rdata);
        //            if ((rdata & 0xf1f3f0) != (wdata & 0xf1f3f0)) {
        //              fprintf(stderr, "Error: Reading UMCTL2_REGS_FREQ1 with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, (wdata & 0xf1f3f0), (rdata & 0xf1f3f0));
        //            }
        //            OURSBUS_WRITE(addr, orig_data); //restore the original data
        //          }
        //          break;
        //        case PHY:
        //          index = random() % 2; // if index is 1 then access dbyte1 registers. otherwise access dbyte0 registers
        //          fprintf(stderr, "BG: DDR PHY REGs, index= 0x%x\n", index);

        //          wdata = random();
        //          addr = (STATION_DDR_TOP_DDR_PHY_ADDR + (0x100d0 << 2) + ((index * 0x1000) << 2)); //TxDqsDlyTg0_u0_p0, related to write leveling
        //          OURSBUS_READ_4B(addr, orig_data);
        //          OURSBUS_WRITE(addr, wdata);
        //          OURSBUS_READ_4B(addr, rdata);
        //          if ((rdata & 0xf) != (wdata & 0xf)) {
        //            fprintf(stderr, "Error: Reading TxDqsDlyTg0_u0_p0 with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, wdata, rdata);
        //          }
        //          OURSBUS_WRITE(addr, orig_data);
        //          break;
        //        case SRAM:
        //          //SRAM, each address contains 16-bit word
        //          //ICCM
        //          fprintf(stderr, "BG: DDR ICCMs\n");
        //          wdata = random();
        //          addr = STATION_DDR_TOP_DDR_PHY_ADDR + (0x50000 << 2) + ((random() % 0x3ff8) << 2);
        //          OURSBUS_WRITE(addr, wdata);
        //          OURSBUS_READ_4B(addr, rdata);
        //          if (rdata != (wdata & 0xffff)) {
        //            fprintf(stderr, "Error: Reading ICCM with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, wdata, rdata);
        //          }
        //          //DCCM
        //          fprintf(stderr, "BG: DDR DCCMs\n");
        //          wdata = random();
        //          addr = STATION_DDR_TOP_DDR_PHY_ADDR + (0x54000 << 2) + ((random() % 0x400) << 2);
        //          OURSBUS_WRITE(addr, wdata);
        //          OURSBUS_READ_4B(addr, rdata);
        //          if (rdata != (wdata & 0xffff)) {
        //            fprintf(stderr, "Error: Reading DCCM with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, wdata, rdata);
        //          }
        //          break;
        //        case MR:
        //          if (argmap["reset_ddr"].length() > 0) {
        //            fprintf(stderr, "BG: DDR MRs\n");
        //            OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x14 << 2), 0x00000500);
        //            OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x00000011);
        //            OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x80000011);

        //            rdata = 0x1;
        //            while ((rdata & 0x1) != 0) {
        //              OURSBUS_READ_4B (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x18 << 2), rdata); 
        //            }
        //            OURSBUS_READ (STATION_DDR_TOP_B2S_RD_MRR_DATA_ADDR, orig_data);
        //            if((orig_data & 0xff) != 0xff) {
        //              fprintf(stderr, "Error: MR5 value is 0x%x\n", orig_data);
        //            }

        //            //Read MR6
        //            OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x14 << 2), 0x00000600);
        //            OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x00000011);
        //            OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x80000011);

        //            rdata = 0x1;
        //            while ((rdata & 0x1) != 0) {
        //              OURSBUS_READ_4B (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x18 << 2), rdata); 
        //            }
        //            OURSBUS_READ (STATION_DDR_TOP_B2S_RD_MRR_DATA_ADDR, orig_data); //DDR2RB
        //            orig_data = (orig_data >> 9) & 0xff; // take out bit[25:9]
        //            if(orig_data != 0) {
        //              fprintf(stderr, "Error: MR6 value is 0x%x\n", orig_data);
        //            }
        //          }
        //          break;
        //      }
        //      // Disable access to PHY registers
        //      OURSBUS_WRITE(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0099 << 2), 0x1);
        //      OURSBUS_WRITE(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0000 << 2), 0x1);
        //      break;
        //    case USB:
        //      // USB
        //      fprintf(stderr, "BG: USB\n");
        //      OURSBUS_WRITE(STATION_USB_TOP_S2B_VCC_RESET_N_ADDR, 0x1);
        //      wdata = random();
        //      OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc128, wdata);
        //      OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc128, rdata);
        //      if (rdata != wdata) {
        //        fprintf(stderr, "Error: USB GUID access wrong, wdata = 0x%x, rdata = 0x%x\n", wdata, rdata);
        //      }
        //      break;
        //    case SDIO:
        //      fprintf(stderr, "BG: SDIO\n");
        //      wdata = random();
        //      OURSBUS_WRITE(STATION_SDIO_MSHC_CTRL_ADDR + 0x34, wdata);
        //      OURSBUS_READ_4B(STATION_SDIO_MSHC_CTRL_ADDR + 0x34, rdata);
        //      if ((rdata & 0xff) != (wdata & 0xff)) {
        //        fprintf(stderr, "Error: SDIO Reg access data mismatch, wdata = 0x%x, rdata = 0x%x\n", wdata, rdata);
        //      }
        //      break;
        //    case ORV32:
        //      fprintf(stderr, "BG: ORV32\n");
        //      target = weighted_random(bg_target_orv32_weight_map);
        //      switch (static_cast<bg_target_orv32_e>(target)) {
        //        case ORV32_TCM:
        //          wdata = random();
        //          addr = (random() % STATION_ORV32_ITB_ADDR) & 0xfffffffc;
        //          OURSBUS_WRITE(addr, wdata);
        //          OURSBUS_READ_4B(addr, rdata);
        //          if (rdata != wdata) {
        //            fprintf(stderr, "Warning: ORV32 TCM access wrong, addr = 0x%x, wdata = 0x%x, rdata = 0x%x\n", addr, wdata, rdata);
        //          }
        //          break;
        //        case ORV32_ITB:
        //          OURSBUS_WRITE(STATION_ORV32_S2B_CFG_ITB_EN_ADDR, 1); // Enalbe ITB
        //          addr = ((random() % 0x80)  + STATION_ORV32_ITB_ADDR) & 0xffffffc;
        //          OURSBUS_READ_4B(addr, rdata);
        //          if (rdata < 0x80000000) {
        //            fprintf(stderr, "Warning: ORV32 ITB data wrong, addr = 0x%x rdata = 0x%x\n", addr, rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_ORV32_B2S_ITB_LAST_PTR_ADDR, rdata);
        //          if ((rdata < STATION_ORV32_ITB_ADDR) || (rdata >= STATION_ORV32_S2B_CFG_RST_PC_ADDR)) {
        //            fprintf(stderr, "Warning: ORV32 ITB last ptr wrong, rdata = 0x%x\n", rdata);
        //          }
        //          break;
        //        case ORV32_PC:
        //          OURSBUS_READ_4B(STATION_ORV32_IF_PC_ADDR, rdata);
        //          if (rdata < 0x80000000) {
        //            fprintf(stderr, "Error: Unrecognized ORV32 IF PC, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_ORV32_WB_PC_ADDR, rdata);
        //          if (rdata < 0x80000000) {
        //            fprintf(stderr, "Error: Unrecognized ORV32 WB PC, rdata = 0x%x\n", rdata);
        //          }
        //          break;
        //        case ORV32_MISC:
        //          addr = (random() % (STATION_ORV32_HPMCOUNTER_3_OFFSET - STATION_ORV32_CS2MA_EXCP_ADDR)) + STATION_ORV32_CS2MA_EXCP_OFFSET;
        //          OURSBUS_READ_4B(addr, rdata);
        //          break;
        //        case ORV32_HPM:
        //          OURSBUS_WRITE(STATION_ORV32_S2B_CFG_EN_HPMCOUNTER_ADDR, 1);
        //          addr = ((random() % 8) << 3) + STATION_ORV32_HPMCOUNTER_3_ADDR;
        //          OURSBUS_READ_4B(addr, rdata);
        //          // TODO: how to check
        //          break;
        //        case ORV32_PIPE:
        //          addr = ((random() % (STATION_ORV32_MA2CS_EXCP_VALID_ADDR + 1 - STATION_ORV32_IF_STALL_ADDR)) + STATION_ORV32_IF_STALL_ADDR) & 0xffffff8;
        //          OURSBUS_READ_4B(addr, rdata);
        //          // TODO: how to check
        //          break;
        //      }
        //      break;
        //    case VP:
        //      fprintf(stderr, "BG: VP\n");
        //      target = weighted_random(bg_target_orv64_weight_map);
        //      switch (static_cast<bg_target_orv64_e>(target)) {
        //        //case VP_IC:
        //        //  wdata = random();
        //        //  addr = ((random() % STATION_VP_ITB_DATA_OFFSET) + STATION_VP_IC_DATA_WAY_0_ADDR_0) & 0xfffffff8;
        //        //  OURSBUS_WRITE(addr, wdata);
        //        //  OURSBUS_READ_4B(addr, rdata);
        //        //  if (rdata != wdata) {
        //        //    fprintf(stderr, "Error: ORV64 IC access wrong, addr = 0x%x, wdata = 0x%x, rdata = 0x%x\n", addr, wdata, rdata);
        //        //  }
        //        //  break;
        //        case VP_ITB:
        //          OURSBUS_WRITE(STATION_VP_S2B_CFG_ITB_EN_ADDR_0, 1); // Enalbe ITB
        //          addr = ((random() % 0x80)  + STATION_VP_ITB_DATA_ADDR_0) & 0xffffff8;
        //          OURSBUS_READ_4B(addr, rdata);
        //          if (argmap["disable_pc_chk"].length() > 0) {
        //            fprintf(stderr, "ORV64 ITB access get virtual pc, rdata = 0x%x\n", rdata);
        //          } else {
        //            fprintf(stderr, "Warning: ORV64 ITB access get wrong pc, rdata = 0x%x\n", rdata);
        //          }
        //          OURSBUS_READ_4B(STATION_VP_B2S_ITB_LAST_PTR_ADDR_0, rdata);
        //          if ((rdata < STATION_VP_ITB_DATA_ADDR_0) || (rdata >= STATION_VP_IBUF_LINE_DATA_ADDR_0__DEPTH_0)) {
        //            fprintf(stderr, "Warning: ORV64 ITB last ptr wrong, rdata = 0x%x\n", rdata);
        //          }
        //          break;
        //        case VP_IBUF:
        //          OURSBUS_READ_4B(STATION_VP_IBUF_LINE_PADDR_ADDR_0__DEPTH_0, rdata);
        //          OURSBUS_READ_4B(STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_0__DEPTH_1, rdata);
        //          break;
        //        case VP_ITLB:
        //          addr = ((random() % 8) << 3) + STATION_VP_ITLB_ASID_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
        //          OURSBUS_READ_4B(addr, rdata);
        //          addr = ((random() % 8) << 3) + STATION_VP_ITLB_VPN_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
        //          OURSBUS_READ_4B(addr, rdata);
        //          addr = ((random() % 8) << 3) + STATION_VP_ITLB_PTE_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
        //          OURSBUS_READ_4B(addr, rdata);
        //          break;
        //        case VP_DTLB:
        //          addr = ((random() % 8) << 3) + STATION_VP_DTLB_ASID_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
        //          OURSBUS_READ_4B(addr, rdata);
        //          addr = ((random() % 8) << 3) + STATION_VP_DTLB_VPN_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
        //          OURSBUS_READ_4B(addr, rdata);
        //          addr = ((random() % 8) << 3) + STATION_VP_DTLB_PTE_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
        //          OURSBUS_READ_4B(addr, rdata);
        //          break;
        //        case VP_VTLB:
        //          addr = ((random() % 8) << 3) + STATION_VP_VTLB_ASID_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
        //          OURSBUS_READ_4B(addr, rdata);
        //          addr = ((random() % 8) << 3) + STATION_VP_VTLB_VPN_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
        //          OURSBUS_READ_4B(addr, rdata);
        //          addr = ((random() % 8) << 3) + STATION_VP_VTLB_PTE_OFFSET__DEPTH_0 + STATION_VP_BASE_ADDR_0;
        //          OURSBUS_READ_4B(addr, rdata);
        //          break;
        //        case VP_PC:
        //          OURSBUS_READ_4B(STATION_VP_IF_PC_ADDR_0, rdata);
        //          if (rdata < 0x80000000) {
        //            if (argmap["disable_pc_chk"].length() > 0) {
        //              fprintf(stderr, "Virtual ORV64 IF PC, rdata = 0x%x\n", rdata);
        //            } else {
        //              fprintf(stderr, "Error: Unrecognized ORV64 IF PC, rdata = 0x%x\n", rdata);
        //            }
        //          }
        //          OURSBUS_READ_4B(STATION_VP_WB_PC_ADDR_0, rdata);
        //          if (rdata < 0x80000000) {
        //            if (argmap["disable_pc_chk"].length() > 0) {
        //              fprintf(stderr, "Virtual ORV64 WB PC, rdata = 0x%x\n", rdata);
        //            } else {
        //              fprintf(stderr, "Error: Unrecognized ORV64 WB PC, rdata = 0x%x\n", rdata);
        //            }
        //          }
        //          break;
        //        case VP_PIPE:
        //          break;
        //        case VP_MISC:
        //          break;
        //        case VP_HPM:
        //          OURSBUS_WRITE(STATION_VP_S2B_CFG_EN_HPMCOUNTER_ADDR_0, 1);
        //          addr = ((random() % 14) << 3) + STATION_VP_HPMCOUNTER_3_OFFSET + STATION_VP_BASE_ADDR_0;
        //          OURSBUS_READ_4B(addr, rdata);
        //          // TODO: how to check
        //          break;
        //      }
        //      break;
        //    case FLUSH:
        //      uint64_t cmd_vld;
        //      fprintf(stderr, "BG: DMA FLUSH\n");
        //      // Check cmd vld, if it's 1 then skip
        //      OURSBUS_READ_4B(STATION_DMA_DMA_FLUSH_CMD_VLD_ADDR, cmd_vld);
        //      if (!cmd_vld) {
        //        uint64_t flush_addr = (random() % 0x80000000) + 0x80000000;
        //        target = weighted_random(bg_target_flush_weight_map);
        //        switch (static_cast<bg_target_flush_e>(target)) {
        //          case FLUSH_ADDR:
        //            OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_REQ_TYPE_ADDR, 0);
        //            OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_ADDR_ADDR, flush_addr);
        //            OURSBUS_WRITE(STATION_DMA_DMA_FLUSH_CMD_VLD_ADDR, 1);
        //            break;
        //          case FLUSH_IDX:
        //            OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_REQ_TYPE_ADDR, 1);
        //            OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_ADDR_ADDR, flush_addr);
        //            OURSBUS_WRITE(STATION_DMA_DMA_FLUSH_CMD_VLD_ADDR, 1);
        //            break;
        //          case FLUSH_ALL:
        //            OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_REQ_TYPE_ADDR, 2);
        //            OURSBUS_WRITE(STATION_DMA_S2B_DMA_FLUSH_ADDR_ADDR, flush_addr);
        //            OURSBUS_WRITE(STATION_DMA_DMA_FLUSH_CMD_VLD_ADDR, 1);
        //            break;
        //        }
        //      }
        //      break;
        //    case IDLE:
        //      //fprintf(stderr, "IDLING\n"); 
        //      idle();
        //      break;
        //    default:
        //      fprintf(stderr, "UNKNOW Background Traffic\n");
        //      break;
        //  }
        //}
      } else {
        //fprintf(stderr, "IDLING\n"); 
        idle();
      }
    }

    device_list.tick();

    if (!fromhost_queue.empty() && mem.read_uint64(fromhost_addr) == 0) {
      mem.write_uint64(fromhost_addr, fromhost_queue.front());
      fromhost_queue.pop();
    }

    // Unblock wfe
    if (wfe_flag) {
      wfe_flag = false;
      if(log_step & (exitcode == 0)) {
        std::string mode = argmap["log_step="];
        if (mode.compare("beak") == 0) { 
          OURSBUS_WRITE(0x00801000, 1);
        } else if (mode.compare("orv32") == 0) { 
          OURSBUS_WRITE(STATION_ORV32_S2B_EXT_EVENT_ADDR, 1);
#if PROJ_NUM != PYGMY_E
        } else if (mode.compare("single_vp") == 0) { 
          OURSBUS_WRITE(STATION_VP_S2B_EXT_EVENT_ADDR_0, 1);
        } else {
          OURSBUS_WRITE(STATION_VP_S2B_EXT_EVENT_ADDR_0, 1);
          OURSBUS_WRITE(STATION_VP_S2B_EXT_EVENT_ADDR_1, 1);
          OURSBUS_WRITE(STATION_VP_S2B_EXT_EVENT_ADDR_2, 1);
          OURSBUS_WRITE(STATION_VP_S2B_EXT_EVENT_ADDR_3, 1);
#endif
        }
      }
    }
  }

  // ====================================
  // Performance Report
  // ====================================
  if (argmap["perf_report"].length() > 0) {
    uint8_t reg[8];
    uint64_t data;
    uint64_t mp_perf[18];
    uint64_t cp_perf[12][18];
    uint64_t vc_perf[12][33];
    uint64_t l2_perf[8][9];
    if (argmap["release_orv_reset"].length() > 0) { // MP
      for (int index = 0; index < 18; index ++) {
        for (int msb = 0; msb < 2; msb ++) {
          fprintf(stderr, "Start Fetching MP Performance Counter with Index %0d MSB %0d\n", index, msb);
          reg[0] = 0x00; // data == 0
          reg[1] = 0x00;
          reg[2] = 0x00;
          reg[3] = 0x00;
          reg[4] = index; // addr = {'b01 + 1'bmsb + 1'b0 + 12'bindex}
          reg[5] = (1 << 6) + (msb << 5);
          reg[6] = 0x80; // 'b10 + 4'b0 + 00
          reg[7] = 0x01; // valid
          mem.write(0x8000000000 + 8 * 5, 8, (uint8_t*)reg);
          do {
            OURSBUS_READ_4B(0x8000000000 + 8 * 0x97, data);
          } while (((data >> 24) & 0x1) == 0);
          OURSBUS_READ(0x8000000000 + 8 * 0x97, data);
          fprintf(stderr, "Done Fetching MP Performance Counter with Index %0d MSB %0d Got Value 0x%x\n", index, msb, data >> 32);
          mp_perf[index] = mp_perf[index] | ((data >> 32) << (32 * msb));
        }
      }
    }
    if ((argmap["release_vcore_reset"].length() > 0) && (argmap["release_orv_reset"].length() > 0)) { // CP
      for (int vcore = 0; vcore < 12; vcore ++) {
        for (int index = 0; index < 18; index ++) {
          for (int msb = 0; msb < 2; msb ++) {
            fprintf(stderr, "Start Fetching CP %0d Performance Counter with Index %0d MSB %0d\n", vcore, index, msb);
            reg[0] = 0x00; // data == 0
            reg[1] = 0x00;
            reg[2] = 0x00;
            reg[3] = 0x00;
            reg[4] = index; // addr = {'b01 + 1'bmsb + 1'b0 + 12'bindex}
            reg[5] = (0x1 << 6) + (msb << 5);
            reg[6] = vcore << 2; // 'b00 + 4'bvcore_id + 00
            reg[7] = 0x01; // valid
            mem.write(0x8000000000 + 8 * 5, 8, (uint8_t*)reg);
            do {
              OURSBUS_READ_4B(0x8000000000 + 8 * 0x97, data);
            } while (((data >> 24) & 0x1) == 0);
            OURSBUS_READ(0x8000000000 + 8 * 0x97, data);
            fprintf(stderr, "Done Fetching CP %0d Performance Counter with Index %0d MSB %0d Got Value 0x%x\n", vcore, index, msb, data >> 32);
            cp_perf[vcore][index] = cp_perf[vcore][index] | ((data >> 32) << (32 * msb));
          }
        }
      }
    }
    if ((argmap["release_vcore_reset"].length() > 0)) { // VCORE
      for (int vcore = 0; vcore < 12; vcore ++) {
        for (int index = 1; index < 33; index ++) {
          for (int msb = 0; msb < 2; msb ++) {
            fprintf(stderr, "Start Fetching VCORE %0d Performance Counter with Index %0d MSB %0d\n", vcore, index, msb);
            reg[0] = 0x00; // data == 0
            reg[1] = 0x00;
            reg[2] = 0x00;
            reg[3] = 0x00;
            reg[4] = index; // addr = {'b00 + 1'bmsb + 0 + 12'bindex}
            reg[5] = msb << 5;
            reg[6] = vcore << 2; // 'b00 + 4'bvcore_id + 00
            reg[7] = 0x01; // valid
            mem.write(0x8000000000 + 8 * 5, 8, (uint8_t*)reg);
            do {
              OURSBUS_READ_4B(0x8000000000 + 8 * 0x97, data);
            } while (((data >> 24) & 0x1) == 0);
            OURSBUS_READ(0x8000000000 + 8 * 0x97, data);
            fprintf(stderr, "Done Fetching VCORE %0d Performance Counter with Index %0d MSB %0d Got Value 0x%x\n", vcore, index, msb, data >> 32);
            vc_perf[vcore][index] = vc_perf[vcore][index] | ((data >> 32) << (32 * msb));
          }
        }
      }
    }
    // L2
    for (int bank = 0; bank < 8; bank ++) {
      for (int index = 0; index < 9; index ++) {
        fprintf(stderr, "Start Fetching L2 Bank %0d Performance Counter with Index %0d\n", bank, index);
        OURSBUS_READ(0xb400000000 + (bank << 14) + (index << 3), data);
        fprintf(stderr, "Done Fetching L2 Bank %0d Performance Counter with Index %0d, Got Value 0x%x\n", bank, index, data);
        l2_perf[bank][index] = data;
      }
    }
    // Generate Report
    std::map<std::string, double> perf;
    std::map<std::string, int> orv_entry;
    std::map<std::string, int> vc_entry;
    std::map<std::string, int> l2_entry;

    orv_entry["Machine Cycle"] = 6;
    orv_entry["Instruction Count"] = 7;
    orv_entry["Wait For NPC"] = 10;
    orv_entry["Wait For Register Dependancy"] = 11;
    orv_entry["Instruction Killed"] = 12;
    orv_entry["Wait For ICache Read"] = 13;
    orv_entry["ICache Hit"] = 16;
    orv_entry["ICache Miss"] = 17;

    for (std::map<std::string, int>::iterator it = orv_entry.begin(); it != orv_entry.end(); ++it) {
      perf["MP " + it->first] = mp_perf[it->second];
      for (int vcore = 0; vcore < 12; vcore ++) {
        perf["CP[" + std::to_string(vcore) + "] " + it->first] = cp_perf[vcore][it->second];
      }
    }

    perf["MP ICache Hit Rate"] = perf["MP ICache Hit"] / (perf["MP ICache Hit"] + perf["MP ICache Miss"]);
    for (int vcore = 0; vcore < 12; vcore ++) {
      perf["CP[" + std::to_string(vcore) + "] ICache Hit Rate"] = perf["CP[" + std::to_string(vcore) + "] ICache Hit"] / (perf["CP[" + std::to_string(vcore) + "] ICache Hit"] + perf["CP[" + std::to_string(vcore) + "] ICache Miss"]);
    }

    vc_entry["Execution Start Count"] = 3;
    vc_entry["Execution Done Count"] = 4;
    vc_entry["Execution Cycle Count"] = 5;
    vc_entry["Total Instruction Count"] = 6;
    vc_entry["Vector Instruction Count"] = 7;
    vc_entry["Vector Regfile WR Request Count"] = 24;
    vc_entry["Vector Regfile RD0 Request Count"] = 25;
    vc_entry["Vector Regfile RD1 Request Count"] = 26;
    vc_entry["VLOAD Request Count"] = 27;
    vc_entry["VLOAD Response Count"] = 28;
    vc_entry["VSTORE Request Count"] = 29;
    vc_entry["L2 WR Request Count"] = 30;
    vc_entry["L2 RD Request Count"] = 31;
    vc_entry["L2 RD Response Count"] = 32;

    for (std::map<std::string, int>::iterator it = vc_entry.begin(); it != vc_entry.end(); ++it) {
      for (int vcore = 0; vcore < 12; vcore ++) {
        perf["VCORE[" + std::to_string(vcore) + "] " + it->first] = vc_perf[vcore][it->second];
      }
    }

    l2_entry["MSHR Valid"] = 0;
    l2_entry["S1 Stall"] = 1;
    l2_entry["S2 Stall"] = 2;
    l2_entry["S3 Stall"] = 3;
    l2_entry["S4 Stall"] = 4;
    l2_entry["Read Hit"] = 5;
    l2_entry["Read Miss"] = 6;
    l2_entry["Write Hit"] = 7;
    l2_entry["Write Miss"] = 8;

    for (std::map<std::string, int>::iterator it = l2_entry.begin(); it != l2_entry.end(); ++it) {
      for (int bank = 0; bank < 8; bank ++) {
        perf["L2 Cache Bank["  + std::to_string(bank) + "] " + it->first] = l2_perf[bank][it->second];
      }
    }

    for (std::map<std::string, double>::iterator it = perf.begin(); it != perf.end(); ++it) {
      fprintf(stderr, "%s: %f\n", it->first.c_str(), it->second);
    }
  }
  // ====================================
  // Performance Report
  // ====================================

  stop();

  return exit_code();
}

bool htif_t::done()
{
  return stopped;
}

int htif_t::exit_code()
{
  return exitcode >> 1;
}

