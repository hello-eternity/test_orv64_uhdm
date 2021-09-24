#include "es1y.h"
#include <string.h>
#include <iostream>
#include <sstream>
#include <signal.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <fstream>
#include <sstream>
#include <vector>

#include "station_pll.h"
#include "station_dma.h"


static uint8_t reg[8];
static time_t ltime;

#ifndef TARGET_ARCH
# define TARGET_ARCH "riscv64-unknown-elf"
#endif

#if !defined(PREFIX) && defined(__PCONFIGURE__PREFIX)
# define PREFIX __PCONFIGURE__PREFIX
#endif


#ifndef TARGET_DIR
# define TARGET_DIR "/" TARGET_ARCH "/bin/"
#endif

#define INSNS_PER_RTC_TICK 1
#define CPU_HZ 1000000000 
#define DRAM_BASE          0x80000000
#define CLINT_BASE         STATION_PLL_BASE_ADDR
#define CLINT_SIZE         0x000c0000
#define PLIC_BASE          STATION_DMA_BASE_ADDR
#define PLIC_SIZE          0x000002a8
#define I2CM_BASE           (STATION_SLOW_IO_I2C0_BLOCK_REG_ADDR)
#define I2CM_SIZE           0x400
#define CODEC_BASE           (0x20000000)
#define CODEC_SIZE           0x4
#define I2SRX0_BASE           (STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR)
#define I2SRX0_SIZE           0x400
#define DMA_BASE           (STATION_DMA_BASE_ADDR)
#define DMA_SIZE           0x600
#define NUM_OF_INTR 35
#define SDIO_BASE          (STATION_SDIO_BASE_ADDR)
#define SDIO_SIZE          0x00002000
#define SPIM_BASE           (STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR)
#define SPIM_SIZE           0x400
#define SPIS_BASE           (STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR)
#define SPIS_SIZE           0x400
#define PGSHIFT 12
#define PGSIZE  (1 << PGSHIFT)
#define DTC "/usr/bin/dtc"

enum {
        DBG_EN_BASE = STATION_DMA_S2B_PLIC_DBG_EN_OFFSET__DEPTH_0,
        INTR_EN_BASE = STATION_DMA_S2B_PLIC_INTR_EN_OFFSET__DEPTH_0,
        INTR_CORE_ID_BASE = STATION_DMA_S2B_PLIC_INTR_CORE_ID_OFFSET__DEPTH_0,
        INTR_SRC_BASE = STATION_DMA_B2S_PLIC_INTR_SRC_OFFSET__DEPTH_0,
};

enum {
        AXI_DMAC_TYPE_MM = 0, //Memory mapped AXI interface
        AXI_DMAC_TYPE_STREAM = 1, //Streaming AXI interface
        AXI_DMAC_TYPE_FIFO = 2, //FIFO interface
};
// HELPERS
std::vector<std::string> split(const std::string& s, char delimiter)
{
   std::vector<std::string> tokens;
   std::string token;
   std::istringstream tokenStream(s);
   while (std::getline(tokenStream, token, delimiter))
   {
      tokens.push_back(token);
   }
   return tokens;
}

char* multi_tok(char *s, char * delimiter)
{
    static char *string;
    if (s != NULL)
        string = s;

    if (string == NULL)
        return string;
    char *end = strstr(string, delimiter);
    if (end == NULL) {
        char *temp = string;
        string = NULL;
        return temp;
    }

    char *temp = string;

    *end = '\0';
    string = end + strlen(delimiter);
    return temp;
}

std::vector<std::string> split_multi(const std::string& s, char * delimiter)
{
  std::vector<std::string> tokens;
  char *c_s = new char[s.length() + 1];
  strcpy(c_s, s.c_str());
  char * token = multi_tok(c_s, delimiter);
  std::string str;
  while (token != NULL) {
    str.assign(token);
    tokens.push_back(str);
    //printf("%s\n", token);
    token = multi_tok(NULL, delimiter);
  }
  delete [] c_s;
  return tokens;

}

std::vector<uint64_t> get_breakpoints(std::string breakpoints){
  std::vector<uint64_t> breakpoint_vals;
  std::string delimiter = "_";
  size_t pos = 0;
  size_t sz;
  std::string bp;
  while ((pos=breakpoints.find(delimiter)) != std::string::npos) {
    bp = breakpoints.substr(0,pos);
    breakpoint_vals.push_back(std::stoul(bp));
    breakpoints.erase(0, pos + delimiter.length());
  }
  return breakpoint_vals;
}

void es1y::set_breakpoints(std::vector<uint64_t> station_en_addr, std::vector<uint64_t> station_addr, std::vector<uint64_t> breakpoints){
  for (int i = 0; i < breakpoints.size(); i++){
    int idx = random() % station_en_addr.size();
    uint64_t en_addr = station_en_addr.at(idx);
    uint64_t addr = station_addr.at(idx);
    station_en_addr.erase(station_en_addr.begin() + idx);
    station_addr.erase(station_addr.begin() + idx);
    this->ht->OURSBUS_WRITE(en_addr, 0x00000001);
    this->ht->OURSBUS_WRITE(addr, breakpoints.at(i));
  }
}

static std::vector<std::pair<reg_t, mem_t*>> make_mems(const char* arg)
{
  // handle legacy mem argument
  char* p;
  auto mb = strtoull(arg, &p, 0);
  if (*p == 0) {
    reg_t size = reg_t(mb) << 20;
    if (size != (size_t)size)
      throw std::runtime_error("Size would overflow size_t");
    return std::vector<std::pair<reg_t, mem_t*>>(1, std::make_pair(reg_t(DRAM_BASE), new mem_t(size)));
  }

  // handle base/size tuples
  std::vector<std::pair<reg_t, mem_t*>> res;
  while (true) {
    auto base = strtoull(arg, &p, 0);
    if (!*p || *p != ':')
      exit(-1);
    auto size = strtoull(p + 1, &p, 0);
    if ((size | base) % PGSIZE != 0)
      exit(-1);
    res.push_back(std::make_pair(reg_t(base), new mem_t(size)));
    if (!*p)
      break;
    if (*p != ',')
      exit(-1);
    arg = p + 1;
  }
  return res;
}

static std::string dts_compile(const std::string& dts)
{
  // Convert the DTS to DTB
  int dts_pipe[2];
  pid_t dts_pid;

  fflush(NULL); // flush stdout/stderr before forking
  if (pipe(dts_pipe) != 0 || (dts_pid = fork()) < 0) {
    std::cerr << "Failed to fork dts child: " << strerror(errno) << std::endl;
    exit(1);
  }

  // Child process to output dts
  if (dts_pid == 0) {
    close(dts_pipe[0]);
    int step, len = dts.length();
    const char *buf = dts.c_str();
    for (int done = 0; done < len; done += step) {
      step = write(dts_pipe[1], buf+done, len-done);
      if (step == -1) {
        std::cerr << "Failed to write dts: " << strerror(errno) << std::endl;
        exit(1);
      }
    }
    close(dts_pipe[1]);
    exit(0);
  }

  pid_t dtb_pid;
  int dtb_pipe[2];
  if (pipe(dtb_pipe) != 0 || (dtb_pid = fork()) < 0) {
    std::cerr << "Failed to fork dtb child: " << strerror(errno) << std::endl;
    exit(1);
  }

  // Child process to output dtb
  if (dtb_pid == 0) {
    dup2(dts_pipe[0], 0);
    dup2(dtb_pipe[1], 1);
    close(dts_pipe[0]);
    close(dts_pipe[1]);
    close(dtb_pipe[0]);
    close(dtb_pipe[1]);
    execl(DTC, DTC, "-O", "dtb", 0);
    std::cerr << "Failed to run " DTC ": " << strerror(errno) << std::endl;
    exit(1);
  }

  close(dts_pipe[1]);
  close(dts_pipe[0]);
  close(dtb_pipe[1]);

  // Read-out dtb
  std::stringstream dtb;

  int got;
  char buf[4096];
  while ((got = read(dtb_pipe[0], buf, sizeof(buf))) > 0) {
    dtb.write(buf, got);
  }
  if (got == -1) {
    std::cerr << "Failed to read dtb: " << strerror(errno) << std::endl;
    exit(1);
  }
  close(dtb_pipe[0]);

  // Reap children
  int status;
  waitpid(dts_pid, &status, 0);
  if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
    std::cerr << "Child dts process failed" << std::endl;
    exit(1);
  }
  waitpid(dtb_pid, &status, 0);
  if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
    std::cerr << "Child dtb process failed" << std::endl;
    exit(1);
  }

  return dtb.str();
}

std::string make_dts(size_t insns_per_rtc_tick, size_t cpu_hz,
                     uint64_t num_cores, uint64_t max_xlen, std::string isa,
                     std::vector<std::pair<reg_t, mem_t*>> mems)
{
  std::stringstream s;
  reg_t plicbs = PLIC_BASE;
  reg_t plicsz = PLIC_SIZE;

  reg_t sdiosz = SDIO_SIZE;
  reg_t sdiobs = SDIO_BASE;
  reg_t spimsz = SPIM_SIZE;
  reg_t spimbs = SPIM_BASE;
  reg_t spissz = SPIS_SIZE;
  reg_t spisbs = SPIS_BASE;
  reg_t i2cmsz = I2CM_SIZE;
  reg_t i2cmbs = I2CM_BASE;
  reg_t codecsz = CODEC_SIZE;
  reg_t codecbs = CODEC_BASE;
  reg_t i2srx0sz = I2SRX0_SIZE;
  reg_t i2srx0bs = I2SRX0_BASE;
  reg_t dmasz = DMA_SIZE;
  reg_t dmabs = DMA_BASE;

  s << std::dec <<
         "/dts-v1/;\n"
         "\n"
         "/ {\n"
         "  #address-cells = <2>;\n"
         "  #size-cells = <2>;\n"
         "  compatible = \"ucbbar,spike-bare-dev\";\n"
         "  model = \"ucbbar,spike-bare\";\n";
  
  s << std::dec <<"  chosen {\n"
	  "       bootargs = \"console=hvc0 earlycon=sbi\";\n"
	  "  };\n";
  s << std::dec <<
         "  cpus {\n"
         "    #address-cells = <1>;\n"
         "    #size-cells = <0>;\n"
         "    timebase-frequency = <" << (cpu_hz/insns_per_rtc_tick) << ">;\n";

  for (size_t i = 0; i < num_cores; i++) {
    s << "    CPU" << i << ": cpu@" << i << " {\n"
         "      device_type = \"cpu\";\n"
         "      reg = <" << i << ">;\n"
         "      status = \"okay\";\n"
         "      compatible = \"riscv\";\n"
         //"      riscv,isa = \"" << procs[i]->get_isa_string() << "\";\n"
         "      riscv,isa = \"" << isa << "\";\n"
         //"      mmu-type = \"riscv," << (procs[i]->get_max_xlen() <= 32 ? "sv32" : "sv39") << "\";\n"
         // max_xlen == 0 means max_vlen == 32
         "      mmu-type = \"riscv," << (max_xlen <= 0 ? "sv32" : "sv39") << "\";\n"
         "      clock-frequency = <" << cpu_hz << ">;\n"
         "      CPU" << i << "_intc: interrupt-controller {\n"
         "        #interrupt-cells = <1>;\n"
         "        interrupt-controller;\n"
         "        compatible = \"riscv,cpu-intc\";\n"
         "      };\n"
         "    };\n";
  }
  s <<   "  };\n";
  for (auto& m : mems) {
    s << std::hex <<
         "  memory@" << m.first << " {\n"
         "    device_type = \"memory\";\n"
         "    reg = <0x" << (m.first >> 32) << " 0x" << (m.first & (uint32_t)-1) <<
                   " 0x" << (m.second->size() >> 32) << " 0x" << (m.second->size() & (uint32_t)-1) << ">;\n"
         "  };\n";
  }
  s <<   "  soc {\n"
         "    #address-cells = <2>;\n"
         "    #size-cells = <2>;\n"
         "    compatible = \"ucbbar,spike-bare-soc\", \"simple-bus\";\n"
         "    ranges;\n";
#if 1//plic
         s<<"    plic0: interrupt-controller@" << plicbs << " {\n"
         "      #interrupt-cells = <1>;\n"
         "      compatible = \"rivai,plic-1.0.0\";\n"
         "      interrupt-controller;\n"
         "      regs_base = <0x"<<DBG_EN_BASE<<" 0x"<<INTR_EN_BASE<<" 0x"<<INTR_CORE_ID_BASE<<" 0x"<<INTR_SRC_BASE<<">;\n"
	 "      reg = <0x" << (plicbs >> 32) << " 0x" << (plicbs & (uint32_t)-1) <<
                     " 0x" << (plicsz >> 32) << " 0x" << (plicsz & (uint32_t)-1) << ">;\n";
         s<<std::dec<<"      riscv,ndev = <" << NUM_OF_INTR << ">;\n"
         "    };\n";
#endif
#if 0//sdio
         s << std::hex << "    sdhci0: sdhci@" << sdiobs << " {\n"
         "      #interrupt-cells = <1>;\n"
         "      compatible = \"snps,dwcmshc-sdhci\";\n"
         "      reg = <0x" << (sdiobs >> 32) << " 0x" << (sdiobs & (uint32_t)-1) <<
                     " 0x" << (sdiosz >> 32) << " 0x" << (sdiosz & (uint32_t)-1) << ">;\n"
	 "      interrupt-parent = <&plic0>;\n";
         s << std::dec << "      interrupts = <" << 11 << ">;\n"
         "      bus-width = <4>;\n"
         "    };\n";
#endif
#if 0//usb
         s<< std::hex <<"    usb0: usb3@" << 0x700000 << " {\n"
         "      compatible = \"snps,dwc3\";\n"
         "      reg = <0x" << 0 << " 0x" << 0x700000 <<
                      " 0x" << 0 << " 0x" << 0x100000 << ">;\n"
         "      interrupt-parent = <&plic0>;\n";
         s<<std::dec<<"      interrupts = <" << 25 << ">;\n"
         "      dr_mode = \"peripheral\";\n"
//         "      maximum-speed = \"high-speed\";\n"
         "      maximum-speed = \"super-speed\";\n"
         "      snps,incr-burst-type-adjustment = <4>;\n"
         "    };\n";
#endif
	 
#if 0//spim
  s << std::hex <<"    spim0: spim@" << spimbs << " {\n"
         "      #interrupt-cells = <1>;\n"
         "      compatible = \"snps,dw-apb-ssi\";\n"
         "      reg = <0x" << (spimbs >> 32) << " 0x" << (spimbs & (uint32_t)-1) <<
                     " 0x" << (spimsz >> 32) << " 0x" << (spimsz & (uint32_t)-1) << ">;\n"
         "      interrupt-parent = <&plic0>;\n";
         s << std::dec << "      interrupts = <" << 1 << ">;\n"

         "      reg-io-width = <4>;\n"
         "      bus-width = <4>;\n"
         "    	#address-cells = <1>;\n"
         "    	#size-cells = <0>;\n"
         "      m25p80@0 { \n"
         "               compatible = \"m25p80\";\n"
         "               spi-max-frequency = <250000>;\n"
         "               reg = <0>;\n"
         "       };\n"
         "    };\n";
#endif
#if 0//spis
  s << std::hex <<"    spis0: spis@" << spisbs << " {\n"
         "      #interrupt-cells = <1>;\n"
         "      compatible = \"snps,dwcmshc-spis\";\n"
         "      reg = <0x" << (spisbs >> 32) << " 0x" << (spisbs & (uint32_t)-1) <<
                     " 0x" << (spissz >> 32) << " 0x" << (spissz & (uint32_t)-1) << ">;\n"
         "      interrupt-parent = <&plic0>;\n";
         s << std::dec << "      interrupts = <" << 9 << ">;\n"

         "      bus-width = <4>;\n"
         "    };\n";
#endif
#if 1// axi dma
  s << std::hex <<"    dma: dma@" << dmabs << " {\n"
         "      #interrupt-cells = <1>;\n"
         "      compatible = \"adi,axi-dmac-1.00.a\";\n"
         "      reg = <0x" << (dmabs >> 32) << " 0x" << (dmabs & (uint32_t)-1) <<
                     " 0x" << (dmasz >> 32) << " 0x" << (dmasz & (uint32_t)-1) << ">;\n"
         "      interrupt-parent = <&plic0>;\n";
  s << std::dec <<"      interrupts = <31" <<
				" 32" << ">;\n";
  s << std::hex <<"\n"
	  "      #dma-cells = <1>;\n"
	  "	adi,channels {\n"
	  "       #size-cells = <0>;\n"
	  "       #address-cells = <1>;\n"
	  "       dma-channel@0 {\n"
	  "               reg = <0>;\n"
	  "               adi,source-bus-width = <32>;\n"
	  "               adi,source-bus-type = <" << AXI_DMAC_TYPE_FIFO << ">;\n"
	  "               adi,destination-bus-width = <32>;\n"
	  "               adi,destination-bus-type = <" << AXI_DMAC_TYPE_MM << ">;\n"
	  "       };\n"
	  "       };\n"
	  "    };\n";
#endif
#if 0//i2cm
  s << std::hex <<"    i2cm0: i2cm@" << i2cmbs << " {\n"
         "      #interrupt-cells = <1>;\n"
         "      compatible = \"snps,designware-i2c\";\n"
         "      reg = <0x" << (i2cmbs >> 32) << " 0x" << (i2cmbs & (uint32_t)-1) <<
                     " 0x" << (i2cmsz >> 32) << " 0x" << (i2cmsz & (uint32_t)-1) << ">;\n"
         "      interrupt-parent = <&plic0>;\n";
  s << std::dec <<"      interrupts = <16>;\n";
  s << std::hex <<"\n"
         "      bus-width = <4>;\n"
         "      bma180: bma180@14 { \n"
         "              compatible = \"bosch,bma180\";\n"
         "              reg = <0x14>;\n"
         "       };\n"
	 
         "    };\n";
#endif

#if 1//codec driver
  s << std::hex <<"    rivai_fake_codec: codec@" << codecbs << " {\n"
	 "	#sound-dai-cells = <0>;\n"
         "      #interrupt-cells = <1>;\n"
         "      compatible = \"rivai-fake-codec\";\n"
         "      reg = <0x" << (codecbs >> 32) << " 0x" << (codecbs & (uint32_t)-1) <<
                     " 0x" << (codecsz >> 32) << " 0x" << (codecsz & (uint32_t)-1) << ">;\n"
         "      interrupt-parent = <&plic0>;\n";
  s << std::hex <<"\n"
         "      bus-width = <4>;\n"

         "    };\n";
#endif
#if 1// i2srx
  s << std::hex <<"    i2srx0: i2srx@" << i2srx0bs << " {\n"
         "      #sound-dai-cells = <1>;\n"
	 "      #interrupt-cells = <1>;\n"
         "      compatible = \"snps,designware-i2s\";\n"
         "      reg = <0x" << (i2srx0bs >> 32) << " 0x" << (i2srx0bs & (uint32_t)-1) <<
                     " 0x" << (i2srx0sz >> 32) << " 0x" << (i2srx0sz & (uint32_t)-1) << ">;\n"

#if 1
         "      dmas = <&dma 0>;\n"
         "      dma-names = \"rx\";\n"
#endif
         "    };\n";
#endif
         s <<std::hex<<"    clint@" << CLINT_BASE << " {\n"
         "      compatible = \"riscv,clint0\";\n"
         "      interrupts-extended = <";
  for (size_t i = 0; i < num_cores; i++)
    s << "&CPU" << i << "_intc 3 &CPU" << i << "_intc 7 ";
  reg_t clintbs = CLINT_BASE;
  reg_t clintsz = CLINT_SIZE;
  s << std::hex << ">;\n"
         "      reg = <0x" << (clintbs >> 32) << " 0x" << (clintbs & (uint32_t)-1) <<
                     " 0x" << (clintsz >> 32) << " 0x" << (clintsz & (uint32_t)-1) << ">;\n"
         "    };\n"
         "  };\n"
         "  htif {\n"
         "    compatible = \"ucb,htif0\";\n"
         "  };\n";
#if 1 //sound
  s << std::hex <<" sound " << "{\n"
        "    compatible = \"simple-audio-card\";\n"
        "    simple-audio-card,name = \"rivai-soundcard\";\n"
        "    simple-audio-card,format = \"i2s\";\n"
#if 0
	"    simple-audio-card,bitclock-master = <&dailink0_master>;\n"
	"    simple-audio-card,frame-master = <&dailink0_master>;\n"
#endif
#if 0
        "    simple-audio-card,widgets =\n"
        "            \"Microphone, Microphone Jack\",\n"
        "    simple-audio-card,routing =\n"
        "            \"MIC_IN\", \"Microphone Jack\";\n"
#endif
        "    simple-audio-card,cpu {\n"
        "            sound-dai = <&i2srx0 0>;\n"
        "    };\n"
#if 1
	"    dailink0_master: simple-audio-card,codec {\n"
#if 1
	"    sound-dai = <&rivai_fake_codec>; \n"
#endif
	"    };\n"
#endif
        "  };\n"
#endif
         "};\n";
#if 0 //mmc
  s << std::hex <<"	&sdhci0 " << " {\n"
	"	//pinctrl-0 = <&mmc2_pins_a>;\n"
	"	//vmmc-supply = <&reg_vcc3v3>;\n"
	"        bus-width = <4>;\n"
        "    	 #address-cells = <1>;\n"
        "    	 #size-cells = <0>;\n"

        "	mmccard: mmccard@0 {\n"
        "	        reg = <0>;\n"
        "	        compatible = \"mmc-card\";\n"
        "	        broken-hpi;\n"
        "	};\n"
	"};\n";
#endif
  return s.str();
}

//static uint32_t make_dtb(uint64_t data, std::vector<std::pair<reg_t, mem_t*>> mems, uint64_t max_xlen, std::string isa, uint32_t * ret_rom[])
static uint32_t make_dtb(uint64_t data, std::vector<std::pair<reg_t, mem_t*>> mems, uint32_t * ret_rom[])
{
  uint64_t start_pc = 0x80000000;
  std::string isa_arr[] = {"i","m","a", "f", "d", "c"};
  uint8_t isa_length = 6;
  const int reset_vec_size = 8;
  
  uint8_t num_cores = data & 0xff;
  //fprintf(stderr, "DATA %016x\n", data);
  fprintf(stderr, "NUM CORES %x\n", num_cores);
  uint8_t max_xlen = (data >> 8) & 0x1;
  uint64_t hz = ((data >> 9) & 0xffff)*1000000;
  fprintf(stderr, "HZ %d\n", hz);
  uint8_t isa = (data >> 25) & 0x1;
  std::string isa_str = "rv32";
  if (isa == 0x1) {
    isa_str = "rv64";
  }
  
  isa = (data >> 26) & 0x3f;
  //fprintf(stderr, "ISA %02x\n", isa);
  for (int i= 0; i < isa_length ; ++i) {
    if (((isa >> i) & 0x1) == 0x1) {
      isa_str = isa_str + isa_arr[i]; 
    }
  }
  fprintf(stderr, "ISA: %s\n", isa_str.c_str());

  //start_pc = start_pc == reg_t(-1) ? get_entry_point() : start_pc;
  uint64_t start_pc_dtb = start_pc;

  uint32_t reset_vec[reset_vec_size] = {
    0x297,                                      // auipc  t0,0x0
    0x28593 + (reset_vec_size * 4 << 20),       // addi   a1, t0, &dtb
    0xf1402573,                                 // csrr   a0, mhartid
    //get_core(0)->get_xlen() == 32 ?
    max_xlen == 0 ? // 0 means 32, otherwise it's 64
      0x0182a283u :                             // lw     t0,24(t0)
      0x0182b283u,                              // ld     t0,24(t0)
    0x28067,                                    // jr     t0
    0,
    (uint32_t) (start_pc_dtb & 0xffffffff),
    (uint32_t) (start_pc_dtb >> 32)
  };

  std::vector<char> rom((char*)reset_vec, (char*)reset_vec + sizeof(reset_vec));

  std::string dts = make_dts(INSNS_PER_RTC_TICK, hz, num_cores, max_xlen, 
                             isa_str, mems);
  std::string dtb = dts_compile(dts);

  rom.insert(rom.end(), dtb.begin(), dtb.end());
  uint32_t tmp = 0;
  int idx = 0;
  //for (std::vector<char>::const_iterator i = rom.begin(); i != rom.end(); ++i) {
  //  tmp = tmp >> 8;
  //  tmp = tmp | ((uint32_t)(*i & 0xff) << 24);
  //  if (idx % 4 == 3)
  //    fprintf(stderr, "%08x\n", tmp);
  //  idx ++;
  //}
  //if ((idx % 4) != 0) {
  //  while ((idx % 4) != 3) {
  //    tmp = tmp >> 8;
  //    idx++;
  //  }
  //  fprintf(stderr, "%08x\n", tmp);
  //}


  const int align = 0x1000;
  rom.resize((rom.size() + align - 1) / align * align);
  
  uint64_t size = ((rom.size()/4) + 1);
  *ret_rom = new uint32_t[size];
  //uint32_t tmp = 0;
  //int idx = 0;
  tmp = 0;
  idx = 0;
  int count = 0;
  //fprintf(stderr, "ROM INFO:\n");
  for (std::vector<char>::const_iterator i = rom.begin(); i != rom.end(); ++i) {
    tmp = tmp >> 8;
    tmp = tmp | ((uint32_t)(*i & 0xff) << 24);
    if (idx % 4 == 3) {
      //fprintf(stderr, "0x%08x\n", tmp);
      (*ret_rom)[count] = tmp;
      count++;
    }
    idx ++;
  }
  if ((idx % 4) != 0) {
    while ((idx % 4) != 3) {
      tmp = tmp >> 8;
      idx++;
    }
    //fprintf(stderr, "0x%08x\n", tmp);
    (*ret_rom)[count] = tmp;
    count++;
  }

  return count;
  //return ret_rom;
}

// MAIN START UP FUNCTIONS
void es1y::setup(){
  std::vector<func_t>::iterator it = this->boot_sequence.begin();
  for (;it != this->boot_sequence.end(); ++it){
    if (strcmp(it->key.c_str(), "load_pk") == 0) {
      func_pointer run_function = it->ptr;
      (this->*run_function)(this->ht->argmap[it->key.c_str()]);
    } else {
      if(this->ht->argmap[it->key.c_str()].length()>0){
        func_pointer run_function = it->ptr;
        (this->*run_function)(this->ht->argmap[it->key.c_str()]);
      }
    }
  }
}

void es1y::incr_test_io_freq(std::string key) {
      std::string config_str = this->ht->argmap["incr_test_io_freq="];
        uint64_t value = atoi(config_str.c_str());

          printf("incr_test_io_freq: 0x%lx\n", value);
          this->ht->OURSBUS_WRITE(STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_ADDR, value);
}

void es1y::chip_config(std::string key) {
  char* pEnd;
  uint64_t data = 0;
  std::string config_str = this->ht->argmap["chip_config="];
  //std::vector<std::string> configs = split(config_str, '_');
  std::string delim = "__";
  char *c_delim = new char[delim.length() + 1];
  strcpy(c_delim, delim.c_str());
  std::vector<std::string> configs = split_multi(config_str, c_delim);
  delete [] c_delim;

  //for (auto vit = configs.begin(); vit != configs.end(); ++vit) {
  //  fprintf(stderr, " %s ", (*vit).c_str());
  //}
  for (auto vit = configs.begin(); vit != configs.end(); ++vit) {
    std::vector<std::string> config = split(*vit, '_');
    // bits[0:7] for number of cores
    if (config[0].compare("nc") == 0) {
      uint8_t num_cores = std::strtol(config[1].c_str(), NULL, 10); 
      data |= num_cores;
    } 
    // bit[8] is for xlen (64/32)
    else if (config[0].compare("xlen") == 0) {
      uint64_t xlen = std::strtol(config[1].c_str(), NULL, 10);
      if (xlen == 64) {
        data |= (0x1 << 8);
      }
      else {
        data &= ~(0x1 << 8);
      }
    } 
    // bit[9:24] for frequency
    else if (config[0].compare("f") == 0) {
      uint16_t frequency = std::strtol(config[1].c_str(), NULL, 10);
      data |= (frequency << 9);
    }
    // bit[25:31] for isa
    else if (config[0].compare("isa") == 0) {
      std::string isa = config[1];
    
      // Bit 25 high means it is rv64 otherwise rv32
      if (isa.find("64") != std::string::npos) {
        data |= (0x1 << 25);
      }
      else if (isa.find("32") != std::string::npos) {
        data &= ~(0x1 << 25);
      }
      // Bit 26 high means i extension is enabled
      if (isa.find("i") != std::string::npos) {
        data |= (0x1 << 26);
      }
      // Bit high 27 means m extension is enabled
      if (isa.find("m") != std::string::npos) {
        data |= (0x1 << 27);
      }
      // Bit high 28 means a extension is enabled
      if (isa.find("a") != std::string::npos) {
        data |= (0x1 << 28);
      }
      // Bit high 29 means f extension is enabled
      if (isa.find("f") != std::string::npos) {
        data |= (0x1 << 29);
      }
      // Bit high 30 means d  extension is enabled
      if (isa.find("d") != std::string::npos) {
        data |= (0x1 << 30);
      }
      // Bit high 31 means c  extension is enabled
      if (isa.find("c") != std::string::npos) {
        data |= (0x1 << 31);
      }
    } 
  }
  //std::string mode = this->ht->argmap["log_step="];
  //if (mode.compare("beak") == 0) { 
    this->ht->OURSBUS_WRITE(STATION_PLL_SYSTEM_CFG_ADDR, data); 
  //}
}

void es1y::io_test(std::string key) {
  uint64_t data;
  // Write Brkpt Register
  ltime = time(NULL);
  fprintf(stderr, "Start Writing Breakpoint Register to 0x123456789abcdef0 @ %s\n", asctime(localtime(&ltime)));
  data = 0x123456789abcdef0;
  this->ht->OURSBUS_WRITE(0x8000000000 + 8 * 4, data);
  ltime = time(NULL);
  fprintf(stderr, "Done Writing Breakpoint Register to 0x123456789abcdef0 @ %s\n", asctime(localtime(&ltime)));
  // Read Brkpt Register
  ltime = time(NULL);
  fprintf(stderr, "Start Reading Breakpoint Register @ %s\n", asctime(localtime(&ltime)));
  data = 0;
  this->ht->OURSBUS_READ(0x8000000000 + 8 * 4, data);
  ltime = time(NULL);
  fprintf(stderr, "Done Reading Breakpoint Register, got 0x%x @ %s\n", data, asctime(localtime(&ltime)));
  if (data != 0x123456789abcdef0) {
    fprintf(stderr, "Error: IO Test Failed!\n");
  }
  // Write GPIO
  ltime = time(NULL);
  fprintf(stderr, "Start Writing GPIO Address 0x400001000 to 0x123456789abcdef0 @ %s\n", asctime(localtime(&ltime)));
  data = 0x123456789abcdef0;
  this->ht->OURSBUS_WRITE(0x9000001000, data);
  ltime = time(NULL);
  fprintf(stderr, "Done Writing GPIO Address 0x400001000 to 0x123456789abcdef0 @ %s\n", asctime(localtime(&ltime)));
  // Read GPIO
  ltime = time(NULL);
  fprintf(stderr, "Start Reading GPIO Address 0x400001000 @ %s\n", asctime(localtime(&ltime)));
  data = 0;
  this->ht->OURSBUS_READ(0x9000001000, data);
  ltime = time(NULL);
  fprintf(stderr, "Done Reading GPIO Address 0x400001000, got 0x%x @ %s\n", data, asctime(localtime(&ltime)));
  if (data != 0x123456789abcdef0) {
    fprintf(stderr, "Error: IO Test Failed!\n");
  }
}

void es1y::program_pll(std::string key) {
  ltime = time(NULL);
  fprintf(stderr, "Start Programming PLL @ %s\n", asctime(localtime(&ltime)));

  // Keep RESET and BYPASS
  char* fin;
  char* fout;
  char* pEnd;
  char* tmp;
  char pll_str[256];
  uint64_t nr, nf, od, nb;
  strcpy(pll_str, key.c_str());

  fin = strtok(pll_str, "_");
  fout = strtok(NULL, "_");

  char cmd[256];
  char cfg[256];
  sprintf(cmd, "/work/tech/TCI_PLL/TCITSMCN28HPCPGPMPLLA1_calc.csh -n %s %s | awk '{ if (NR == 3) print $1,$2,$3,$4 }'", fin, fout);
  //fprintf(stderr, "cmd = %s\n", cmd);
  FILE* result = popen(cmd, "r");

  fgets(cfg, 255, result);
  tmp = strtok(cfg, " ");
  nr = std::strtoul(tmp, &pEnd, 10);
  tmp = strtok(NULL, " ");
  nf = std::strtoul(tmp, &pEnd, 10);
  tmp = strtok(NULL, " ");
  od = std::strtoul(tmp, &pEnd, 10);
  tmp = strtok(NULL, " ");
  nb = std::strtoul(tmp, &pEnd, 10);

  // Program
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_FUNC_CLKR_ADDR, nr - 1);
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_FUNC_CLKF_ADDR, nf - 1);
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_FUNC_CLKOD_ADDR, od - 1);
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_FUNC_BWADJ_ADDR, nb - 1);
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_FUNC_INTFB_ADDR, 1);

  // Assert PLL_PROG_DONE
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_FUNC_PROG_DONE_ADDR, 1);

  // Wait for Lock
  usleep(10);

  // Wait for Refclk
  usleep(1);

  // Drop PLL_BYPASS and Set CLK_SEL
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_FUNC_BYPASS_ADDR, 0);
  // Drop PLL_RESET
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_FUNC_RESET_ADDR, 0);
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_SCU_FUNC_CLK_SEL_ADDR, 1);

  ltime = time(NULL);
  fprintf(stderr, "Done Programming PLL @ %s\n", asctime(localtime(&ltime)));
}

void es1y::sram_ddr(std::string key) {
  ltime = time(NULL);
  fprintf(stderr, "Start Programming clock div for SRAM DDR @ %s\n", asctime(localtime(&ltime)));
  this->ht->OURSBUS_WRITE(STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_ADDR, 0);
  this->ht->OURSBUS_WRITE(STATION_BYP_S2B_DDR_BYPASS_EN_ADDR, 0);
  ltime = time(NULL);
  fprintf(stderr, "Done Programming clock div for SRAM DDR @ %s\n", asctime(localtime(&ltime)));
}

void es1y::reset_ddr(std::string key) {
  ltime = time(NULL);
  fprintf(stderr, "Start Reseting DDR @ %s\n", asctime(localtime(&ltime)));
  // Power On
  if (this->ht->argmap["ddr_bypass"].length() > 0) { // DDR running 100Mbps
    // Check ddr hs clk domain frequency
    if (this->ht->argmap["program_pll="].length() > 0) { // ddrhs clk = 600Mhz or 400Mhz
      this->ht->OURSBUS_WRITE(STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_ADDR, 2);
    }
    else { // ddrhs clk = 100Mhz
      this->ht->OURSBUS_WRITE(STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_ADDR, 0);
    }
    this->ht->OURSBUS_WRITE(STATION_BYP_S2B_DDR_BYPASS_EN_ADDR, 1);
  }
  else { // DDR running 2400Mbps
    // Bypass clk div for ddrls clk domain
    this->ht->OURSBUS_WRITE(STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_ADDR, 0);
    this->ht->OURSBUS_WRITE(STATION_BYP_S2B_DDR_BYPASS_EN_ADDR, 0);
  }
  this->ht->OURSBUS_WRITE(STATION_DDR_TOP_S2B_CSYSREQ_DDRC_ADDR, 1);
  //this->ht->OURSBUS_WRITE(STATION_DDR_TOP_S2B_DFI_CTRLUPD_ACK2_CH0_ADDR, 1);
  this->ht->OURSBUS_WRITE(STATION_DDR_TOP_S2B_DFI_RESET_N_IN_ADDR, 1);
  this->ht->OURSBUS_WRITE(STATION_DDR_TOP_S2B_INIT_MR_DONE_IN_ADDR, 1);
  this->ht->OURSBUS_WRITE(STATION_DDR_TOP_S2B_PWR_OK_IN_ADDR, 1);
  this->ht->OURSBUS_WRITE(STATION_DDR_TOP_S2B_PWR_OK_IN_ADDR, 1);

  // Drop presetn
  this->ht->OURSBUS_WRITE(STATION_DDR_TOP_S2B_PRESETN_ADDR, 1);

  uint64_t rdata;
  std::string freq = this->ht->argmap["program_pll="];

  if (this->ht->argmap["ddr_bypass"].length() > 0) {
    #include "./ddr_seq_bf_rst_100.cc"
  } else {
    if (freq.compare("100e6_600e6") == 0) {
      fprintf(stderr, "DDR frequency is 600MHz\n");
      #include "./ddr_seq_bf_rst.cc"
    } else if (freq.compare("100e6_400e6") == 0) {
      fprintf(stderr, "DDR frequency is 400MHz\n");
      #include "./ddr_seq_bf_rst_400.cc"
    }
  }

  // Drop rst and arst
  this->ht->OURSBUS_WRITE(STATION_DDR_TOP_S2B_ARESETN_0_ADDR, 1);
  this->ht->OURSBUS_WRITE(STATION_DDR_TOP_S2B_CORE_DDRC_RSTN_ADDR, 1);

  if (this->ht->argmap["ddr_train_1d"].length() > 0) {
    fprintf(stderr, "DDR 1D Training @ %s\n", asctime(localtime(&ltime)));
    if (freq.compare("100e6_600e6") == 0) {
      #include "./ddr_seq_af_rst_train_1d.cc"
    } else if (freq.compare("100e6_400e6") == 0) {
      #include "./ddr_seq_af_rst_train_1d_400.cc"
    }
  } else if (this->ht->argmap["ddr_bypass"].length() > 0) { //bypass for 100MHz
    #include "./ddr_seq_af_rst_100.cc"
  } else { // Default skip training
    fprintf(stderr, "DDR Skip Training @ %s\n", asctime(localtime(&ltime)));
    if (freq.compare("100e6_600e6") == 0) {
      #include "./ddr_seq_af_rst.cc"
    } else if (freq.compare("100e6_400e6") == 0) {
      #include "./ddr_seq_af_rst_400.cc"
    }
  }

  ltime = time(NULL);
  fprintf(stderr, "Done Reseting DDR @ %s\n", asctime(localtime(&ltime)));
}

void es1y::reset_usb(std::string key) {
  uint64_t rdata;
  ltime = time(NULL);
  fprintf(stderr, "Start Reseting USB @ %s\n", asctime(localtime(&ltime)));
  // Core reset
  this->ht->OURSBUS_WRITE(STATION_USB_TOP_S2B_VCC_RESET_N_ADDR, 0x1);
  //this->ht->OURSBUS_WRITE(STATION_USB_TOP_S2B_VAUX_RESET_N_ADDR, 0x1);

  if (this->ht->argmap["usb_init"].length() > 0) {
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc704, 0x40000000);  // DCTL, CSFTRST, bit30
    rdata = 0xffffffff;
    while (rdata != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc704, rdata);	// Polling 0 for reset
    }
    fprintf(stderr, "Done polling soft rest\n");

    // Power-on soft reset
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc400, 0x80000000);  // GEVNTADRLO0
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc404, 0x0);         // GEVNTADRHI0
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc408, 0x00000020);  // GEVNTSIZ0 min 32 byte
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc40c, 0x0);         // GEVNTCOUNT0
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc110, 0x30c12274);  // GCTL, enalbe scaledown. sim only
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc100, 0x00000002); // GSBUSCFG0, enable INCR4 burst

    // DCFG
    // Device speed default to HighSpeed, enable LPMCAP
    if (this->ht->argmap["usb_ss"].length() > 0) { // SS
      this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc700, 0x00480004);
    } else if (this->ht->argmap["usb_fs"].length() > 0) { // FS
      this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc700, 0x00480001);
    } else { // HS
      this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc700, 0x00480000);
    }

    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc708, 0x000043ff); // DEVTEN

    // Start new configuration (always issue to EP0)
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc80c, 0x00000409); // DEPCMD0, DEPSTARTCFG, No DEPCMDPAR
    rdata = 0xffffffff;
    while((rdata & 0x400) != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc80c, rdata);
    }
    fprintf(stderr, "Done polling CmdAct for DEPSTARTCFG\n");

    /*******************************Start EP Config*****************************/
    /*********EP0: Control  EP1: Interrupt  EP2: Bulk  EP3: Isochronous*********/
    /***************************************************************************/
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc804, 0x00000700); // DEPCMDPAR1[0], EP0 OUT
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc808, 0x00001000); // DEPCMDPAR0[0], burst size = 512
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc80c, 0x00000401); // DEPCMD[0], DEPCFG
    rdata = 0xffffffff;
    while((rdata & 0x400) != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc80c, rdata);
    }
    fprintf(stderr, "Done polling CmdAct for DEPCFG for EP0 OUT\n");

    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc814, 0x02000700); // DEPCMDPAR1[1], EP0 IN
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc818, 0x00001000); // DEPCMDPAR0[1], burst size = 512
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc81c, 0x00000401); // DEPCMD[1], DEPCFG
    rdata = 0xffffffff;
    while((rdata & 0x400) != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc81c, rdata);
    }
    fprintf(stderr, "Done polling CmdAct for DEPCFG for EP0 IN\n");

    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc824, 0x04000700); // DEPCMDPAR1[2], EP1 OUT
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc828, 0x00002006); // DEPCMDPAR0[2], burst size = 1024
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc82c, 0x00000401); // DEPCMD[2], DEPCFG
    rdata = 0xffffffff;
    while((rdata & 0x400) != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc82c, rdata);
    }
    fprintf(stderr, "Done polling CmdAct for DEPCFG for EP1 OUT\n");

    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc834, 0x06000700); // DEPCMDPAR1[3], EP1 IN
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc838, 0x00022006); // DEPCMDPAR0[3], burst size = 1024
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc83c, 0x00000401); // DEPCMD[3], DEPCFG
    rdata = 0xffffffff;
    while((rdata & 0x400) != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc83c, rdata);
    }
    fprintf(stderr, "Done polling CmdAct for DEPCFG for EP1 IN\n");

    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc844, 0x08000700); // DEPCMDPAR1[4], EP2 OUT
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc848, 0x00002004); // DEPCMDPAR0[4], burst size = 1024
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc84c, 0x00000401); // DEPCMD[4], DEPCFG
    rdata = 0xffffffff;
    while((rdata & 0x400) != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc84c, rdata);
    }
    fprintf(stderr, "Done polling CmdAct for DEPCFG for EP2 OUT\n");

    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc854, 0x0a000700); // DEPCMDPAR1[5], EP2 IN
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc858, 0x00042004); // DEPCMDPAR0[5], burst size = 1024
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc85c, 0x00000401); // DEPCMD[5], DEPCFG
    rdata = 0xffffffff;
    while((rdata & 0x400) != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc85c, rdata);
    }
    fprintf(stderr, "Done polling CmdAct for DEPCFG for EP2 IN\n");

    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc864, 0x0c000700); // DEPCMDPAR1[6], EP3 OUT
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc868, 0x00002002); // DEPCMDPAR0[6], burst size = 1024
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc86c, 0x00000401); // DEPCMD[6], DEPCFG
    rdata = 0xffffffff;
    while((rdata & 0x400) != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc86c, rdata);
    }
    fprintf(stderr, "Done polling CmdAct for DEPCFG for EP3 OUT\n");

    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc874, 0x0e000700); // DEPCMDPAR1[7], EP3 IN
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc878, 0x00062002); // DEPCMDPAR0[7], burst size = 1024
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc87c, 0x00000401); // DEPCMD[7], DEPCFG
    rdata = 0xffffffff;
    while((rdata & 0x400) != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc87c, rdata);
    }
    fprintf(stderr, "Done polling CmdAct for DEPCFG for EP3 IN\n");

    /*******************************End of EP Config****************************/

    // DEPXFERCFG
    for (int i = 0; i < 8; i++) {
      int cmdpar0_addr;
      int cmd_addr;
      cmdpar0_addr = STATION_USB_TOP_USB3_CFG_ADDR + 0xc808 + (i * 0x10);
      cmd_addr = STATION_USB_TOP_USB3_CFG_ADDR + 0xc80c + (i * 0x10);
      this->ht->OURSBUS_WRITE(cmdpar0_addr, 0x00000001);
      this->ht->OURSBUS_WRITE(cmd_addr, 0x00000402);
      rdata = 0xffffffff;
      while((rdata & 0x400) != 0) {
        this->ht->OURSBUS_READ_4B(cmd_addr, rdata);
      }
      if (i % 2) {
        fprintf(stderr, "Done polling CmdAct for DEPXFERCFG for EP%0d IN\n", (i / 2));
      }
      else {
        fprintf(stderr, "Done polling CmdAct for DEPXFERCFG for EP%0d OUT\n", (i / 2));
      }
    }

    // Prepare a setup TRB
    this->ht->OURSBUS_WRITE(0x80000000, 0);
    this->ht->OURSBUS_WRITE(0x80000008, 0x2300000008);

    // Issue DEPSTRTXFER cmd
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc804, 0x80000100);
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc808, 0x0);
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc80c, 0x00000406); // DEPCMD[0], DEPXFERCFG
    rdata = 0xffffffff;
    while((rdata & 0x400) != 0) {
      this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc80c, rdata);
    }
    fprintf(stderr, "Done polling CmdAct for DEPSTRTXFER for EP0\n");

    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc720, 0x00000003); // DALEPENA, enable EP0 & EP1
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc704, 0x80f00000); // DCTL, Runstop, bit31
  }
  ltime = time(NULL);
  fprintf(stderr, "Done Reseting USB @ %s\n", asctime(localtime(&ltime)));
}

void es1y::reset_sdio(std::string key) {
  uint64_t rdata = 0x0;
  ltime = time(NULL);
  fprintf(stderr, "Start Reseting SDIO @ %s\n", asctime(localtime(&ltime)));
  // Core reset
  this->ht->OURSBUS_WRITE(STATION_SDIO_S2ICG_PLLCLK_EN_ADDR, 0x1);
  this->ht->OURSBUS_WRITE(STATION_SDIO_S2B_RESETN_ADDR, 0x1);
  while (rdata != 0x1) {
    this->ht->OURSBUS_READ_4B(STATION_SDIO_S2B_RESETN_ADDR, rdata);
  }
  ltime = time(NULL);
  fprintf(stderr, "Done Reseting SDIO @ %s\n", asctime(localtime(&ltime)));
}

void es1y::config_l1(std::string key) {
  ltime = time(NULL);
  fprintf(stderr, "Start Configuring L1 @ %s\n", asctime(localtime(&ltime)));

  if (this->ht->argmap["config_l1="] == "tlb_bypass") {
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_CFG_BYPASS_TLB_ADDR_0, 1);
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_CFG_BYPASS_TLB_ADDR_1, 1);
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_CFG_BYPASS_TLB_ADDR_2, 1);
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_CFG_BYPASS_TLB_ADDR_3, 1);
  }

  if (this->ht->argmap["config_l1="] == "ic_bypass") {
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_CFG_BYPASS_IC_ADDR_0, 1);
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_CFG_BYPASS_IC_ADDR_1, 1);
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_CFG_BYPASS_IC_ADDR_2, 1);
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_CFG_BYPASS_IC_ADDR_3, 1);  }

  if(this->ht->argmap["config_l1="] == "nobypass") { // Only for ORV32
    this->ht->OURSBUS_WRITE(STATION_ORV32_S2B_CFG_BYPASS_IC_ADDR, 0);
  }

  ltime = time(NULL);
  fprintf(stderr, "Done Configuring L1 @ %s\n", asctime(localtime(&ltime)));
}

void es1y::config_l2(std::string key) {
  int vls_mode = 0; // 0 - 3, 0 : 8WAY, 1 : 2WAY, 2 : 4WAY, 3 : 6WAY
  int vls_en = 0; // 0 - 1
  int pbase = 0;
  uint64_t ctrl_reg;
  ltime = time(NULL);
  fprintf(stderr, "Start Configuring L2 @ %s\n", asctime(localtime(&ltime)));
  if(this->ht->argmap["config_l2="] == "random") {
    int rand = random() % 100;
    if ((0 <= rand) && (rand < 20)) {
      // CASE: 8WAY CACHE
      vls_mode = random() % 4;
      vls_en = 0;
    } else if ((20 <= rand) && (rand < 40)) {
      // CASE: 6WAY CACHE, 2WAY VLS
      vls_mode = 1;
      vls_en = 1;
      pbase = random() & 0xffffff;
    } else if ((40 <= rand) && (rand < 60)) {
      // CASE: 4WAY CACHE, 4WAY VLS
      vls_mode = 2;
      vls_en = 1;
      pbase = random() & 0xffffff;
    } else if ((60 <= rand) && (rand < 80)) {
      // CASE: 2WAY CACHE, 6WAY VLS
      vls_mode = 3;
      vls_en = 1;
      pbase = random() & 0xffffff;
    } else {
      // CASE: 8WAY VLS
      vls_mode = 0;
      vls_en = 1;
      pbase = random() & 0xffffff;
    }
  } else if(this->ht->argmap["config_l2="] == "test") {
    ctrl_reg = (0x5555ul << 28);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_0, ctrl_reg);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_1, ctrl_reg);
    ctrl_reg = (0x0000ul << 28);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_0, ctrl_reg);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_1, ctrl_reg);
  } else if(this->ht->argmap["config_l2="] == "shutdown") {
    ctrl_reg = (0xfffful << 28);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_0, ctrl_reg);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_1, ctrl_reg);
  } else if(this->ht->argmap["config_l2="] == "sleep") {
    ctrl_reg = (0x5555ul << 28);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_0, ctrl_reg);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_1, ctrl_reg);
  } else if(this->ht->argmap["config_l2="] == "lp") {
    int n_way;
    int sd[7]; // way 0 is always on
    n_way = (random() % 7) + 1;
    ctrl_reg = 0;
    for (int i = 0; i < n_way; i++) {
      sd[i] = (random() % 2) + 2; // 2-sleep, 3-sd
      ctrl_reg = ctrl_reg | (sd[i] << (2*(7 - i)));
    }

    ctrl_reg = (vls_mode << 25) + (vls_en << 24) + pbase;
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_0, ctrl_reg);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_1, ctrl_reg);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_2, ctrl_reg);
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_CTRL_REG_ADDR_3, ctrl_reg);
  }
  ltime = time(NULL);
  fprintf(stderr, "Done Configuring L2, vls_mode = %0d, vls_en = %0d, pbase = 0x%x @ %s\n", vls_mode, vls_en, pbase, asctime(localtime(&ltime)));
}

#define release_bank_reset(proj, target) \
  void proj::release_bank##target##_reset(std::string key) { \
    uint64_t rdata = 0; \
    ltime = time(NULL); \
    fprintf(stderr, "Start Releasing Reset for Bank %0d @ %s\n", target, asctime(localtime(&ltime))); \
    char arg[100]; \
    sprintf(arg, "release_bank%d_reset", #target); \
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2ICG_CLK_EN_ADDR_##target, 1); \
    this->ht->OURSBUS_WRITE(STATION_CACHE_S2B_RSTN_ADDR_##target, 1); \
    while (rdata != 1) { \
      this->ht->OURSBUS_READ_4B(STATION_CACHE_S2B_RSTN_ADDR_##target, rdata); \
    } \
    ltime = time(NULL); \
    fprintf(stderr, "Done Releasing Reset for Bank %0d @ %s\n", target, asctime(localtime(&ltime))); \
   } \

release_bank_reset(es1y, 0)
release_bank_reset(es1y, 1)
release_bank_reset(es1y, 2)
release_bank_reset(es1y, 3)

void es1y::release_reset_for_l2(std::string key) {
  release_bank0_reset(key);
  release_bank1_reset(key);
  release_bank2_reset(key);
  release_bank3_reset(key);
}

void es1y::test_l2(std::string key) {
  ltime = time(NULL);
  fprintf(stderr, "Start Test L2 @ %s\n", asctime(localtime(&ltime)));


  ltime = time(NULL);
  fprintf(stderr, "Done Test L2 @ %s\n", asctime(localtime(&ltime)));

}

#define set_0_to_bank_vldram(proj, target) \
  void proj::set_0_to_bank##target##_vldram(std::string key) { \
    ltime = time(NULL); \
    fprintf(stderr, "Start Zeroing Out TAG RAM for Bank %0d @ %s\n", target, asctime(localtime(&ltime))); \
    char arg[100]; \
    sprintf(arg, "set_0_to_bank%d_vldram", #target); \
    for (int way = 0; way < 8; way ++) { \
      for (int idx = 0; idx < 512; idx ++) { \
        int index = ((way << 2) << 9) + idx; \
        this->ht->OURSBUS_WRITE(STATION_CACHE_DBG_VLDRAM_ADDR_##target + index * 8, 0); \
      } \
    } \
    ltime = time(NULL); \
    fprintf(stderr, "Done Zeroing Out TAG RAM for Bank %0d @ %s\n", target, asctime(localtime(&ltime))); \
  }

set_0_to_bank_vldram(es1y, 0)
set_0_to_bank_vldram(es1y, 1)
set_0_to_bank_vldram(es1y, 2)
set_0_to_bank_vldram(es1y, 3)

void es1y::set_0_to_l2_vldram(std::string key){
  set_0_to_bank0_vldram(key);
  set_0_to_bank1_vldram(key);
  set_0_to_bank2_vldram(key);
  set_0_to_bank3_vldram(key);
}

#define release_early_reset(proj, target, addr) \
  void proj::release_##target##_early_reset(std::string key) { \
    ltime = time(NULL); \
    fprintf(stderr, "Start Releasing Early Reset for %s @ %s\n", #target, asctime(localtime(&ltime))); \
    char arg[100]; \
    sprintf(arg, "release_%s_early_reset", #target); \
    this->ht->OURSBUS_WRITE(addr, 1); \
    ltime = time(NULL); \
    fprintf(stderr, "Done Releasing Early Reset for %s @ %s\n", #target, asctime(localtime(&ltime))); \
  }

release_early_reset(es1y, orv32, STATION_ORV32_S2B_EARLY_RSTN_ADDR)
release_early_reset(es1y, vp0, STATION_VP_S2B_EARLY_RSTN_ADDR_0)
release_early_reset(es1y, vp1, STATION_VP_S2B_EARLY_RSTN_ADDR_1)
release_early_reset(es1y, vp2, STATION_VP_S2B_EARLY_RSTN_ADDR_2)
release_early_reset(es1y, vp3, STATION_VP_S2B_EARLY_RSTN_ADDR_3)

void es1y::release_all_early_reset(std::string key) {
  release_orv32_early_reset(key);
  release_vp0_early_reset(key);
  release_vp1_early_reset(key);
  release_vp2_early_reset(key);
  release_vp3_early_reset(key);
}

void es1y::test_l1(std::string key){
  ltime = time(NULL);
  fprintf(stderr, "Start Test L1 @ %s\n", asctime(localtime(&ltime)));


  ltime = time(NULL);
  fprintf(stderr, "Done Test L1 @ %s\n", asctime(localtime(&ltime)));
}

#define set_zero_to_l1_tagram(proj, target, addr_way0, addr_way1) \
  void proj::set_0_to_##target##_l1_tagram(std::string key) { \
    uint64_t wdata_way0, wdata_way1; \
    uint64_t rdata_way0, rdata_way1; \
    ltime = time(NULL); \
    fprintf(stderr, "Start Zeroing Out TAG RAM for %s L1 @ %s\n", #target, asctime(localtime(&ltime))); \
    for (int index = 0; index < 128; index ++) { \
      wdata_way0 = (random() << 32) + random(); \
      wdata_way1 = (random() << 32) + random(); \
      this->ht->OURSBUS_WRITE(addr_way0 + index * 8, wdata_way0); \
      this->ht->OURSBUS_WRITE(addr_way1 + index * 8, wdata_way1); \
      this->ht->OURSBUS_READ_4B(addr_way0 + index * 8, rdata_way0); \
      this->ht->OURSBUS_READ_4B(addr_way1 + index * 8, rdata_way1); \
      if ((rdata_way0 != (wdata_way0 & 0xffffff)) || (rdata_way1 != (wdata_way1 & 0xffffff))) { \
        fprintf(stderr, "Error: TAG RAM %s access wrong, index = %0d, wdata_way0 = 0x%lx, wdata_way1 = 0x%lx, rdata_way0 = 0x%lx, rdata_way1 = 0x%lx\n", #target, index, wdata_way0, wdata_way1, rdata_way0, rdata_way1); \
      } \
      this->ht->OURSBUS_WRITE(addr_way0 + index * 8, 0); \
      this->ht->OURSBUS_WRITE(addr_way1 + index * 8, 0); \
    } \
    ltime = time(NULL); \
    fprintf(stderr, "Done Zeroing Out TAG RAM for %s L1 @ %s\n", #target, asctime(localtime(&ltime))); \
  }

set_zero_to_l1_tagram(es1y, orv32, STATION_ORV32_IC_TAG_WAY_0_ADDR, STATION_ORV32_IC_TAG_WAY_1_ADDR)
set_zero_to_l1_tagram(es1y, vp0, STATION_VP_IC_TAG_WAY_0_ADDR_0, STATION_VP_IC_TAG_WAY_1_ADDR_0)
set_zero_to_l1_tagram(es1y, vp1, STATION_VP_IC_TAG_WAY_0_ADDR_1, STATION_VP_IC_TAG_WAY_1_ADDR_1)
set_zero_to_l1_tagram(es1y, vp2, STATION_VP_IC_TAG_WAY_0_ADDR_2, STATION_VP_IC_TAG_WAY_1_ADDR_2)
set_zero_to_l1_tagram(es1y, vp3, STATION_VP_IC_TAG_WAY_0_ADDR_3, STATION_VP_IC_TAG_WAY_1_ADDR_3)

void es1y::set_0_to_l1_tagram(std::string key) {
  set_0_to_vp0_l1_tagram(key);
  set_0_to_vp1_l1_tagram(key);
  set_0_to_vp2_l1_tagram(key);
  set_0_to_vp3_l1_tagram(key);
}

void es1y::warmup_l1_cache(std::string key){
  ltime = time(NULL);
  fprintf(stderr, "Start Warming Up L1 @ %s\n", asctime(localtime(&ltime)));
  // Write L1 Cache Way0 TAG to be valid
  //fprintf(stderr, "Write L1 Cache Way0 TAG to be valid\n");
  for (int wayid = 0; wayid < 2; wayid++) {
    for (int index = 0; index < 128; index++) {
      reg[0] = 0x00; // data == 0
      reg[1] = 0x00;
      reg[2] = 0x80;
      reg[3] = 0x00;
      reg[4] = index; // addr = {'b10001, 1'b wayid, 'b000, 7'b index}
      reg[5] = (0x22 + wayid) * 4;
      reg[6] = 0xc2; // 'b11000010
      reg[7] = 0x01; // valid
      this->ht->mem.write(0x8000000000 + 8 * 5, 8, (uint8_t*)reg);
    }
  }
  // Warm Up
  //fprintf(stderr, "Warm Up\n");
  for (int i = 0; i < 128; i ++) {
    // Load test to L2
    fprintf(stderr, "Load test to L2\n");
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0x10 + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0xf  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0xe  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0xd  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0xc  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0xb  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0xa  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0x9  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0x8  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0x7  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0x6  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0x5  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0x4  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0x3  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0x2  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 - 8 * 0x1  + 32 * i, 0x0000001300000013); // Previous Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000            + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0x1  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0x2  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0x3  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0x4  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0x5  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0x6  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0x7  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0x8  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0x9  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0xa  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0xb  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0xc  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0xd  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0xe  + 32 * i, 0x0000006f0000006f); // Current Line
    this->ht->OURSBUS_WRITE(0x10000000 + i * 0x10000 + 8 * 0xf  + 32 * i, 0x0000006f0000006f); // Current Line
    // Set rst_pc
    fprintf(stderr, "Set rst_pc = 0x%x\n", 0x20000000 + i * 0x10000 + i * 32 - 4);
    this->ht->OURSBUS_WRITE(0x8000000000 + 8 * 0x3, 0x10000000 + i * 0x10000 + i * 32 - 4);
    // Release ORV Reset
    fprintf(stderr, "Release ORV Reset\n");
    this->ht->OURSBUS_WRITE(0x8000000000 + 8 * 0x2, 0x3f8);
    // Timing
    uint64_t data = 0;
    for (int i = 0; i < 50; i ++)
      this->ht->OURSBUS_READ(0x8000000000, data);
    // Reset ORV
    fprintf(stderr, "Reset ORV\n");
    this->ht->OURSBUS_WRITE(0x8000000000 + 8 * 0x2, 0x3fc);
  }
  if (this->ht->argmap["release_vcore_reset"].length() > 0) {
    // Release VCORE Reset
    for (int i = 0; i < 16; i++) {
      ltime = time(NULL);
      fprintf(stderr, "L1 Warm Up: Start Releasing VCORE %0d Reset @ %s\n", i, asctime(localtime(&ltime)));
      reg[0] = 0xf8;
      reg[1] = 0x00;
      reg[2] = 0x00;
      reg[3] = 0x00;
      reg[4] = 0x00;
      reg[5] = 0x00;
      reg[6] = 0x00;
      reg[7] = 0x00;
      this->ht->mem.write(0x8000000000 + 8 * (10 + i), 8, (uint8_t*)reg);
      ltime = time(NULL);
      fprintf(stderr, "L1 Warm Up: Done Releasing VCORE %0d Reset @ %s\n", i, asctime(localtime(&ltime)));
    }
    // Load Upper Half of L2 to be NOOPs and report done and wfe
    fprintf(stderr, "Load Upper Half of L2 to be NOOPs and report done and wfe\n");
    for (int i = 0; i < 65536; i++) {
      this->ht->OURSBUS_WRITE(0x20080000 + i * 8, 0x0000001300000013);
    }
    this->ht->OURSBUS_WRITE(0x20080000 + 8 * 65518, 0x79c0d07300000013);
    this->ht->OURSBUS_WRITE(0x20080000 + 8 * 65519, 0x1060007379c05073);
    //Load Lower Half of L2 to be MP program
    fprintf(stderr, "Load Lower Half of L2 to be MP program\n");
    uint32_t inst[40] = {
      0x00000097,
      0x00008093,
      0x00100113,
      0x01311113,
      0x001101b3,
      0x00300213,
      0x00000313,
      0x00c00393,
      0x7ff00493,
      0x00149493,
      0x00148493,
      0x00100513,
      0x01351513,
      0x01451513,
      0x02050513,
      0x60d19073,
      0x60c21073,
      0x00000293,
      0x60e022f3,
      0xfe028ce3,
      0x60e01073,
      0x60c01073,
      0x00130313,
      0x01020213,
      0xfc734ee3,
      0x60902473,
      0xfe941ee3,
      0x00853023,
      0x0000006f,
      0x00000000,
      0x00000000,
      0x00000000,
      0x00000000,
      0x00000000,
      0x00000000,
      0x00000000,
      0x00000000,
      0x00000000,
      0x00000000,
      0x00000000
    };
    uint64_t addr = 0x20000000;
    for (int i = 0; i < 20; i++) {
      reg[7] = (inst[i * 2 + 1] >> 24) & 0xff;
      reg[6] = (inst[i * 2 + 1] >> 16) & 0xff;
      reg[5] = (inst[i * 2 + 1] >>  8) & 0xff;
      reg[4] = (inst[i * 2 + 1] >>  0) & 0xff;
      reg[3] = (inst[i * 2 + 0] >> 24) & 0xff;
      reg[2] = (inst[i * 2 + 0] >> 16) & 0xff;
      reg[1] = (inst[i * 2 + 0] >>  8) & 0xff;
      reg[0] = (inst[i * 2 + 0] >>  0) & 0xff;
      this->ht->mem.write(addr, 8, (uint8_t*)reg);
      addr += 8;
    }
    // Set rst_pc
    fprintf(stderr, "Set rst_pc\n");
    this->ht->OURSBUS_WRITE(0x8000000000 + 8 * 0x3, 0x20000000);
    // Release ORV Reset
    fprintf(stderr, "Release ORV Reset\n");
    this->ht->OURSBUS_WRITE(0x8000000000 + 8 * 0x2, 0x3f8);
    // Poking BRKPT to be expected value
    fprintf(stderr, "Poking BRKPT\n");
    do {
      this->ht->OURSBUS_READ(0x8000000000 + 8 * 0x4, addr);
    } while (addr != 0xfff);
    // Reset VCORE
    fprintf(stderr, "Reset VCORE\n");
    for (int i = 0; i < 16; i++) {
      ltime = time(NULL);
      fprintf(stderr, "Start Setting VCORE %0d Reset @ %s\n", i, asctime(localtime(&ltime)));
      reg[0] = 0xfc;
      reg[1] = 0x00;
      reg[2] = 0x00;
      reg[3] = 0x00;
      reg[4] = 0x00;
      reg[5] = 0x00;
      reg[6] = 0x00;
      reg[7] = 0x00;
      this->ht->mem.write(0x8000000000 + 8 * (10 + i), 8, (uint8_t*)reg);
      ltime = time(NULL);
      fprintf(stderr, "Done Setting VCORE %0d Reset @ %s\n", i, asctime(localtime(&ltime)));
    }
    // Reset ORV
    fprintf(stderr, "Reset ORV\n");
    this->ht->OURSBUS_WRITE(0x8000000000 + 8 * 0x2, 0x3fc);
  }
  ltime = time(NULL);
  fprintf(stderr, "Done Warming Up L1 @ %s\n", asctime(localtime(&ltime)));
}

void es1y::load_kernel(std::string key){
//   std::map<std::string, uint64_t> symbols;
  ltime = time(NULL);
  if (this->ht->argmap["load_pk"].length() > 0) {
    fprintf(stderr, "Start Loading Kernel @ %s\n", asctime(localtime(&ltime)));
    this->ht->symbols = load_elf(this->ht->path.c_str(), &(this->ht->mem), &(this->ht->entry));
    //this->ht->symbols_s = load_elf_s(this->ht->path.c_str(), &(this->ht->mem), &(this->ht->entry));
    //for (auto it = this->ht->addr_to_symbols.begin(); it != this->ht->addr_to_symbols.end(); ++it){
    //  fprintf(stderr, "KEY: %016x VALUE: %s \n", it->first, it->second.c_str());
    //}
    //fprintf(stderr,"--------------------\n");
    if (this->ht->argmap["load_2nd_file"].length() == 0) {
      this->ht->program_symbols = this->ht->symbols;
      //this->ht->program_symbols_s = this->ht->symbols_s;
      //this->ht->program_symbols = load_elf_symbols_only(this->ht->path.c_str(), &this->ht->mem, &(this->ht->entry));
      //for (auto it = this->ht->program_symbols.begin(); it != this->ht->program_symbols.end(); ++it){
      //  fprintf(stderr, "KEY: %s VALUE: %016x \n", it->first.c_str(), it->second);
      //}
    }
  } else {
    if (this->ht->argmap["filename1"].length() > 0) {
      fprintf(stderr, "Start Loading Kernel Symbols @ %s\n", asctime(localtime(&ltime)));
      this->ht->symbols = load_elf_symbols_only(this->ht->path.c_str(), &this->ht->mem, &(this->ht->entry));
    }
  }
  for (std::map<std::string, uint64_t>::iterator it = this->ht->symbols.begin(); it != this->ht->symbols.end(); ++it) {
    if (it->first.substr(0, 6) == "tohost") {
      if (it->first.length() == 6) {
        this->ht->tohost_addr = it->second;
      } else if (it->first.length() > 6) {
        if (it->first.substr(6, 1) == ".") {
          this->ht->tohost_addr = it->second;
        }
      }
    }
    if (it->first.substr(0, 8) == "fromhost") {
      if (it->first.length() == 8) {
        this->ht->fromhost_addr = it->second;
      } else if (it->first.length() > 8) {
        if (it->first.substr(8, 1) == ".") {
          this->ht->fromhost_addr = it->second;
        }
      }
    }
  }
  if ((this->ht->tohost_addr == 0) && (this->ht->fromhost_addr == 0)) {
    fprintf(stderr, "warning: tohost and fromhost symbols not in ELF; can't communicate with target\n");
  }
  ltime = time(NULL);
  if (this->ht->argmap["load_pk"].length() > 0) {
    fprintf(stderr, "Done Loading Kernel @ %s\n", asctime(localtime(&ltime)));
  } else {
    fprintf(stderr, "Done Loading Kernel Symbols @ %s\n", asctime(localtime(&ltime)));
  }
  if (this->ht->argmap["filename2"].length() > 0) {
    std::string path;
    if (access(this->ht->argmap["filename2"].c_str(), F_OK) == 0)
      path = this->ht->argmap["filename2"];
    else if (this->ht->argmap["filename2"].find('/') == std::string::npos)
    {
      std::string test_path = PREFIX TARGET_DIR + this->ht->argmap["filename2"];
      if (access(test_path.c_str(), F_OK) == 0)
        path = test_path;
    }

    if (path.empty())
      throw std::runtime_error("could not open " + this->ht->argmap["filename2"]);

    ltime = time(NULL);
    if (this->ht->argmap["load_2nd_file"].length() > 0) {
      fprintf(stderr, "Start Loading 2nd File as ELF, Symbols will be put in program_symbols @ %s\n", asctime(localtime(&ltime)));
      this->ht->program_symbols = load_elf(path.c_str(), &this->ht->mem, &(this->ht->entry));
      this->ht->program_symbols_s = load_elf_s(path.c_str(), &this->ht->mem, &(this->ht->entry));
    } else {
      fprintf(stderr, "Start Loading 2nd File Symbols, will be put in program_symbols @ %s\n", asctime(localtime(&ltime)));
      this->ht->program_symbols = load_elf_symbols_only(path.c_str(), &this->ht->mem, &(this->ht->entry));
      this->ht->program_symbols_s = load_elf_symbols_only_s(path.c_str(), &this->ht->mem, &(this->ht->entry));
    }
    ltime = time(NULL);
    if (this->ht->argmap["load_2nd_file"].length() > 0) {
      fprintf(stderr, "Done Loading 2nd File as ELF @ %s\n", asctime(localtime(&ltime)));
    } else {
      fprintf(stderr, "Done Loading 2nd File Symbols @ %s\n", asctime(localtime(&ltime)));
    }
  }

  if (this->ht->argmap["filename3"].length() > 0) {
    std::string path;
    if (access(this->ht->argmap["filename3"].c_str(), F_OK) == 0)
      path = this->ht->argmap["filename3"];
    else if (this->ht->argmap["filename3"].find('/') == std::string::npos)
    {
      std::string test_path = PREFIX TARGET_DIR + this->ht->argmap["filename3"];
      if (access(test_path.c_str(), F_OK) == 0)
        path = test_path;
    }

    if (path.empty())
      throw std::runtime_error("could not open " + this->ht->argmap["filename3"]);
    ltime = time(NULL);
    if (this->ht->argmap["load_3rd_file"].length() > 0) {
      fprintf(stderr, "Start Loading 3rd File as ELF, Symbols will be put in program_symbols @ %s\n", asctime(localtime(&ltime)));
      this->ht->program_symbols = load_elf(path.c_str(), &this->ht->mem, &(this->ht->entry));
      this->ht->program_symbols_s = load_elf_s(path.c_str(), &this->ht->mem, &(this->ht->entry));
    } else {
      fprintf(stderr, "Start Loading 3rd File Symbols, will be put in program_symbols @ %s\n", asctime(localtime(&ltime)));
      this->ht->program_symbols = load_elf_symbols_only(path.c_str(), &this->ht->mem, &(this->ht->entry));
      this->ht->program_symbols_s = load_elf_symbols_only_s(path.c_str(), &this->ht->mem, &(this->ht->entry));
    }
    ltime = time(NULL);
    if (this->ht->argmap["load_3rd_file"].length() > 0) {
      fprintf(stderr, "Done Loading 3rd File as ELF @ %s\n", asctime(localtime(&ltime)));
    } else {
      fprintf(stderr, "Done Loading 3rd File Symbols @ %s\n", asctime(localtime(&ltime)));
    }
  }
  for (auto it = this->ht->symbols_s.begin(); it != this->ht->symbols_s.end(); ++it){
    this->ht->addr_to_symbols[it->second] = it->first;
    //fprintf(stderr, "KEY: %s VALUE: %016x \n", it->first.c_str(), it->second);
  }
  auto it = this->ht->symbols_s.find("_payload_start");
  int64_t offset = 0;
  if (it != this->ht->symbols_s.end()) {
    auto vit = this->ht->program_symbols_s.find("_start");
    //offset = it->second - vit->second;
    offset = vit->second - it->second;
  }
  for (auto it = this->ht->program_symbols_s.begin(); it != this->ht->program_symbols_s.end(); ++it) {
    this->ht->addr_to_program_symbols[it->second + offset] = it->first;
    //fprintf(stderr, "KEY: %s VALUE: %016x \n", it->first.c_str(), it->second);
  }
}

void es1y::load_image(std::string key) {
  // Load Image
  if (this->ht->argmap["load_image="].length() > 0) {
    fprintf(stderr, "Start Loading Image @ %s\n", asctime(localtime(&ltime)));
    uint64_t image_addr = 0;
    // Search 1st symbol with image
    for (std::map<std::string, uint64_t>::iterator it = this->ht->symbols.begin(); it != this->ht->symbols.end(); ++it) {
      if (it->first.substr(0, 6) == "image.") {
        image_addr = it->second;
        fprintf(stderr, "Loading Image File: %s\n", this->ht->argmap["load_image="].c_str());
        fprintf(stderr, "Loading Image to Symbol: %s (Address: %lx)\n", it->first.c_str(), image_addr);
        break;
      }
    }
    if (image_addr == 0) {
      for (std::map<std::string, uint64_t>::iterator it = this->ht->program_symbols.begin(); it != this->ht->program_symbols.end(); ++it) {
        if (it->first.substr(0, 6) == "image.") {
          image_addr = it->second;
          fprintf(stderr, "Loading Image File: %s\n", this->ht->argmap["load_image="].c_str());
          fprintf(stderr, "Loading Image to Symbol: %s (Address: %lx)\n", it->first.c_str(), image_addr);
          break;
        }
      }
      if (image_addr == 0) {
        fprintf(stderr, "Image Symbol: image.* is not able to be found!!\n");
        abort();
      }
    }
    int fd = open(this->ht->argmap["load_image="].c_str(), O_RDONLY);
    struct stat s;
    assert (fd != -1);
    if (fstat(fd, &s) < 0)
      abort();
    size_t size = s.st_size;
    char* buf = (char*) mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
    assert(buf != MAP_FAILED);
    close(fd);
    fprintf(stderr, "Image Size: %ld Bytes\n", size);
    size_t cnt = 0;
    while (cnt < size) {
      reg[0] = *(buf + cnt + 0);
      reg[1] = *(buf + cnt + 1);
      reg[2] = *(buf + cnt + 2);
      reg[3] = *(buf + cnt + 3);
      reg[4] = *(buf + cnt + 4);
      reg[5] = *(buf + cnt + 5);
      reg[6] = *(buf + cnt + 6);
      reg[7] = *(buf + cnt + 7);
      this->ht->mem.write(image_addr + cnt, 8, (uint8_t*)reg);
      cnt += 8;
    }
    fprintf(stderr, "Done Loading Image @ %s\n", asctime(localtime(&ltime)));
  }
}

void es1y::load_weight(std::string key){
  fprintf(stderr, "Start Loading Weight @ %s\n", asctime(localtime(&ltime)));
  uint64_t weight_addr = 0;
  // Search 1st symbol with weight
  for (std::map<std::string, uint64_t>::iterator it = this->ht->symbols.begin(); it != this->ht->symbols.end(); ++it) {
    if (it->first.substr(0, 8) == "weights.") {
      weight_addr = it->second;
      fprintf(stderr, "Loading Weight File: %s\n",this->ht->argmap["load_weight="].c_str());
      fprintf(stderr, "Loading Weight to Symbol: %s (Address: %lx)\n", it->first.c_str(), weight_addr);
      break;
    }
  }
  if (weight_addr == 0) {
    for (std::map<std::string, uint64_t>::iterator it = this->ht->program_symbols.begin(); it != this->ht->program_symbols.end(); ++it) {
      if (it->first.substr(0, 8) == "weights.") {
        weight_addr = it->second;
        fprintf(stderr, "Loading Weight File: %s\n", this->ht->argmap["load_weight="].c_str());
        fprintf(stderr, "Loading Weight to Symbol: %s (Address: %lx)\n", it->first.c_str(), weight_addr);
        break;
      }
    }
    if (weight_addr == 0) {
      fprintf(stderr, "Weight Symbol: weight.* is not able to be found!!\n");
      abort();
    }
  }
  int fd = open(this->ht->argmap["load_weight="].c_str(), O_RDONLY);
  struct stat s;
  assert (fd != -1);
  if (fstat(fd, &s) < 0)
    abort();
  size_t size = s.st_size;
  char* buf = (char*) mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
  assert(buf != MAP_FAILED);
  close(fd);
  fprintf(stderr, "Weight Size: %ld Bytes\n", size);
  size_t cnt = 0;
  while (cnt < size) {
    reg[0] = *(buf + cnt + 0);
    reg[1] = *(buf + cnt + 1);
    reg[2] = *(buf + cnt + 2);
    reg[3] = *(buf + cnt + 3);
    reg[4] = *(buf + cnt + 4);
    reg[5] = *(buf + cnt + 5);
    reg[6] = *(buf + cnt + 6);
    reg[7] = *(buf + cnt + 7);
    this->ht->mem.write(weight_addr + cnt, 8, (uint8_t*)reg);
    cnt += 8;
  }
  fprintf(stderr, "Done Loading Weight @ %s\n", asctime(localtime(&ltime)));
}

//agrmap
void es1y::alloc_stack(std::string key){
  ltime = time(NULL);
  fprintf(stderr, "Start Allocating 8K Stack with Address 0x%s @ %s\n", this->ht->argmap["alloc_sp="].c_str(), asctime(localtime(&ltime)));
  char * pEnd;
  for (int i = 0; i < 1024; i++) {
    reg[0] = 0x00;
    reg[1] = 0x00;
    reg[2] = 0x00;
    reg[3] = 0x00;
    reg[4] = 0x00;
    reg[5] = 0x00;
    reg[6] = 0x00;
    reg[7] = 0x00;
    this->ht->mem.write(std::strtol(this->ht->argmap["alloc_sp="].c_str(), &pEnd, 16) - (i * 8), 8, (uint8_t*)reg);
  }
  for (int i = 0; i < 1024; i++) {
    reg[0] = 0x00;
    reg[1] = 0x00;
    reg[2] = 0x00;
    reg[3] = 0x00;
    reg[4] = 0x00;
    reg[5] = 0x00;
    reg[6] = 0x00;
    reg[7] = 0x00;
    this->ht->mem.write(std::strtol(this->ht->argmap["alloc_sp="].c_str(), &pEnd, 16) + ((i+1) * 8), 8, (uint8_t*)reg);
  }

  ltime = time(NULL);
  fprintf(stderr, "Done Allocating 8K Stack @ %s\n", asctime(localtime(&ltime)));
}

void es1y::set_magic_mem_address(std::string key){
  ltime = time(NULL);
  fprintf(stderr, "Start Setting Magic Mem Address @ %s\n", asctime(localtime(&ltime)));
  // Zero out???
  this->ht->mem.read(0x844000d000, 8, (uint8_t*)reg);
  reg[0] = 0x00;
  reg[1] = 0x00;
  reg[2] = 0x00;
  reg[3] = 0x00;
  reg[4] = 0x00;
  reg[5] = 0x00;
  reg[6] = 0x00;
  reg[7] = 0x00;
  this->ht->mem.write(0x844000d000, 8, (uint8_t*)reg);
  this->ht->mem.read(0x844000d000, 8, (uint8_t*)reg);
  this->ht->mem.read(0x844000d008, 8, (uint8_t*)reg);
  reg[0] = 0x00;
  reg[1] = 0x00;
  reg[2] = 0x00;
  reg[3] = 0x00;
  reg[4] = 0x00;
  reg[5] = 0x00;
  reg[6] = 0x00;
  reg[7] = 0x00;
  this->ht->mem.write(0x844000d008, 8, (uint8_t*)reg);
  this->ht->mem.read(0x844000d008, 8, (uint8_t*)reg);
  // Start Address
  reg[0] = 0x00;
  reg[1] = 0x00;
  reg[2] = 0x00;
  reg[3] = 0x00;
  reg[4] = 0x00;
  reg[5] = 0x00;
  reg[6] = 0x00;
  reg[7] = 0x00;
  this->ht->mem.write(0x8000000000 + 8 * 6, 8, (uint8_t*)reg);
  // End Address
  reg[0] = 0x00;
  reg[1] = 0x00;
  reg[2] = 0x00;
  reg[3] = 0x00;
  reg[4] = 0x00;
  reg[5] = 0x00;
  reg[6] = 0x00;
  reg[7] = 0x00;
  this->ht->mem.write(0x8000000000 + 8 * 7, 8, (uint8_t*)reg);
  // From Host
  //reg[0] = 0x00;
  //reg[1] = 0x00;
  //reg[2] = 0x00;
  //reg[3] = 0x00;
  //reg[4] = 0x00;
  //reg[5] = 0x00;
  //reg[6] = 0x00;
  //reg[7] = 0x00;
  reg[0] = (this->ht->fromhost_addr >>  0) & 0xff;
  reg[1] = (this->ht->fromhost_addr >>  8) & 0xff;
  reg[2] = (this->ht->fromhost_addr >> 16) & 0xff;
  reg[3] = (this->ht->fromhost_addr >> 24) & 0xff;
  reg[4] = (this->ht->fromhost_addr >> 32) & 0xff;
  reg[5] = (this->ht->fromhost_addr >> 40) & 0xff;
  reg[6] = (this->ht->fromhost_addr >> 48) & 0xff;
  reg[7] = (this->ht->fromhost_addr >> 56) & 0xff;
  this->ht->mem.write(0x8000000000 + 8 * 8, 8, (uint8_t*)reg);
  // To Host
  //reg[0] = 0x00;
  //reg[1] = 0x00;
  //reg[2] = 0x00;
  //reg[3] = 0x00;
  //reg[4] = 0x00;
  //reg[5] = 0x00;
  //reg[6] = 0x00;
  //reg[7] = 0x00;
  reg[0] = (this->ht->tohost_addr >>  0) & 0xff;
  reg[1] = (this->ht->tohost_addr >>  8) & 0xff;
  reg[2] = (this->ht->tohost_addr >> 16) & 0xff;
  reg[3] = (this->ht->tohost_addr >> 24) & 0xff;
  reg[4] = (this->ht->tohost_addr >> 32) & 0xff;
  reg[5] = (this->ht->tohost_addr >> 40) & 0xff;
  reg[6] = (this->ht->tohost_addr >> 48) & 0xff;
  reg[7] = (this->ht->tohost_addr >> 56) & 0xff;
  this->ht->mem.write(0x8000000000 + 8 * 9, 8, (uint8_t*)reg);
  // Zero Out Magic Mem
  // TODO: Zero Out Magic Mem Other Entries
  reg[0] = 0x00;
  reg[1] = 0x00;
  reg[2] = 0x00;
  reg[3] = 0x00;
  reg[4] = 0x00;
  reg[5] = 0x00;
  reg[6] = 0x00;
  reg[7] = 0x00;
  uint8_t rdata[8];
  do {
    this->ht->mem.write(this->ht->fromhost_addr, 8, (uint8_t*)reg);
    this->ht->mem.read(this->ht->fromhost_addr, 8, (uint8_t*)rdata);
  } while ((rdata[0] | rdata[1] | rdata[2] | rdata[3] | rdata[4] | rdata[5] | rdata[6] | rdata[7]) != 0);
  do {
    this->ht->mem.write(this->ht->tohost_addr, 8, (uint8_t*)reg);
    this->ht->mem.read(this->ht->tohost_addr, 8, (uint8_t*)rdata);
  } while ((rdata[0] | rdata[1] | rdata[2] | rdata[3] | rdata[4] | rdata[5] | rdata[6] | rdata[7]) != 0);
  ltime = time(NULL);
  fprintf(stderr, "Done Setting Magic Mem Address @ %s\n", asctime(localtime(&ltime)));
}

#define set_reset_pc(proj, target, addr) \
  void proj::set_##target##_reset_pc(std::string key){ \
    ltime = time(NULL); \
    fprintf(stderr, "Start Setting Reset PC for %s @ %s\n", #target, asctime(localtime(&ltime))); \
    size_t sz; \
    char arg[100]; \
    sprintf(arg, "set_%s_rst_pc=", #target); \
    uint64_t rst_pc = std::stoul(this->ht->argmap[arg], &sz, 16); \
    this->ht->OURSBUS_WRITE(addr, rst_pc); \
    ltime = time(NULL); \
    fprintf(stderr, "Done Setting Reset PC for %s @ %s\n", #target, asctime(localtime(&ltime))); \
  }

set_reset_pc(es1y, orv32, STATION_ORV32_S2B_CFG_RST_PC_ADDR)
set_reset_pc(es1y, vp0,   STATION_VP_S2B_CFG_RST_PC_ADDR_0)
set_reset_pc(es1y, vp1,   STATION_VP_S2B_CFG_RST_PC_ADDR_1)
set_reset_pc(es1y, vp2,   STATION_VP_S2B_CFG_RST_PC_ADDR_2)
set_reset_pc(es1y, vp3,   STATION_VP_S2B_CFG_RST_PC_ADDR_3)

void es1y::set_all_vp_reset_pc(std::string key){
  set_vp0_reset_pc(key);
  set_vp1_reset_pc(key);
  set_vp2_reset_pc(key);
  set_vp3_reset_pc(key);
}

void es1y::load_rom(std::string key){
  ltime = time(NULL);
  fprintf(stderr, "Start Loading ROM @ %s\n", asctime(localtime(&ltime)));
  uint64_t data; 
  std::string mode = this->ht->argmap["log_step="];
 // if (mode.compare("beak") == 0) { 
 //   if (this->ht->argmap["chip_config="].length() > 0) {
       this->ht->OURSBUS_READ(STATION_PLL_SYSTEM_CFG_ADDR, data); 
 //   } else {
 //     // Set default value, simplify sim arg
 //     data = 0x000000001e04b101;
 //   }
 // } else {
 //   data = 0x000000001e04b101;
 // }
  uint32_t * rom;
  uint32_t rom_length = make_dtb(data, make_mems("2048"), &rom);
  //fprintf(stderr, "OUT %d:\n", rom_length);
  //for (int i= 0; i < rom_length; ++i){
  //  fprintf(stderr,"%08x\n", rom[i]);
  //}

  //uint32_t   rom [262] = {
  //  0x00000297,
  //  0x02028593,
  //  0xf1402573,
  //  0x0182b283,
  //  0x00028067,
  //  0x00000000,
  //  0x80000000,
  //  0x00000000,
  //  0xedfe0dd0,
  //  0xf2030000,
  //  0x38000000,
  //  0x30030000,
  //  0x28000000,
  //  0x11000000,
  //  0x10000000,
  //  0x00000000,
  //  0xc2000000,
  //  0xf8020000,
  //  0x00000000,
  //  0x00000000,
  //  0x00000000,
  //  0x00000000,
  //  0x01000000,
  //  0x00000000,
  //  0x03000000,
  //  0x04000000,
  //  0x00000000,
  //  0x02000000,
  //  0x03000000,
  //  0x04000000,
  //  0x0f000000,
  //  0x02000000,
  //  0x03000000,
  //  0x16000000,
  //  0x1b000000,
  //  0x62626375,
  //  0x732c7261,
  //  0x656b6970,
  //  0x7261622d,
  //  0x65642d65,
  //  0x00000076,
  //  0x03000000,
  //  0x12000000,
  //  0x26000000,
  //  0x62626375,
  //  0x732c7261,
  //  0x656b6970,
  //  0x7261622d,
  //  0x00000065,
  //  0x01000000,
  //  0x73757063,
  //  0x00000000,
  //  0x03000000,
  //  0x04000000,
  //  0x00000000,
  //  0x01000000,
  //  0x03000000,
  //  0x04000000,
  //  0x0f000000,
  //  0x00000000,
  //  0x03000000,
  //  0x04000000,
  //  0x2c000000,
  //  0x0046c323,
  //  0x01000000,
  //  0x40757063,
  //  0x00000030,
  //  0x03000000,
  //  0x04000000,
  //  0x3f000000,
  //  0x00757063,
  //  0x03000000,
  //  0x04000000,
  //  0x4b000000,
  //  0x00000000,
  //  0x03000000,
  //  0x05000000,
  //  0x4f000000,
  //  0x79616b6f,
  //  0x00000000,
  //  0x03000000,
  //  0x06000000,
  //  0x1b000000,
  //  0x63736972,
  //  0x00000076,
  //  0x03000000,
  //  0x0b000000,
  //  0x56000000,
  //  0x34367672,
  //  0x66616d69,
  //  0x00006364,
  //  0x03000000,
  //  0x0b000000,
  //  0x60000000,
  //  0x63736972,
  //  0x76732c76,
  //  0x00003834,
  //  0x03000000,
  //  0x04000000,
  //  0x69000000,
  //  0x0046c323,
  //  0x01000000,
  //  0x65746e69,
  //  0x70757272,
  //  0x6f632d74,
  //  0x6f72746e,
  //  0x72656c6c,
  //  0x00000000,
  //  0x03000000,
  //  0x04000000,
  //  0x79000000,
  //  0x01000000,
  //  0x03000000,
  //  0x00000000,
  //  0x8a000000,
  //  0x03000000,
  //  0x0f000000,
  //  0x1b000000,
  //  0x63736972,
  //  0x70632c76,
  //  0x6e692d75,
  //  0x00006374,
  //  0x03000000,
  //  0x04000000,
  //  0x9f000000,
  //  0x01000000,
  //  0x02000000,
  //  0x02000000,
  //  0x02000000,
  //  0x01000000,
  //  0x6f6d656d,
  //  0x38407972,
  //  0x30303030,
  //  0x00303030,
  //  0x03000000,
  //  0x07000000,
  //  0x3f000000,
  //  0x6f6d656d,
  //  0x00007972,
  //  0x03000000,
  //  0x10000000,
  //  0x4b000000,
  //  0x00000000,
  //  0x00000080,
  //  0x00000000,
  //  0x00000080,
  //  0x02000000,
  //  0x01000000,
  //  0x00636f73,
  //  0x03000000,
  //  0x04000000,
  //  0x00000000,
  //  0x02000000,
  //  0x03000000,
  //  0x04000000,
  //  0x0f000000,
  //  0x02000000,
  //  0x03000000,
  //  0x21000000,
  //  0x1b000000,
  //  0x62626375,
  //  0x732c7261,
  //  0x656b6970,
  //  0x7261622d,
  //  0x6f732d65,
  //  0x69730063,
  //  0x656c706d,
  //  0x7375622d,
  //  0x00000000,
  //  0x03000000,
  //  0x00000000,
  //  0xa7000000,
  //  0x01000000,
  //  0x6e696c63,
  //  0x30384074,
  //  0x30303030,
  //  0x00000000,
  //  0x03000000,
  //  0x0d000000,
  //  0x1b000000,
  //  0x63736972,
  //  0x6c632c76,
  //  0x30746e69,
  //  0x00000000,
  //  0x03000000,
  //  0x10000000,
  //  0xae000000,
  //  0x01000000,
  //  0x03000000,
  //  0x01000000,
  //  0x07000000,
  //  0x03000000,
  //  0x10000000,
  //  0x4b000000,
  //  0x00000000,
  //  0x00008000,
  //  0x00000000,
  //  0x00000c00,
  //  0x02000000,
  //  0x02000000,
  //  0x01000000,
  //  0x66697468,
  //  0x00000000,
  //  0x03000000,
  //  0x0a000000,
  //  0x1b000000,
  //  0x2c626375,
  //  0x66697468,
  //  0x00000030,
  //  0x02000000,
  //  0x02000000,
  //  0x09000000,
  //  0x64646123,
  //  0x73736572,
  //  0x6c65632d,
  //  0x2300736c,
  //  0x657a6973,
  //  0x6c65632d,
  //  0x6300736c,
  //  0x61706d6f,
  //  0x6c626974,
  //  0x6f6d0065,
  //  0x006c6564,
  //  0x656d6974,
  //  0x65736162,
  //  0x6572662d,
  //  0x6e657571,
  //  0x64007963,
  //  0x63697665,
  //  0x79745f65,
  //  0x72006570,
  //  0x73006765,
  //  0x75746174,
  //  0x69720073,
  //  0x2c766373,
  //  0x00617369,
  //  0x2d756d6d,
  //  0x65707974,
  //  0x6f6c6300,
  //  0x662d6b63,
  //  0x75716572,
  //  0x79636e65,
  //  0x6e692300,
  //  0x72726574,
  //  0x2d747075,
  //  0x6c6c6563,
  //  0x6e690073,
  //  0x72726574,
  //  0x2d747075,
  //  0x746e6f63,
  //  0x6c6c6f72,
  //  0x70007265,
  //  0x646e6168,
  //  0x7200656c,
  //  0x65676e61,
  //  0x6e690073,
  //  0x72726574,
  //  0x73747075,
  //  0x7478652d,
  //  0x65646e65,
  //  0x00000064,
  //  0x00000000
  // };
  uint64_t addr;
  if (this->ht->argmap["linux_rom"].length()>0) {
    addr = 0x80016000;
  } else {
    addr = 0x82000000;
  }
  //for (int i = 0; i < 131; i++) {
  for (int i = 0; i < rom_length/2; i++) {
    reg[7] = (rom[i * 2 + 1] >> 24) & 0xff;
    reg[6] = (rom[i * 2 + 1] >> 16) & 0xff;
    reg[5] = (rom[i * 2 + 1] >>  8) & 0xff;
    reg[4] = (rom[i * 2 + 1] >>  0) & 0xff;
    reg[3] = (rom[i * 2 + 0] >> 24) & 0xff;
    reg[2] = (rom[i * 2 + 0] >> 16) & 0xff;
    reg[1] = (rom[i * 2 + 0] >>  8) & 0xff;
    reg[0] = (rom[i * 2 + 0] >>  0) & 0xff;
    this->ht->mem.write(addr, 8, (uint8_t*)reg);
    addr += 8;
  }
  if (rom_length % 2 == 1 ){
    reg[7] = (0x00 >> 24) & 0xff;
    reg[6] = (0x00 >> 16) & 0xff;
    reg[5] = (0x00 >>  8) & 0xff;
    reg[4] = (0x00 >>  0) & 0xff;
    reg[3] = (rom[rom_length-1 + 0] >> 24) & 0xff;
    reg[2] = (rom[rom_length-1 + 0] >> 16) & 0xff;
    reg[1] = (rom[rom_length-1 + 0] >>  8) & 0xff;
    reg[0] = (rom[rom_length-1 + 0] >>  0) & 0xff;
    this->ht->mem.write(addr, 8, (uint8_t*)reg);
  }
  ltime = time(NULL);
  //free(rom);
  fprintf(stderr, "Done Loading ROM @ %s\n", asctime(localtime(&ltime)));
}

// argmap
void es1y::dump_l2_after_loading(std::string key){
  // Dump L2 After Loading
  FILE * fd = fopen(this->ht->argmap["dump_l2_after_loading="].c_str(), "w+");
  ltime = time(NULL);
  fprintf(stderr, "Start Dumping L2 After Loading @ %s\n", asctime(localtime(&ltime)));
  // DATA
  long int ID = 0x2b;
  long int addr = 0;
  long int offset = 0;
  for (int way = 0; way < 8; way ++) {
    for (int idx = 0; idx < 256; idx ++) {
    //for (int idx = 0; idx < 1; idx ++) {
      for (int bank = 0; bank < 8; bank ++) {
        for (int chunk = 0; chunk < 4; chunk ++) {
          reg[0] = 0x00;
          reg[1] = 0x00;
          reg[2] = 0x00;
          reg[3] = 0x00;
          reg[4] = 0x00;
          reg[5] = 0x00;
          reg[6] = 0x00;
          reg[7] = 0x00;
          addr = ID;
          addr = addr << 18; // RSVD
          addr = addr << 3; // BANK_ID
          addr = addr + bank;
          addr = addr << 3; // WAY_ID
          addr = addr + way;
          addr = addr << 2; // CHUNK_ID
          addr = addr + chunk;
          addr = addr << 8; // BANK_INDEX
          this->ht->mem.read(addr, 8, (uint8_t*)reg);
          offset = way; // WAY_ID
          offset = offset << 8; // BANK_INDEX
          offset = offset + idx;
          offset = offset << 3; // BANK_ID
          offset = offset + bank;
          offset = offset << 2; // CHUNK_ID
          offset = offset + chunk;
          offset = offset << 3; // Align to 8 Byte
          fprintf(fd, "AddrOffset: %020x | %02x%02x%02x%02x%02x%02x%02x%02x\n", offset, reg[7], reg[6], reg[5], reg[4], reg[3], reg[2], reg[1], reg[0]);
        }
      }
    }
  }
  fclose(fd);
  ltime = time(NULL);
  fprintf(stderr, "Done Dumping L2 After Loading @ %s\n", asctime(localtime(&ltime)));
}

#define release_vp_reset(proj, target) \
  void proj::release_vp##target##_reset(std::string key) { \
    bool bp = false; \
    bool instret = false; \
    std::vector<uint64_t> breakpoints; \
    std::vector<uint64_t> inst_breakpoints; \
    if (this->ht->argmap["test_bp="].length()>0) { \
      std::string mode = this->ht->argmap["test_bp="]; \
      if (mode.compare("step_through") == 0) { \
        this->ht->OURSBUS_WRITE(STATION_VP_S2B_DEBUG_STALL_ADDR_##target, 0x00000001); \
      } \
      bp = true;\
      breakpoints = get_breakpoints(this->ht->argmap["bp_pc="]);\
    } \
    if (this->ht->argmap["test_instret="].length()>0) { \
      std::string mode = this->ht->argmap["test_instret="]; \
      if (mode.compare("step_through") == 0) { \
        this->ht->OURSBUS_WRITE(STATION_VP_S2B_DEBUG_STALL_ADDR_##target, 0x00000001); \
      } \
      instret = true;\
      inst_breakpoints = get_breakpoints(this->ht->argmap["instret="]);\
    } \
    ltime = time(NULL); \
    fprintf(stderr, "Start Releasing VP %0d Reset @ %s\n", target, asctime(localtime(&ltime))); \
    fprintf(stderr, "bp = %0d\n", bp); \
    char arg[100]; \
    sprintf(arg, "release_vp%s_reset", #target); \
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_EARLY_RSTN_ADDR_##target, 1); \
    this->ht->OURSBUS_WRITE(STATION_VP_S2B_RSTN_ADDR_##target, 1); \
    if (bp) { \
      std::vector<uint64_t> station_en_addr={STATION_VP_S2B_EN_BP_IF_PC_0_ADDR_##target, \
                                             STATION_VP_S2B_EN_BP_IF_PC_1_ADDR_##target, \
                                             STATION_VP_S2B_EN_BP_IF_PC_2_ADDR_##target, \
                                             STATION_VP_S2B_EN_BP_IF_PC_3_ADDR_##target,  \
                                             STATION_VP_S2B_EN_BP_WB_PC_0_ADDR_##target,  \
                                             STATION_VP_S2B_EN_BP_WB_PC_1_ADDR_##target,  \
                                             STATION_VP_S2B_EN_BP_WB_PC_2_ADDR_##target,  \
                                             STATION_VP_S2B_EN_BP_WB_PC_3_ADDR_##target  \
                                            }; \
      std::vector<uint64_t> station_addr={STATION_VP_S2B_BP_IF_PC_0_ADDR_##target, \
                                          STATION_VP_S2B_BP_IF_PC_1_ADDR_##target, \
                                          STATION_VP_S2B_BP_IF_PC_2_ADDR_##target, \
                                          STATION_VP_S2B_BP_IF_PC_3_ADDR_##target,  \
                                          STATION_VP_S2B_BP_WB_PC_0_ADDR_##target,  \
                                          STATION_VP_S2B_BP_WB_PC_1_ADDR_##target,  \
                                          STATION_VP_S2B_BP_WB_PC_2_ADDR_##target,  \
                                          STATION_VP_S2B_BP_WB_PC_3_ADDR_##target  \
                                          }; \
      set_breakpoints(station_en_addr, station_addr, breakpoints); \
    } \
    if (instret) { \
      std::vector<uint64_t> station_en_addr={STATION_VP_S2B_EN_BP_INSTRET_ADDR_##target \
                                            }; \
      std::vector<uint64_t> station_addr={STATION_VP_S2B_BP_INSTRET_ADDR_##target \
                                          }; \
      set_breakpoints(station_en_addr, station_addr, inst_breakpoints); \
    } \
   ltime = time(NULL); \
   fprintf(stderr, "Done Releasing VCORE %0d Reset @ %s\n", target, asctime(localtime(&ltime))); \
  }

release_vp_reset(es1y, 0)
release_vp_reset(es1y, 1)
release_vp_reset(es1y, 2)
release_vp_reset(es1y, 3)

void es1y::release_all_vp_reset(std::string key){
  release_vp0_reset(key);
  release_vp1_reset(key);
  release_vp2_reset(key);
  release_vp3_reset(key);
}

//argmap
void es1y::mem_test(std::string key){
  // Memory Test
  ltime = time(NULL);
  fprintf(stderr, "Start Mem Test @ %s\n", asctime(localtime(&ltime)));

  std::ifstream f (this->ht->argmap["mem_test="].c_str());
  //std::ifstream f ("/work/users/tian/es1y-syn/verif/tb/fpga_es1y/torture_80000000");
  if (!f) {
    fprintf(stderr, "%s is not presented!\n", this->ht->argmap["mem_test="].c_str());
  }
  else {
    std::string str[3];
    while (f) {
      f >> str[0];
      f >> str[1];
      f >> str[2];
      if (str[0].compare("WR") == 0) {
        uint64_t data = std::stoul(str[2], nullptr, 0);
        for (int i = 0; i < 8; i++)
          reg[i] = (data >> (i * 8)) & 0xff;
        this->ht->mem.write(std::stoul(str[1], nullptr, 0), 8, (uint8_t*)reg);
        fprintf(stderr, "Done writing to address %s with data %s\n", str[1].c_str(), str[2].c_str());
      } else {
        this->ht->mem.read(std::stoul(str[1], nullptr, 0), 8, (uint8_t*)reg);
        uint64_t data = 0;
        for (int i = 7; i >= 0; i--)
          data = (data << 8) + reg[i];
        if (str[2].compare("X") != 0) {
          if (data == std::stoul(str[2], nullptr, 0)) {
            fprintf(stderr, "Done reading to address %s, got data 0x%lx, match expectation\n", str[1].c_str(), data);
          } else {
            fprintf(stderr, "Done reading to address %s, got data 0x%lx, expecting %s\n", str[1].c_str(), data, str[2].c_str());
          }
        } else {
          fprintf(stderr, "Done reading to address %s, got data 0x%lx, do not check\n", str[1].c_str(), data);
        }
      }
    }
  }
  ltime = time(NULL);
  fprintf(stderr, "Done Mem Test @ %s\n", asctime(localtime(&ltime)));
}

void es1y::enable_dram_tester(std::string key){
  ltime = time(NULL);
  fprintf(stderr, "Start Enabling DRAM Tester @ %s\n", asctime(localtime(&ltime)));

  int idx, mode, err_inj, err_inj_cnt, stress;
  uint64_t addr, wdata, err_cnt, rdata, base_addr;
  uint64_t msb, poly, lfsr;
  uint64_t err_addr[8], err_data[8];

  if (this->ht->argmap["simple_dt"].length() > 0) {
    mode = 2;
    fprintf(stderr, "Start Simple dt\n");
    this->ht->OURSBUS_WRITE(STATION_DT_MODE_ADDR, mode);
    for (idx = 0; idx < 4; idx++) {
      addr = (random() % 0x20000000 + 0x80000000) & 0xffffffe0;
      wdata = (random() << 32) + random();
      this->ht->OURSBUS_WRITE(STATION_DT_PRAM_ADDR_ADDR + (idx << 4), addr + 0x2);
      this->ht->OURSBUS_WRITE(STATION_DT_PRAM_DATA_ADDR + (idx << 4), wdata);
      this->ht->OURSBUS_WRITE(STATION_DT_PRAM_ADDR_ADDR + ((idx << 4)+8), addr + 0x1);
      this->ht->OURSBUS_WRITE(STATION_DT_PRAM_DATA_ADDR + ((idx << 4)+8), wdata);
    }
    // Write 0 to end
    this->ht->OURSBUS_WRITE(STATION_DT_PRAM_ADDR_ADDR + 0x40, 0);
    this->ht->OURSBUS_WRITE(STATION_DT_PRAM_DATA_ADDR + 0x40, 0);

    this->ht->OURSBUS_WRITE(STATION_DT_ACTIVATE_ADDR, 1);
    // Polling busy bit
    rdata = 0;
    while (rdata != 1) {
      this->ht->OURSBUS_READ_4B(STATION_DT_BUSY_ADDR, rdata);
    }
    fprintf(stderr, "Simple DT Activated\n");

    while (rdata != 0) {
      this->ht->OURSBUS_READ_4B(STATION_DT_BUSY_ADDR, rdata);
    }
    fprintf(stderr, "Simple DT finished\n");

    // Check Error
    this->ht->OURSBUS_READ_4B(STATION_DT_ERR_CNT_ADDR, err_cnt);
    if (err_cnt != 0) {
      fprintf(stderr, "Error: Simple dt found error, err_cnt = 0x%x, Start checking ERAM\n", err_cnt);
      for (idx = 0; idx < err_cnt; idx++) {
        this->ht->OURSBUS_READ_4B(STATION_DT_ERAM_ADDR_ADDR + (idx << 3), rdata);
        fprintf(stderr, "Error: eram addr = 0x%lx,\n", rdata);
        this->ht->OURSBUS_READ_4B(STATION_DT_ERAM_DATA_ADDR + (idx << 3), rdata);
        fprintf(stderr, "Error: eram data = 0x%lx\n", rdata);
      }
    } else {
      fprintf(stderr, "Simple dt passed!\n");
    }
  } else {
    mode = (random() % 3) + 1; // No dbg mode, covered with +use_dt
    stress = random() % 2;
    //mode = 2;
    //stress = 1;
    this->ht->OURSBUS_WRITE(STATION_DT_MODE_ADDR, mode);
    fprintf(stderr, "DT mode = 0x%x\n", mode);

    // PRAM & PRAM SINGLE
    if ((mode == 1) || (mode == 2)) {
      err_inj_cnt = 0;
      base_addr = (random() % 0x80000000 + 0x80000000) & 0xffffffe0; // For stress
      for (idx = 0; idx < 128 / 2; idx++) {
        if (stress == 0) {
          addr = (random() % 0x80000000 + 0x80000000) & 0xffffffe0;
        } else {
          addr = base_addr + (idx << 5);
        }
        wdata = (random() << 32) + random();
        err_inj = random() % 10;

        // Write first
        if (stress == 0) {
          // single write followed by single read
          this->ht->OURSBUS_WRITE(STATION_DT_PRAM_ADDR_ADDR + (idx << 4), addr + 0x2);
          this->ht->OURSBUS_WRITE(STATION_DT_PRAM_DATA_ADDR + (idx << 4), wdata);
          this->ht->OURSBUS_WRITE(STATION_DT_PRAM_ADDR_ADDR + ((idx << 4)+8), addr + 0x1);
        } else {
          // 64 writes followed by 64 read
          this->ht->OURSBUS_WRITE(STATION_DT_PRAM_ADDR_ADDR + (idx << 3), addr + 0x2);
          this->ht->OURSBUS_WRITE(STATION_DT_PRAM_DATA_ADDR + (idx << 3), wdata);
          this->ht->OURSBUS_WRITE(STATION_DT_PRAM_ADDR_ADDR + ((idx + 64) << 3), addr + 0x1);
        }

        // Error injection control, dt can only log 8 errors
        if ((err_inj > 8) && (err_inj_cnt < 8)) {
          if (stress == 0) {
            this->ht->OURSBUS_WRITE(STATION_DT_PRAM_DATA_ADDR + ((idx << 4)+8), (wdata+1));
          } else {
            this->ht->OURSBUS_WRITE(STATION_DT_PRAM_DATA_ADDR + ((idx + 64) << 3), (wdata+1));
          }
          fprintf(stderr, "Err injection: addr = 0x%0x, data = 0x%0x\n", addr, wdata);
          // Log error injection
          for (int i = 0; i < 4; i++) {
            err_addr[err_inj_cnt] = addr + i;
            err_data[err_inj_cnt] = wdata;
            err_inj_cnt++;
          }
        } else {
          if (stress == 0) {
            this->ht->OURSBUS_WRITE(STATION_DT_PRAM_DATA_ADDR + ((idx << 4)+8), wdata);
          } else {
            this->ht->OURSBUS_WRITE(STATION_DT_PRAM_DATA_ADDR + ((idx + 64) << 3), wdata);
          }
        }
      }

      this->ht->OURSBUS_WRITE(STATION_DT_ACTIVATE_ADDR, 1);

      if (mode == 1) { // PRAM mode need to de-activate
        for (int i = 0; i < 8000; i++) {
          // Wait for some time
          this->ht->OURSBUS_READ_4B(STATION_DT_ACTIVATE_ADDR, rdata);
        }
        this->ht->OURSBUS_WRITE(STATION_DT_ACTIVATE_ADDR, 0);
      }

      // Polling busy bit
      rdata = 0;
      while (rdata != 1) {
        this->ht->OURSBUS_READ_4B(STATION_DT_BUSY_ADDR, rdata);
      }
      fprintf(stderr, "DT Activated\n");

      rdata = 1;
      while (rdata != 0) {
        this->ht->OURSBUS_READ_4B(STATION_DT_BUSY_ADDR, rdata);
      }
      fprintf(stderr, "DT finished\n");

      // Check Error
      this->ht->OURSBUS_READ_4B(STATION_DT_ERR_CNT_ADDR, err_cnt);
      if (err_cnt != err_inj_cnt) {
        fprintf(stderr, "Error: cnt doesn't match, err_inj_cnt = 0x%x, err_cnt = 0x%x\n", err_inj_cnt, err_cnt);
      } else {
        // Check error ram
        fprintf(stderr, "DT found error dut to error injection, err cnt is 0x%x, checking eram\n", err_cnt);
        for (idx = 0; idx < err_cnt; idx++) {
          this->ht->OURSBUS_READ_4B(STATION_DT_ERAM_ADDR_ADDR + (idx << 3), rdata);
          if (rdata != err_addr[idx]) { 
            fprintf(stderr, "Error: eram addr mismatch, idx = 0x%x, exp = 0x%x, real = 0x%x\n", idx, err_addr[idx], rdata);
          }
          this->ht->OURSBUS_READ_4B(STATION_DT_ERAM_DATA_ADDR + (idx << 3), rdata);
          if (rdata != (err_data[idx] & 0xffffffff)) {
            fprintf(stderr, "Error: eram data mismatch, idx = 0x%x, exp = 0x%lx, real = 0x%lx\n", idx, err_data[idx], rdata);
          }
        }
      }

      // Clear eram
      this->ht->OURSBUS_WRITE(STATION_DT_ERR_CNT_ADDR, 0);
    }

    // LFSR
    else if (mode == 3) {
      poly = random() % 0x7ffffff;
      lfsr = random() % 0x7ffffff;

      this->ht->OURSBUS_WRITE(STATION_DT_INIT_MSB_ADDR_ADDR, 32-5);
      this->ht->OURSBUS_WRITE(STATION_DT_INIT_MSB_DATA_ADDR, 64);
      this->ht->OURSBUS_WRITE(STATION_DT_INIT_POLY_ADDR_ADDR, poly);
      this->ht->OURSBUS_WRITE(STATION_DT_INIT_POLY_DATA_ADDR, poly);
      this->ht->OURSBUS_WRITE(STATION_DT_INIT_LFSR_ADDR_ADDR, lfsr);
      this->ht->OURSBUS_WRITE(STATION_DT_INIT_LFSR_DATA_ADDR, lfsr);
      this->ht->OURSBUS_WRITE(STATION_DT_ACTIVATE_ADDR, 1);

      for (int i = 0; i < 800; i++) {
        // Wait for some time
        this->ht->OURSBUS_READ_4B(STATION_DT_ACTIVATE_ADDR, rdata);
      }
      this->ht->OURSBUS_WRITE(STATION_DT_ACTIVATE_ADDR, 0);

      // Polling busy bit
      rdata = 1;
      while (rdata != 0) {
        this->ht->OURSBUS_READ_4B(STATION_DT_BUSY_ADDR, rdata);
      }
      fprintf(stderr, "DT finished\n");

      // Check Error
      this->ht->OURSBUS_READ_4B(STATION_DT_ERR_CNT_ADDR, err_cnt);
      if (err_cnt != 0) {
        fprintf(stderr, "Error: Random mode found error, err_cnt = 0x%x\n", err_cnt);
        // Print eram addr and data
        for (idx = 0; idx < err_cnt; idx++) {
          this->ht->OURSBUS_READ_4B(STATION_DT_ERAM_ADDR_ADDR + (idx << 3), err_addr[idx]);
          this->ht->OURSBUS_READ_4B(STATION_DT_ERAM_DATA_ADDR + (idx << 3), err_data[idx]);
          fprintf(stderr, "Checking eram: idx = 0x%x, addr = 0x%x, data = 0x%x\n", idx, err_addr[idx], err_data[idx]);
        }
      }
    }
  }
  fprintf(stderr, "Done Enabling DRAM Tester @ %s\n", asctime(localtime(&ltime)));
}

// symbols
void es1y::release_orv32_reset(std::string key){
    ltime = time(NULL);
    fprintf(stderr, "Start Releasing ORV32 Reset @ %s\n", asctime(localtime(&ltime)));
    // Set Breakpoints
    if (this->ht->argmap["test_bp="].length()>0){
      std::string mode = this->ht->argmap["test_bp="];
      if (mode.compare("step_through") == 0){
        this->ht->OURSBUS_WRITE(STATION_ORV32_S2B_DEBUG_STALL_ADDR,0x00000001);
      }
      std::vector<uint64_t> breakpoints = get_breakpoints(this->ht->argmap["bp_pc="]);
      std::vector<uint64_t> station_en_addr={STATION_ORV32_S2B_EN_BP_IF_PC_0_ADDR,
                                             STATION_ORV32_S2B_EN_BP_IF_PC_1_ADDR,
                                             STATION_ORV32_S2B_EN_BP_IF_PC_2_ADDR,
                                             STATION_ORV32_S2B_EN_BP_IF_PC_3_ADDR,
                                             STATION_ORV32_S2B_EN_BP_WB_PC_0_ADDR,
                                             STATION_ORV32_S2B_EN_BP_WB_PC_1_ADDR,
                                             STATION_ORV32_S2B_EN_BP_WB_PC_2_ADDR,
                                             STATION_ORV32_S2B_EN_BP_WB_PC_3_ADDR
                                            };
      std::vector<uint64_t> station_addr={STATION_ORV32_S2B_BP_IF_PC_0_ADDR,
                                          STATION_ORV32_S2B_BP_IF_PC_1_ADDR,
                                          STATION_ORV32_S2B_BP_IF_PC_2_ADDR,
                                          STATION_ORV32_S2B_BP_IF_PC_3_ADDR,
                                          STATION_ORV32_S2B_BP_WB_PC_0_ADDR,
                                          STATION_ORV32_S2B_BP_WB_PC_1_ADDR,
                                          STATION_ORV32_S2B_BP_WB_PC_2_ADDR,
                                          STATION_ORV32_S2B_BP_WB_PC_3_ADDR
                                          };
      set_breakpoints(station_en_addr, station_addr, breakpoints);
    }
    this->ht->OURSBUS_WRITE(STATION_ORV32_S2B_EARLY_RSTN_ADDR, 1);
    this->ht->OURSBUS_WRITE(STATION_ORV32_S2B_RSTN_ADDR, 1);
    ltime = time(NULL);
    fprintf(stderr, "Done Releasing ORV32 Reset @ %s\n", asctime(localtime(&ltime)));
}

// IO reg access
void es1y::io_reg_test(std::string key){
  fprintf(stderr, "Start io reg testing @ %s\n", asctime(localtime(&ltime)));
  uint64_t wdata;
  uint64_t rdata = 0;
  uint64_t addr;
  uint64_t orig_data = 0;

  // QSPIM
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_QSPIM_BLOCK_REG_ADDR + 0x5c, rdata);
  if (rdata != 0x3430322a) {
    fprintf(stderr, "Error: qspim version id wrong, rdata = 0x%x\n", rdata);
  }
  // SSPIM0
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 0x5c, rdata);
  if (rdata != 0x3430312a) {
    fprintf(stderr, "Error: sspim0 version id wrong, rdata = 0x%x\n", rdata);
  }
  // SSPIM1
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM1_BLOCK_REG_ADDR + 0x5c, rdata);
  if (rdata != 0x3430312a) {
    fprintf(stderr, "Error: sspim1 version id wrong, rdata = 0x%x\n", rdata);
  }
  // SSPIM2
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SSPIM2_BLOCK_REG_ADDR + 0x5c, rdata);
  if (rdata != 0x3430312a) {
    fprintf(stderr, "Error: sspim2 version id wrong, rdata = 0x%x\n", rdata);
  }
  // SPIS
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 0x5c, rdata);
  if (rdata != 0x3430312a) {
    fprintf(stderr, "Error: spis version id wrong, rdata = 0x%x\n", rdata);
  }
  // UART0
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART0_BLOCK_REG_ADDR + 0xf8, rdata);
  if (rdata != 0x3430312a) {
    fprintf(stderr, "Error: uart0 lsr reg reset value wrong, rdata = 0x%x\n", rdata);
  }
  // UART1
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART1_BLOCK_REG_ADDR + 0xf8, rdata);
  if (rdata != 0x3430312a) {
    fprintf(stderr, "Error: uart1 lsr reg reset value wrong, rdata = 0x%x\n", rdata);
  }
  // UART2
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART2_BLOCK_REG_ADDR + 0xf8, rdata);
  if (rdata != 0x3430312a) {
    fprintf(stderr, "Error: uart2 lsr reg reset value wrong, rdata = 0x%x\n", rdata);
  }
  // UART3
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_UART3_BLOCK_REG_ADDR + 0xf8, rdata);
  if (rdata != 0x3430312a) {
    fprintf(stderr, "Error: uart3 lsr reg reset value wrong, rdata = 0x%x\n", rdata);
  }
  // I2SM
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SM_BLOCK_REG_ADDR + 0x1f8, rdata);
  if (rdata != 0x3131302a) {
    fprintf(stderr, "Error: i2sm version id wrong, rdata = 0x%x\n", rdata);
  }
  // I2SS0
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS0_BLOCK_REG_ADDR + 0x1f8, rdata);
  if (rdata != 0x3131302a) {
    fprintf(stderr, "Error: i2ss0 version id wrong, rdata = 0x%x\n", rdata);
  }
  // I2SS1
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS1_BLOCK_REG_ADDR + 0x1f8, rdata);
  if (rdata != 0x3131302a) {
    fprintf(stderr, "Error: i2ss1 version id wrong, rdata = 0x%x\n", rdata);
  }
  // I2SS2
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS2_BLOCK_REG_ADDR + 0x1f8, rdata);
  if (rdata != 0x3131302a) {
    fprintf(stderr, "Error: i2ss2 version id wrong, rdata = 0x%x\n", rdata);
  }
  // I2SS3
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS3_BLOCK_REG_ADDR + 0x1f8, rdata);
  if (rdata != 0x3131302a) {
    fprintf(stderr, "Error: i2ss3 version id wrong, rdata = 0x%x\n", rdata);
  }
  // I2SS4
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS4_BLOCK_REG_ADDR + 0x1f8, rdata);
  if (rdata != 0x3131302a) {
    fprintf(stderr, "Error: i2ss4 version id wrong, rdata = 0x%x\n", rdata);
  }
  // I2SS5
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2SS5_BLOCK_REG_ADDR + 0x1f8, rdata);
  if (rdata != 0x3131302a) {
    fprintf(stderr, "Error: i2ss5 version id wrong, rdata = 0x%x\n", rdata);
  }
  // I2C0
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C0_BLOCK_REG_ADDR + 0xf8, rdata);
  if (rdata != 0x3230312a) {
    fprintf(stderr, "Error: i2c0 version id wrong, rdata = 0x%x\n", rdata);
  }
  // I2C1
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C1_BLOCK_REG_ADDR + 0xf8, rdata);
  if (rdata != 0x3230312a) {
    fprintf(stderr, "Error: i2c1 version id wrong, rdata = 0x%x\n", rdata);
  }
  // I2C2
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_I2C2_BLOCK_REG_ADDR + 0xf8, rdata);
  if (rdata != 0x3230312a) {
    fprintf(stderr, "Error: i2c2 version id wrong, rdata = 0x%x\n", rdata);
  }
  // GPIO
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_GPIO_BLOCK_REG_ADDR + 0x6c, rdata);
  if (rdata != 0x3231322a) {
    fprintf(stderr, "Error: gpio version id wrong, rdata = 0x%x\n", rdata);
  }
  // RTC
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_RTC_BLOCK_REG_ADDR + 0x1c, rdata);
  if (rdata != 0x3230362a) {
    fprintf(stderr, "Error: rtc version id wrong, rdata = 0x%x\n", rdata);
  }
  // TIMERS
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_TIMERS_BLOCK_REG_ADDR + 0xac, rdata);
  if (rdata != 0x3231312a) {
    fprintf(stderr, "Error: timers version id wrong, rdata = 0x%x\n", rdata);
  }
  // WDT
  this->ht->OURSBUS_READ_4B(STATION_SLOW_IO_WDT_BLOCK_REG_ADDR + 0xf8, rdata);
  if (rdata != 0x3131302a) {
    fprintf(stderr, "Error: timers version id wrong, rdata = 0x%x\n", rdata);
  }

  // USB
  if (this->ht->argmap["reset_usb"].length() > 0) {
    ltime = time(NULL);
    fprintf(stderr, "Start Accessing USB @ %s\n", asctime(localtime(&ltime)));
    // Core reset
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_S2B_VCC_RESET_N_ADDR, 0x1);
    this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc128, rdata);
    if (rdata != 0x12345678) {
      fprintf(stderr, "Error: USB GUID wrong, rdata = 0x%x\n", rdata);
    }
    wdata = random();
    this->ht->OURSBUS_WRITE(STATION_USB_TOP_USB3_CFG_ADDR + 0xc128, wdata);
    this->ht->OURSBUS_READ_4B(STATION_USB_TOP_USB3_CFG_ADDR + 0xc128, rdata);
    if (rdata != wdata) {
      fprintf(stderr, "Error: USB GUID access wrong, wdata = 0x%x, rdata = 0x%x\n", wdata, rdata);
    }
  }

  if (this->ht->argmap["reset_ddr"].length() > 0) {
    // DDR
    ltime = time(NULL);
    fprintf(stderr, "Start Program DDR @ %s\n", asctime(localtime(&ltime)));

    this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0000 << 2), 0x0); // Enable access to PHY registers
    this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_PHY_ADDR + (0xc0080 << 2), 0x7); // DWC_DDRPHYA_DRTUB0_UcclkHclkEnables
    this->ht->OURSBUS_READ_4B(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0099 << 2), orig_data); //Enable access to SRAM by stall ARCv2
    fprintf(stderr, "Stall ARCv2 ICCMs, original MicroReset value = 0x%x\n", orig_data);
    wdata = orig_data | 0x1;
    this->ht->OURSBUS_WRITE(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0099 << 2), wdata);

    //Memory Controller registers
    int index = random() % 3;
    wdata = random();
    fprintf(stderr, "Memory Controller data = 0x%x\n", index, wdata);
    if (index == 0) {
      fprintf(stderr, "Start Accessing UMCTL2_REGS, data = 0x%x\n", wdata);
      addr = STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x30 << 2);
      this->ht->OURSBUS_READ_4B(addr, orig_data); // PWRCTL
      fprintf(stderr, "original UMCTL2_REGS register value = 0x%x\n", orig_data);      
      this->ht->OURSBUS_WRITE(addr, wdata);
      this->ht->OURSBUS_READ_4B(addr, rdata);
      if ((rdata & 0x1ef) != (wdata & 0x1ef)) {
        fprintf(stderr, "Error: Reading UMCTL2_REGS with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, (wdata & 0x1ef), (rdata & 0x1ef));
      }
      this->ht->OURSBUS_WRITE(addr, orig_data); //restore the original data
    } else if (index == 1) {
      fprintf(stderr, "Start Accessing UMCTL2_MP\n");      
      addr = STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x490 << 2);
      this->ht->OURSBUS_READ_4B(addr, orig_data); // PCTRL_1
      fprintf(stderr, "original UMCTL2_MP register value = 0x%x\n", orig_data);      
      this->ht->OURSBUS_WRITE(addr, wdata);
      this->ht->OURSBUS_READ_4B(addr, rdata);
      if ((rdata & 0x1) != (wdata & 0x1)) {
        fprintf(stderr, "Error: Reading UMCTL2_MP with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, (wdata & 0x1), (rdata & 0x1));
      }
      this->ht->OURSBUS_WRITE(addr, orig_data); //restore the original data
    } else if (index == 2) {
      fprintf(stderr, "Start Accessing UMCTL2_REGS_FREQ1\n");      
      addr = STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x2050 << 2);
      this->ht->OURSBUS_READ_4B(addr, orig_data); // RFSHCT0
      fprintf(stderr, "original UMCTL2_REGS_FREQ1 register value = 0x%x\n", orig_data);      
      this->ht->OURSBUS_WRITE(addr, wdata);
      this->ht->OURSBUS_READ_4B(addr, rdata);
      if ((rdata & 0xf1f3f0) != (wdata & 0xf1f3f0)) {
        fprintf(stderr, "Error: Reading UMCTL2_REGS_FREQ1 with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, (wdata & 0xf1f3f0), (rdata & 0xf1f3f0));
      }
      this->ht->OURSBUS_WRITE(addr, orig_data); //restore the original data
    }

    //PHY
    fprintf(stderr, "Start Programming DDR PHY REGs\n");
    index = random() % 2; // if index is 1 then access dbyte1 registers. otherwise access dbyte0 registers
    fprintf(stderr, "PHY register reading index= 0x%x\n", index);

    wdata = random();
    addr = (STATION_DDR_TOP_DDR_PHY_ADDR + (0x100d0 << 2) + ((index * 0x1000) << 2)); //TxDqsDlyTg0_u0_p0, related to write leveling
    this->ht->OURSBUS_READ_4B(addr, orig_data);
    fprintf(stderr, "original TxDqsDlyTg0_u0_p0 value = 0x%x\n", orig_data);      
    this->ht->OURSBUS_WRITE(addr, wdata);
    this->ht->OURSBUS_READ_4B(addr, rdata);
    if ((rdata & 0xf) != (wdata & 0xf)) {
      fprintf(stderr, "Error: Reading TxDqsDlyTg0_u0_p0 with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, wdata, rdata);
    }
    this->ht->OURSBUS_WRITE(addr, orig_data);

    //SRAM, each address contains 16-bit word
    //ICCM
    fprintf(stderr, "Start Accessing ICCMs\n");
    wdata = random();
    addr = STATION_DDR_TOP_DDR_PHY_ADDR + (0x50000 << 2) + ((random() % 0x3ff8) << 2);
    this->ht->OURSBUS_WRITE(addr, wdata);
    this->ht->OURSBUS_READ_4B(addr, rdata);
    if (rdata != (wdata & 0xffff)) {
      fprintf(stderr, "Error: Reading ICCM with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, wdata, rdata);
    }

    //DCCM
    fprintf(stderr, "Start Accessing DCCMs\n");
    wdata = random();
    addr = STATION_DDR_TOP_DDR_PHY_ADDR + (0x54000 << 2) + ((random() % 0x400) << 2);
    this->ht->OURSBUS_WRITE(addr, wdata);
    this->ht->OURSBUS_READ_4B(addr, rdata);
    if (rdata != (wdata & 0xffff)) {
      fprintf(stderr, "Error: Reading DCCM with Addr 0x%lx, Expected Data: 0x%x, Got Data 0x%x\n", addr, wdata, rdata);
    }

    // Restore the value
    this->ht->OURSBUS_WRITE(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0099 << 2), 0x1);
    this->ht->OURSBUS_WRITE(STATION_DDR_TOP_DDR_PHY_ADDR + (0xd0000 << 2), 0x1); // Disable access to PHY registers

    //SDRAM Mode register Read
    //Read MR5
    fprintf(stderr, "Start Accessing SDRAM MRs\n");
    this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x14 << 2), 0x00000500);
    this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x00000011);
    this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x80000011);

    rdata = 0x1;
    while ((rdata & 0x1) != 0) {
      this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x18 << 2), rdata); 
    }

    rdata = 0x0;
    while (rdata != 1) {
      this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_ADDR, rdata); 
    }
    this->ht->OURSBUS_READ (STATION_DDR_TOP_B2S_RD_MRR_DATA_ADDR, orig_data);
    if((orig_data & 0xff) != 0xff) {
      fprintf(stderr, "Error: MR5 value is 0x%x\n", orig_data);
    }
    this->ht->OURSBUS_WRITE (STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_ADDR, 0x0); 

    //Read MR6
    this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x14 << 2), 0x00000600);
    this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x00000011);
    this->ht->OURSBUS_WRITE (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x10 << 2), 0x80000011);

    rdata = 0x1;
    while ((rdata & 0x1) != 0) {
      this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_DDR_UCTRL_ADDR + (0x18 << 2), rdata); 
    }

    rdata = 0x0;
    while (rdata != 1) {
      this->ht->OURSBUS_READ_4B (STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_ADDR, rdata); 
    }
    this->ht->OURSBUS_READ (STATION_DDR_TOP_B2S_RD_MRR_DATA_ADDR, orig_data); //DDR2RB
    if((orig_data & 0xff) != 0) {
      fprintf(stderr, "Error: MR6 value is 0x%x\n", orig_data);
    }
    this->ht->OURSBUS_WRITE (STATION_DDR_TOP_B2S_RD_MRR_DATA_VALID_ADDR, 0x0); 
  }

  // SDIO
  if (this->ht->argmap["reset_sdio"].length() > 0) {
    fprintf(stderr, "Start Accessing SDIO\n");
    wdata = random();
    this->ht->OURSBUS_WRITE(STATION_SDIO_MSHC_CTRL_ADDR + 0x34, wdata);
    this->ht->OURSBUS_READ_4B(STATION_SDIO_MSHC_CTRL_ADDR + 0x34, rdata);
    if ((rdata & 0xff) != (wdata & 0xff)) {
      fprintf(stderr, "Error: SDIO Reg access data mismatch, wdata = 0x%x, rdata = 0x%x\n", wdata, rdata);
    }
  }
  fprintf(stderr, "Done io reg testing @ %s\n", asctime(localtime(&ltime)));
}

void es1y::enable_flash_fsm(std::string key){
  ltime = time(NULL);
  fprintf(stderr, "Start Enabling Flash FSM @ %s\n", asctime(localtime(&ltime)));
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_S2B_BOOT_FROM_FLASH_ENA_ADDR, 1);
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_S2B_BOOT_FROM_FLASH_ENA_SW_CTRL_ADDR, 1);
  fprintf(stderr, "Done Enabling Flash FSM @ %s\n", asctime(localtime(&ltime)));
}

void es1y::enable_boot_fsm(std::string key){
  ltime = time(NULL);
  fprintf(stderr, "Start Enabling Flash FSM @ %s\n", asctime(localtime(&ltime)));
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_S2B_BOOTUP_ENA_ADDR, 1);
  this->ht->OURSBUS_WRITE(STATION_SLOW_IO_S2B_BOOTUP_ENA_SW_CTRL_ADDR, 1);
  fprintf(stderr, "Done Enabling Flash FSM @ %s\n", asctime(localtime(&ltime)));
}

void es1y::read_from_flash(std::string key){
  uint64_t rdata;
  ltime = time(NULL);
  fprintf(stderr, "Start Reading from flash @ %s\n", asctime(localtime(&ltime)));
  this->ht->OURSBUS_READ(STATION_SLOW_IO_FLASH_ADDR, rdata);
  if (rdata != 0x8967452301efcdab) {
    fprintf(stderr, "Error: Flash content at addr 0x0 wrong, rdata = 0x%x\n", rdata);
  }
  this->ht->OURSBUS_READ(STATION_SLOW_IO_FLASH_ADDR + 0x8, rdata);
  if(rdata != 0x1111111111111111) {
    fprintf(stderr, "Error: Flash content at addr 0x8 wrong, rdata = 0x%x\n", rdata);
  }
}

void es1y::trigger_afterwards(std::string key){
  // Trigger after everything is done
    ltime = time(NULL);
    fprintf(stderr, "Start Triggering Afterwards @ %s\n", asctime(localtime(&ltime)));
    reg[0] = 0x00;
    reg[1] = 0x00;
    reg[2] = 0x00;
    reg[3] = 0x00;
    reg[4] = 0x00;
    reg[5] = 0x00;
    reg[6] = 0x00;
    reg[7] = 0x00;
    this->ht->mem.write(0xffffffff00, 8, (uint8_t*)reg);
    ltime = time(NULL);
    fprintf(stderr, "Done Triggering Afterwards @ %s\n", asctime(localtime(&ltime)));
}
