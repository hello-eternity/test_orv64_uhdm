// See LICENSE for license details.

#include "syscall.h"
#include "htif.h"
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <limits.h>
#include <errno.h>
#include <stdlib.h>
#include <assert.h>
#include <termios.h>
#include <sstream>
#include <iostream>
#include <unistd.h>
#include <math.h>
#include <inttypes.h>

// Needed for TCP Socket (some might be not needed)
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
using namespace std::placeholders;

#define PORT 2001
#define RISCV_AT_FDCWD -100

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"

typedef unsigned char byte;

#define BYTE_TO_BINARY(byte) \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0')
struct riscv_stat
{
  uint64_t dev;
  uint64_t ino;
  uint32_t mode;
  uint32_t nlink;
  uint32_t uid;
  uint32_t gid;
  uint64_t rdev;
  uint64_t __pad1;
  uint64_t size;
  uint32_t blksize;
  uint32_t __pad2;
  uint64_t blocks;
  uint64_t atime;
  uint64_t __pad3;
  uint64_t mtime;
  uint64_t __pad4;
  uint64_t ctime;
  uint64_t __pad5;
  uint32_t __unused4;
  uint32_t __unused5;

  riscv_stat(const struct stat& s)
    : dev(s.st_dev), ino(s.st_ino), mode(s.st_mode), nlink(s.st_nlink),
      uid(s.st_uid), gid(s.st_gid), rdev(s.st_rdev), __pad1(0),
      size(s.st_size), blksize(s.st_blksize), __pad2(0),
      blocks(s.st_blocks), atime(s.st_atime), __pad3(0),
      mtime(s.st_mtime), __pad4(0), ctime(s.st_ctime), __pad5(0),
      __unused4(0), __unused5(0) {}
};

console_t::console_t() {

//   char cwd[1024];
//   if (getcwd(cwd, sizeof(cwd)) != NULL)
//     fprintf(stderr, "Current working dir: %s\n", cwd);

  //fprintf(stderr, "sys_read_console: map read_console.txt\n");
  int fd_read_console = open("/tmp/read_console.txt", O_RDONLY, 0600);
  void* addr_read_console = mmap(0, 1024, PROT_READ, MAP_SHARED, fd_read_console, 0);
  //fprintf(stderr, "  mapped at %p\n", addr_read_console);
  if (addr_read_console == MAP_FAILED) {
    //fprintf(stderr, "  map failed\n");
  }
  read_console = (char*)addr_read_console;
  read_console_index = 0;
 
  //fprintf(stderr, "sys_read_console: map read_console_done.txt\n");
  int fd_read_console_done = open("/tmp/read_console_done.txt", O_RDWR, 0600);
  void* addr_read_console_done = mmap(0, 8, PROT_READ | PROT_WRITE, MAP_SHARED, fd_read_console_done, 0);
  //fprintf(stderr, "  mapped at %p\n", addr_read_console_done);
  if (addr_read_console_done == MAP_FAILED) {
    //fprintf(stderr, "  map failed\n");
  }
  read_console_done = (int*)addr_read_console_done;
  std::cout.flush();
//   read_console[1] = 1;

  //fprintf(stderr, "sys_write_console: map write_console.txt\n");
  int fd_write_console = open("/tmp/write_console.txt", O_RDWR, 0600);
  void* addr_write_console = mmap(0, 1024, PROT_READ | PROT_WRITE, MAP_SHARED, fd_write_console, 0);
  //fprintf(stderr, "  mapped at %p\n", addr_write_console);
  if (addr_write_console == MAP_FAILED) {
    //fprintf(stderr, "  map failed\n");
  }
  write_console = (char*)addr_write_console;

  //fprintf(stderr, "sys_write_console: map write_console_done.txt\n");
  int fd_write_console_done = open("/tmp/write_console_done.txt", O_RDONLY, 0600);
  void* addr_write_console_done = mmap(0, 8, PROT_READ, MAP_SHARED, fd_write_console_done, 0);
  //fprintf(stderr, "  mapped at %p\n", addr_write_console_done);
  if (addr_write_console_done == MAP_FAILED) {
    //fprintf(stderr, "  map failed\n");
  }
  write_console_done = (int*)addr_write_console_done;

  //fprintf(stderr, "sys_load_image: map load_image.txt\n");
  int fd_load_image = open("/tmp/load_image.txt", O_RDWR, 0600);
  void* addr_load_image = mmap(0, 2048, PROT_READ | PROT_WRITE, MAP_SHARED, fd_load_image, 0);
  //fprintf(stderr, "  mapped at %p\n", addr_load_image);
  if (addr_load_image == MAP_FAILED) {
    //fprintf(stderr, "  map failed\n");
  }
  load_image = (char*)addr_load_image;

  //fprintf(stderr, "sys_load_image: map load_image_done.txt\n");
  int fd_load_image_done = open("/tmp/load_image_done.txt", O_RDWR, 0600);
  void* addr_load_image_done = mmap(0, 8, PROT_READ | PROT_WRITE, MAP_SHARED, fd_load_image_done, 0);
  //fprintf(stderr, "  mapped at %p\n", addr_load_image_done);
  if (addr_load_image_done == MAP_FAILED) {
    //fprintf(stderr, "  map failed\n");
  }
  load_image_done = (int*)addr_load_image_done;
  _sock =0;
  struct sockaddr_in serverAddress;
  memset(&serverAddress, '0', sizeof(serverAddress));

  has_socket = setup_socket(_sock, serverAddress);  
}

syscall_t::syscall_t(htif_t* htif)
  : htif(htif), memif(&htif->memif()), table(2048)
{
  table[17] = &syscall_t::sys_getcwd;
  table[25] = &syscall_t::sys_fcntl;
  table[34] = &syscall_t::sys_mkdirat;
  table[35] = &syscall_t::sys_unlinkat;
  table[37] = &syscall_t::sys_linkat;
  table[38] = &syscall_t::sys_renameat;
  table[46] = &syscall_t::sys_ftruncate;
  table[48] = &syscall_t::sys_faccessat;
  table[49] = &syscall_t::sys_chdir;
  table[56] = &syscall_t::sys_openat;
  table[57] = &syscall_t::sys_close;
  table[62] = &syscall_t::sys_lseek;
  table[63] = &syscall_t::sys_read;
  table[64] = &syscall_t::sys_write;
  table[67] = &syscall_t::sys_pread;
  table[68] = &syscall_t::sys_pwrite;
  table[79] = &syscall_t::sys_fstatat;
  table[80] = &syscall_t::sys_fstat;
  table[93] = &syscall_t::sys_exit;
  table[102] = &syscall_t::sys_read_console;
  table[103] = &syscall_t::sys_write_console;
  table[104] = &syscall_t::sys_read_symbol_addr;
  table[105] = &syscall_t::sys_load_image;
  table[106] = &syscall_t::sys_fprint;
  table[107] = &syscall_t::sys_get_image;
  table[108] = &syscall_t::sys_return_scores;
  table[109] = &syscall_t::sys_get_num_vcores;
  table[110] = &syscall_t::sys_fprint_truncated;
  table[111] = &syscall_t::sys_fprint_performance;
  table[112] = &syscall_t::sys_mem_dump;
  table[1039] = &syscall_t::sys_lstat;
  table[2011] = &syscall_t::sys_getmainvars;

  register_command(0, std::bind(&syscall_t::handle_syscall, this, _1), "syscall");

  int stdin_fd = dup(0), stdout_fd0 = dup(1), stdout_fd1 = dup(1);
  if (stdin_fd < 0 || stdout_fd0 < 0 || stdout_fd1 < 0)
    throw std::runtime_error("could not dup stdin/stdout");

  fds.alloc(stdin_fd); // stdin -> stdin
  fds.alloc(stdout_fd0); // stdout -> stdout
  fds.alloc(stdout_fd1); // stderr -> stdout

  console = new console_t();
}

bool console_t::setup_socket(int& sock, sockaddr_in serverAddress) {
    if ((sock = socket(AF_INET, SOCK_STREAM, 0)) < 0)
    {
        printf("\n Socket creation error \n");
        return false;
    }

    serverAddress.sin_family = AF_INET;
    serverAddress.sin_port = htons(PORT);

    // Convert IPv4 and IPv6 addresses from text to binary form
    if(inet_pton(AF_INET, "127.0.0.1", &serverAddress.sin_addr)<=0){
      printf("\nInvalid address/ Address not supported \n");
      return false;
    }
  
    // Connect to python
    if (connect(sock, (struct sockaddr *)&serverAddress, sizeof(serverAddress)) < 0) {
      printf("\n(Not able to connect to Python debugger!)\n");
      return false;
    }

    struct timeval timeout;
    timeout.tv_sec = 5;
    timeout.tv_usec = 0;
    setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, &timeout, sizeof(timeout));

    return true;
}


std::string syscall_t::do_chroot(const char* fn)
{
  if (!chroot.empty() && *fn == '/')
    return chroot + fn;
  return fn;
}

std::string syscall_t::undo_chroot(const char* fn)
{
  if (chroot.empty())
    return fn;
  if (strncmp(fn, chroot.c_str(), chroot.size()) == 0
      && (chroot.back() == '/' || fn[chroot.size()] == '/'))
    return fn + chroot.size() - (chroot.back() == '/');
  return "/";
}

void syscall_t::handle_syscall(command_t cmd)
{
  if (cmd.payload() & 1) // test pass/fail
  {
    htif->exitcode = cmd.payload();
    if (htif->exit_code())
      std::cerr << "*** FAILED *** (tohost = " << htif->exit_code() << ")" << std::endl;
    else
      std::cerr << "*** PASSED *** (tohost = " << htif->exit_code() << ")" << std::endl;
    return;
  }
  else // proxied system call
    dispatch(cmd.payload());

  cmd.respond(1);
}

reg_t syscall_t::sys_exit(reg_t code, reg_t a1, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  htif->exitcode = code << 1 | 1;
  return 0;
}

reg_t syscall_t::sys_read_console(reg_t pbuf, reg_t a1, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  // read message from read_console mmap, one byte a time, and send it back to magic mem, address given by pbuf
  uint8_t reg[8];

  if (console->read_console[0] != 0) { // check if read byte is avaiable
    fprintf(stderr, "syscall: read_console\n");
    // write 1-byte to given address in pbuf
    fprintf(stderr, "  char=0x%x(%c)\n", console->read_console[0], console->read_console[0]);
    reg[0] = console->read_console[0];
    reg[1] = 0x00;
    reg[2] = 0x00;
    reg[3] = 0x00;
    reg[4] = 0x00;
    reg[5] = 0x00;
    reg[6] = 0x00;
    reg[7] = 0x00;
    memif->write(pbuf, 8, (uint8_t*)reg);

    // notify console
    fprintf(stderr, "  notify console by asserting done signal");
    console->read_console_done[0] = 1;

    // wait for console's confirmation (clear message)
    fprintf(stderr, "  wait for console to clear message");
    while (console->read_console[0] != 0) {
      // fprintf(stderr, ".");
      usleep(1);
    }
    fprintf(stderr, "\n");

    // clear done signal
    fprintf(stderr, "  clear done signal\n");
    console->read_console_done[0] = 0;

  } else {
    //fprintf(stderr, "  empty\n");
    // write 0 back to CPU
    reg[0] = 0x00;
    reg[1] = 0x00;
    reg[2] = 0x00;
    reg[3] = 0x00;
    reg[4] = 0x00;
    reg[5] = 0x00;
    reg[6] = 0x00;
    reg[7] = 0x00;
    memif->write(pbuf, 8, (uint8_t*)reg);
  }

  return 0;
}

reg_t syscall_t::sys_write_console(reg_t buf, reg_t a1, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  // write message to write_console mmap, one byte a time, the message byte is in magic mem (magic_mem_start_addr+1)
  fprintf(stderr, "syscall: write_console\n");

  if (console->write_console_done[0] != 0) {
    fprintf(stderr, "  console done signal is not released yet, waiting");
    while (console->write_console_done[0] != 0) {
      // fprintf(stderr, ".");
      usleep(1);
    }
    fprintf(stderr, "\n");
  }

  char c = (char)buf;
  fprintf(stderr, "  char=0x%x(%c)\n", c, c);

  console->write_console[0] = c;

  // wait for console's confirmation
  fprintf(stderr, "  wait for console to assert done signal");
  while (console->write_console_done[0] == 0) {
    // fprintf(stderr, ".");
    usleep(1);
  }
  fprintf(stderr, "\n");

  // clear message
  fprintf(stderr, "  clear message\n");
  console->write_console[0] = 0;

  return 0;
}

reg_t syscall_t::sys_read_symbol_addr(reg_t a0, reg_t a1, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  //fprintf(stderr, "syscall: read_symbol_addr a0=%lx, a1=%lx\n", a0, a1);

  std::string symbol_name;
  reg_t       symbol_addr;

  int i = 0;
  char c;
  do {
    c = ((a0 >> i) & 0x00000000000000ff);
    i += 8;
    if (c == 0) {
      break;
    }
    //fprintf(stderr, "  symbol char=(%c)\n", c);
    if (c != 0) {
      symbol_name += c;
    }
  } while (1);
  //fprintf(stderr, "  looking for symbol %s\n", symbol_name.c_str());

  symbol_addr = 0;
  for (std::map<std::string, uint64_t>::iterator it = htif->program_symbols.begin(); it != htif->program_symbols.end(); ++it) {
    if (it->first.substr(0, symbol_name.length()) == symbol_name) {
      symbol_addr = it->second;
      //fprintf(stderr, "  symbol address of %s is %lx\n", symbol_name.c_str(), symbol_addr);
      break;
    }
  }

  if (symbol_addr == 0) {
      fprintf(stderr, "error: %s symbol not in ELF\n", symbol_name.c_str());
  }

  uint8_t reg[8];
  reg[0] = uint8_t((symbol_addr >> 0 ) & 0x00000000000000ff);
  reg[1] = uint8_t((symbol_addr >> 8 ) & 0x00000000000000ff);
  reg[2] = uint8_t((symbol_addr >> 16) & 0x00000000000000ff);
  reg[3] = uint8_t((symbol_addr >> 24) & 0x00000000000000ff);
  reg[4] = uint8_t((symbol_addr >> 32) & 0x00000000000000ff);
  reg[5] = uint8_t((symbol_addr >> 40) & 0x00000000000000ff);
  reg[6] = uint8_t((symbol_addr >> 48) & 0x00000000000000ff);
  reg[7] = uint8_t((symbol_addr >> 56) & 0x00000000000000ff);
  memif->write(a1, 8, (uint8_t*)reg);

  return 0;
}

reg_t syscall_t::sys_load_image(reg_t a0, reg_t a1, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  console->load_image_done[0] = 1;

  fprintf(stderr, "syscall: load_image\n");

  // if (console->load_image_done[0] != 0) {
  //   fprintf(stderr, "  console done signal is not released yet, waiting");
  //   while (console->load_image_done[0] != 0) {
  //     usleep(1);
  //   }
  //   fprintf(stderr, "\n");
  // }

  fprintf(stderr, "  search symbol image.*\n");
  uint64_t image_addr = 0;
  for (std::map<std::string, uint64_t>::iterator it = htif->program_symbols.begin(); it != htif->program_symbols.end(); ++it) {
    if (it->first.substr(0, 6) == "image.") {
      image_addr = it->second;
      fprintf(stderr, "  loading image to symbol: %s (address: %lx)\n", it->first.c_str(), image_addr);
      break;
    }
  }

  fprintf(stderr, "  wait for image to be available\n");
  int size, cnt;
  do {
    size = int(console->load_image[0]) * 1024;
    usleep(1);
  } while (size == 0);

  fprintf(stderr, "  image size=%d\n", size);
  fprintf(stderr, "  load image to L2 VLS mode via L2DA\n");
  console->load_image_done[0] = 0;
  cnt = 1;
  uint8_t reg[8];
  while (cnt < size) {
    reg[0] = console->load_image[cnt+0];
    reg[1] = console->load_image[cnt+1];
    reg[2] = console->load_image[cnt+2];
    reg[3] = console->load_image[cnt+3];
    reg[4] = console->load_image[cnt+4];
    reg[5] = console->load_image[cnt+5];
    reg[6] = console->load_image[cnt+6];
    reg[7] = console->load_image[cnt+7];
    memif->write(image_addr + cnt, 8, (uint8_t*)reg);
    cnt += 8;
  }

  fprintf(stderr, "  done\n");
  console->load_image[0] = 0;
  // do {
  //   size = int(console->load_image[0]) * 1024;
  //   usleep(1);
  //  } while (size != 0);
  return 0;
}

reg_t syscall_t::sys_fprint(reg_t a0, reg_t a1, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  fprintf(htif->vfile, "sys_fprint a0 = 0x%016lx\n", a0);
  fprintf(htif->vfile, "sys_fprint a1 = 0x%016lx\n", a1);
  fprintf(htif->vfile, "sys_fprint a2 = 0x%016lx\n", a2);
  fprintf(htif->vfile, "sys_fprint a3 = 0x%016lx\n", a3);
  fprintf(htif->vfile, "sys_fprint a4 = 0x%016lx\n", a4);
  fprintf(htif->vfile, "sys_fprint a5 = 0x%016lx\n", a5);
  fprintf(htif->vfile, "sys_fprint a6 = 0x%016lx\n", a6);

  return 0;
}

reg_t syscall_t::sys_fprint_truncated(reg_t a0, reg_t a1, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  reg_t mask = 0x000000000000000f;
  if ((a0 & mask) == 0x0){
    fprintf(htif->vfile, "sys_fprint a0 = 0x%016lx\n", a0);
    fprintf(htif->vfile, "sys_fprint a1 = 0x%016lx\n", a1);
    fprintf(htif->vfile, "sys_fprint a2 = 0x%016lx\n", a2);
    fprintf(htif->vfile, "sys_fprint a3 = 0x%016lx\n", a3);
    fprintf(htif->vfile, "sys_fprint a4 = 0x%016lx\n", a4);
  }
  if ((a0 & mask) == 0x1){
    fprintf(htif->vfile, "sys_fprint a0 = 0x%016lx\n", a0);
    fprintf(htif->vfile, "sys_fprint a1 = 0x%016lx\n", a1);
    fprintf(htif->vfile, "sys_fprint a2 = 0x%016lx\n", a2);
    fprintf(htif->vfile, "sys_fprint a3 = 0x%016lx\n", a3);
    fprintf(htif->vfile, "sys_fprint a4 = 0x%016lx\n", a4);
    fprintf(htif->vfile, "sys_fprint a5 = 0x%016lx\n", a5);
  }
  if ((a0 & mask) == 0x2){
    fprintf(htif->vfile, "sys_fprint a0 = 0x%016lx\n", a0);
    fprintf(htif->vfile, "sys_fprint a1 = 0x%016lx\n", a1);
    fprintf(htif->vfile, "sys_fprint a2 = 0x%016lx\n", a2);
    fprintf(htif->vfile, "sys_fprint a3 = 0x%016lx\n", a3);
    fprintf(htif->vfile, "sys_fprint a4 = 0x%016lx\n", a4);
  }
  if ((a0 & mask) == 0x3){
    fprintf(htif->vfile, "sys_fprint a0 = 0x%016lx\n", a0);
    fprintf(htif->vfile, "sys_fprint a1 = 0x%016lx\n", a1);
    fprintf(htif->vfile, "sys_fprint a2 = 0x%016lx\n", a2);
    fprintf(htif->vfile, "sys_fprint a3 = 0x%016lx\n", a3);
  }
  if ((a0 & mask) == 0x4){
    fprintf(htif->vfile, "sys_fprint a0 = 0x%016lx\n", a0);
    fprintf(htif->vfile, "sys_fprint a1 = 0x%016lx\n", a1);
    fprintf(htif->vfile, "sys_fprint a2 = 0x%016lx\n", a2);
    fprintf(htif->vfile, "sys_fprint a3 = 0x%016lx\n", a3);
  }
  return 0;
}


reg_t syscall_t::sys_fprint_performance(reg_t a0, reg_t a1, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  fprintf(stderr, "PERFORMANCE NUMBER - CYCLES: %016lx OPS: %016lx \n", a0, a1);
  return 0;
}


void send_command(int sock, int to_send_size, const char * upper_half_command ){
  int ret_bytes = 0;
  int digit_length = (floor(log10(abs((int)to_send_size)))+1);
  int command_size = 9 + digit_length;
  char command[command_size];
  char buf [digit_length+1];
  strcpy(command, upper_half_command);
  snprintf(buf, digit_length+1, "%d", to_send_size);
  strcat(command, buf);

  int command_str_length = (floor(log10(abs((int)command_size)))+1);
  char command_length[command_str_length+1];
  snprintf(command_length, command_str_length+1, "%d", command_size);
  if ((ret_bytes = send(sock, command_length, command_str_length, 0)) == -1) {
    fprintf(stderr, "Could not send command length ");
  }

  if ((ret_bytes = send(sock, command, strlen(command), 0)) == -1) {
    fprintf(stderr, "Could not send command");
  }
}

reg_t syscall_t::sys_get_image(reg_t image_size, reg_t image_addr, reg_t state_addr, reg_t a3, reg_t a4, reg_t a5, reg_t a6) {
  if (!console->has_socket){
    fprintf(stderr, "No socket was found. \n");
 
    uint8_t state[8];
    state[0] = 0;
    memif->write(state_addr, 1, (uint8_t*) state);
    return -1;
  }
  int sock = console->_sock;
  int ret_bytes = 0;
  int img_size = 0;
  char size [image_size];
  send_command(sock, image_size, "send_107_");
  byte* recieved_bytes;
  do {
    if ((ret_bytes = recv(sock, size, image_size, 0) == -1)) {
      fprintf(stderr, "Could not received image size\n");
      if ((errno == EAGAIN) || (errno == EWOULDBLOCK)) {
        fprintf(stderr, "Timeout\n");
        uint8_t state[8];
        state[0] = 0;
        memif->write(state_addr, 1, (uint8_t*) state);
        return -1;
      }
    }
    char* pEnd;
    img_size = strtol(size, &pEnd, 10);
  } while((floor(log10(abs(img_size)))+1)!=image_size);


  recieved_bytes = new byte[img_size];
  int bytes_recieved = 0;
  int CHUNK_SIZE = 500;
  //fprintf(stderr, "Image size %d\n", img_size);
  while (bytes_recieved < img_size) {
    if (img_size - bytes_recieved >= CHUNK_SIZE) {
      if ((ret_bytes = recv(sock, &recieved_bytes[bytes_recieved], CHUNK_SIZE, 0)) == -1) {
         fprintf(stderr,"Could not recieve image");
         if ((errno == EAGAIN) || (errno == EWOULDBLOCK)) {
           fprintf(stderr, "Timeout\n");
           uint8_t state[8];
           state[0] = 0;
           memif->write(state_addr, 1, (uint8_t*) state);
           return -1;
         }
      }
      bytes_recieved += CHUNK_SIZE;
    }
    else {
      if ((ret_bytes = recv(sock, &recieved_bytes[bytes_recieved], img_size - bytes_recieved, 0)) == -1){
         fprintf(stderr,"Could not recieve image");
         if ((errno == EAGAIN) || (errno == EWOULDBLOCK)) {
           fprintf(stderr, "Timeout\n");
           uint8_t state[8];
           state[0] = 0;
           memif->write(state_addr, 1, (uint8_t*) state);
           return -1;
         }
      }
      bytes_recieved += img_size - bytes_recieved;
    }
  }
  /*
  for (int i =0; i<img_size; i+=2){
    fprintf(stderr, "Bytes recieved %02x%02x\n", recieved_bytes[i], recieved_bytes[i+1]);
  }*/
  int cnt = 0;
  uint8_t reg[8];
  while (cnt < img_size) {
    reg[0] = recieved_bytes[cnt+0];
    reg[1] = recieved_bytes[cnt+1];
    reg[2] = recieved_bytes[cnt+2];
    reg[3] = recieved_bytes[cnt+3];
    reg[4] = recieved_bytes[cnt+4];
    reg[5] = recieved_bytes[cnt+5];
    reg[6] = recieved_bytes[cnt+6];
    reg[7] = recieved_bytes[cnt+7];
    memif->write(image_addr + cnt, 8, (uint8_t*)reg);
    cnt += 8;
  }
  //fprintf(stderr, "Sending data to chip!\n");
  free(recieved_bytes);

  uint8_t state[8];
  state[0] = 1;
  memif->write(state_addr, 1, (uint8_t*) state);
  return 1;
}
reg_t syscall_t::sys_return_scores(reg_t start_addr, reg_t elem_size, reg_t depth, reg_t mode, reg_t a4, reg_t a5, reg_t a6) {
  int sock = console->_sock;
  // fp16
  if (elem_size == 2){
    uint16_t values [depth];
    uint16_t reg[8];
    int stride = 8/elem_size;
    uint16_t cnt = 0;
    for (uint16_t i=0; i<depth; i+=stride){
      memif->read(start_addr+i*elem_size, 8, (uint16_t*)reg);
      for (int j=0; j<stride; j++) {
        if (cnt<depth) {
          values[cnt]=reg[j];
          cnt++;
        }
      }
    }
    int ret_bytes = 0;
    // For sending a single value
    if ( mode == 0){
      int to_send_size = elem_size + 1;
      char data[to_send_size];
      snprintf(data, to_send_size, "%02x", values[0]);
      send_command(sock, to_send_size, "recv_108_");
      
      if ((ret_bytes = send(sock, data, to_send_size, 0 )) == -1) {
        fprintf(stderr, "Unable to send values");
      }
    } 
    else if (mode ==1) {
      // For sending an array of values
      for (uint16_t i =0; i< depth; i++){
        int to_send_size = elem_size+3;
        char data[to_send_size];
        snprintf(data, to_send_size, "%04lx", values[i]);
        send_command(sock, to_send_size, "recv_108_");
        fprintf(stderr,"data: %s\n", data);
        if ((ret_bytes = send(sock, data, to_send_size, 0 )) == -1) {
          fprintf(stderr, "Unable to send values");
        }
      }  
    }
  }

  // Sending results of uint8, we send the results as uint64_t 
  if (elem_size == 8) {
    uint64_t values[depth];
    uint64_t reg[8];
    int stride = 8/elem_size;
    uint32_t cnt = 0;
    for (uint32_t i=0; i<depth; i+=stride){
      memif->read(start_addr+i*elem_size, 8, (uint64_t*)reg);
      for (int j=0; j<stride; j++) {
        if (cnt<depth) {
          values[cnt]=reg[j];
          cnt++;
        }
      }    
    }
    int ret_bytes = 0;
    int to_send_size = 9;
    char data[to_send_size]; 
    snprintf(data, to_send_size, "%08x", values[0]);
    send_command(sock, to_send_size, "recv_108_");
    fprintf(stderr, "%s\n",data); 
    if ((ret_bytes = send(sock, data, to_send_size, 0 )) == -1) {
      fprintf(stderr, "Unable to send values");
      // Error out
    }  
  }
  return 1;
}

reg_t syscall_t::sys_get_num_vcores(reg_t vcore_digit_length, reg_t vcore_address, reg_t vcorefp_digit_length, reg_t vcorefp_address, reg_t state_addr, reg_t a5, reg_t a6) {
  if (!console->has_socket){
    fprintf(stderr, "No socket was found. \n");
  }
  int sock = console->_sock;

  int vcores = 0;
  if (vcorefp_address != 0){ 
    int ret_bytes = 0;
    char num_vcores [vcorefp_digit_length];
    // Technically incorrect as this only works because we have <10 vcorefps
    send_command(sock, vcorefp_digit_length, "send_109_"); 

    do {
      if ((ret_bytes = recv(sock, num_vcores, vcorefp_digit_length, 0)) == -1) {
        fprintf(stderr, "Could not receive num_vcores");
        if ((errno == EAGAIN) || (errno == EWOULDBLOCK)) {
          fprintf(stderr, "Timeout\n");
          uint8_t state[8];
          state[0] = 0;
          memif->write(state_addr, 1, (uint8_t*) state);
          return -1;
        }
      }
      char* pEnd;
      vcores = strtol(num_vcores, &pEnd, 10);
    } while((floor(log10(abs(vcores)))+1)!=vcorefp_digit_length);
    fprintf(stderr, "Number of vcorefps %d\n", vcores);

    // Save to address 
    uint8_t reg[1];
    reg[0] = vcores;
    memif->write(vcorefp_address, 1, (uint8_t*) reg);
  }
  else if (vcore_address != 0){
    int ret_bytes = 0;
    char num_vcores [vcore_digit_length];
    int vcores = 0;

    send_command(sock, vcore_digit_length, "send_109_"); 

    do {
      if ((ret_bytes = recv(sock, num_vcores, vcore_digit_length, 0)) == -1) {
        fprintf(stderr, "Could not receive num_vcores");
        if ((errno == EAGAIN) || (errno == EWOULDBLOCK)) {
          fprintf(stderr, "Timeout\n");
          uint8_t state[8];
          state[0] = 0;
          memif->write(state_addr, 1, (uint8_t*) state);
          return -1;
        }
      }
      char* pEnd;
      vcores = strtol(num_vcores, &pEnd, 10);
    } while((floor(log10(abs(vcores)))+1)!=vcore_digit_length);
    fprintf(stderr, "Number of vcoreints %d\n", vcores);

    // Save to address 
     uint8_t reg[8];
    reg[0] = vcores;
    memif->write(vcore_address, 8, (uint8_t*) reg);
 
  }
  return 1;
}
static reg_t sysret_errno(sreg_t ret)
{
  return ret == -1 ? -errno : ret;
}

reg_t syscall_t::sys_read(reg_t fd, reg_t pbuf, reg_t len, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  std::vector<char> buf(len);
  ssize_t ret = read(fds.lookup(fd), &buf[0], len);
  reg_t ret_errno = sysret_errno(ret);
  if (ret > 0)
    memif->write(pbuf, ret, &buf[0]);
  return ret_errno;
}

reg_t syscall_t::sys_pread(reg_t fd, reg_t pbuf, reg_t len, reg_t off, reg_t a4, reg_t a5, reg_t a6)
{
  std::vector<char> buf(len);
  ssize_t ret = pread(fds.lookup(fd), &buf[0], len, off);
  reg_t ret_errno = sysret_errno(ret);
  if (ret > 0)
    memif->write(pbuf, ret, &buf[0]);
  return ret_errno;
}

reg_t syscall_t::sys_write(reg_t fd, reg_t pbuf, reg_t len, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  std::vector<char> buf(len);
  memif->read(pbuf, len, &buf[0]);
  reg_t ret = sysret_errno(write(fds.lookup(fd), &buf[0], len));
  return ret;
}

reg_t syscall_t::sys_pwrite(reg_t fd, reg_t pbuf, reg_t len, reg_t off, reg_t a4, reg_t a5, reg_t a6)
{
  std::vector<char> buf(len);
  memif->read(pbuf, len, &buf[0]);
  reg_t ret = sysret_errno(pwrite(fds.lookup(fd), &buf[0], len, off));
  return ret;
}

reg_t syscall_t::sys_close(reg_t fd, reg_t a1, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  if (close(fds.lookup(fd)) < 0)
    return sysret_errno(-1);
  fds.dealloc(fd);
  return 0;
}

reg_t syscall_t::sys_lseek(reg_t fd, reg_t ptr, reg_t dir, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  return sysret_errno(lseek(fds.lookup(fd), ptr, dir));
}

reg_t syscall_t::sys_fstat(reg_t fd, reg_t pbuf, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  struct stat buf;
  reg_t ret = sysret_errno(fstat(fds.lookup(fd), &buf));
  if (ret != (reg_t)-1)
  {
    riscv_stat rbuf(buf);
    memif->write(pbuf, sizeof(rbuf), &rbuf);
  }
  return ret;
}

reg_t syscall_t::sys_fcntl(reg_t fd, reg_t cmd, reg_t arg, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  return sysret_errno(fcntl(fds.lookup(fd), cmd, arg));
}

reg_t syscall_t::sys_ftruncate(reg_t fd, reg_t len, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  return sysret_errno(ftruncate(fds.lookup(fd), len));
}

reg_t syscall_t::sys_lstat(reg_t pname, reg_t len, reg_t pbuf, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  std::vector<char> name(len);
  memif->read(pname, len, &name[0]);

  struct stat buf;
  reg_t ret = sysret_errno(lstat(do_chroot(&name[0]).c_str(), &buf));
  riscv_stat rbuf(buf);
  if (ret != (reg_t)-1)
  {
    riscv_stat rbuf(buf);
    memif->write(pbuf, sizeof(rbuf), &rbuf);
  }
  return ret;
}

#define AT_SYSCALL(syscall, fd, name, ...) \
  (syscall(fds.lookup(fd), int(fd) == RISCV_AT_FDCWD ? do_chroot(name).c_str() : (name), __VA_ARGS__))

reg_t syscall_t::sys_openat(reg_t dirfd, reg_t pname, reg_t len, reg_t flags, reg_t mode, reg_t a5, reg_t a6)
{
  std::vector<char> name(len);
  memif->read(pname, len, &name[0]);
//  for (auto const& c : name)
//    fprintf(stderr, "sys_openat: name = %c\n", c);
  int fd = sysret_errno(AT_SYSCALL(openat, dirfd, &name[0], flags, mode));
  if (fd < 0)
    return sysret_errno(-1);
  return fds.alloc(fd);
}

reg_t syscall_t::sys_fstatat(reg_t dirfd, reg_t pname, reg_t len, reg_t pbuf, reg_t flags, reg_t a5, reg_t a6)
{
  std::vector<char> name(len);
  memif->read(pname, len, &name[0]);

  struct stat buf;
  reg_t ret = sysret_errno(AT_SYSCALL(fstatat, dirfd, &name[0], &buf, flags));
  if (ret != (reg_t)-1)
  {
    riscv_stat rbuf(buf);
    memif->write(pbuf, sizeof(rbuf), &rbuf);
  }
  return ret;
}

reg_t syscall_t::sys_faccessat(reg_t dirfd, reg_t pname, reg_t len, reg_t mode, reg_t a4, reg_t a5, reg_t a6)
{
  std::vector<char> name(len);
  memif->read(pname, len, &name[0]);
  return sysret_errno(AT_SYSCALL(faccessat, dirfd, &name[0], mode, 0));
}

reg_t syscall_t::sys_renameat(reg_t odirfd, reg_t popath, reg_t olen, reg_t ndirfd, reg_t pnpath, reg_t nlen, reg_t a6)
{
  std::vector<char> opath(olen), npath(nlen);
  memif->read(popath, olen, &opath[0]);
  memif->read(pnpath, nlen, &npath[0]);
  return sysret_errno(renameat(fds.lookup(odirfd), int(odirfd) == RISCV_AT_FDCWD ? do_chroot(&opath[0]).c_str() : &opath[0],
                             fds.lookup(ndirfd), int(ndirfd) == RISCV_AT_FDCWD ? do_chroot(&npath[0]).c_str() : &npath[0]));
}

reg_t syscall_t::sys_linkat(reg_t odirfd, reg_t poname, reg_t olen, reg_t ndirfd, reg_t pnname, reg_t nlen, reg_t flags)
{
  std::vector<char> oname(olen), nname(nlen);
  memif->read(poname, olen, &oname[0]);
  memif->read(pnname, nlen, &nname[0]);
  return sysret_errno(linkat(fds.lookup(odirfd), int(odirfd) == RISCV_AT_FDCWD ? do_chroot(&oname[0]).c_str() : &oname[0],
                             fds.lookup(ndirfd), int(ndirfd) == RISCV_AT_FDCWD ? do_chroot(&nname[0]).c_str() : &nname[0],
                             flags));
}

reg_t syscall_t::sys_unlinkat(reg_t dirfd, reg_t pname, reg_t len, reg_t flags, reg_t a4, reg_t a5, reg_t a6)
{
  std::vector<char> name(len);
  memif->read(pname, len, &name[0]);
  return sysret_errno(AT_SYSCALL(unlinkat, dirfd, &name[0], flags));
}

reg_t syscall_t::sys_mkdirat(reg_t dirfd, reg_t pname, reg_t len, reg_t mode, reg_t a4, reg_t a5, reg_t a6)
{
  std::vector<char> name(len);
  memif->read(pname, len, &name[0]);
  return sysret_errno(AT_SYSCALL(mkdirat, dirfd, &name[0], mode));
}

reg_t syscall_t::sys_getcwd(reg_t pbuf, reg_t size, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  std::vector<char> buf(size);
  char* ret = getcwd(&buf[0], size);
  if (ret == NULL)
    return sysret_errno(-1);
  std::string tmp = undo_chroot(&buf[0]);
  if (size <= tmp.size())
    return -ENOMEM;
  memif->write(pbuf, tmp.size() + 1, &tmp[0]);
  return tmp.size() + 1;
}

reg_t syscall_t::sys_getmainvars(reg_t pbuf, reg_t limit, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  std::vector<std::string> args = htif->target_args();
  std::vector<uint64_t> words(args.size() + 3);
  words[0] = args.size();
  words[args.size()+1] = 0; // argv[argc] = NULL
  words[args.size()+2] = 0; // envp[0] = NULL

  size_t sz = (args.size() + 3) * sizeof(words[0]);
  for (size_t i = 0; i < args.size(); i++)
  {
    words[i+1] = sz + pbuf;
    sz += args[i].length() + 1;
  }

  std::vector<char> bytes(sz);
  memcpy(&bytes[0], &words[0], sizeof(words[0]) * words.size());
  for (size_t i = 0; i < args.size(); i++)
    strcpy(&bytes[words[i+1] - pbuf], args[i].c_str());

  if (bytes.size() > limit)
    return -ENOMEM;

  memif->write(pbuf, bytes.size(), &bytes[0]);
  return 0;
}

reg_t syscall_t::sys_chdir(reg_t path, reg_t a1, reg_t a2, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  size_t size = 0;
  while (memif->read_uint8(path + size++))
    ;
  std::vector<char> buf(size);
  for (size_t offset = 0;; offset++)
  {
    buf[offset] = memif->read_uint8(path + offset);
    if (!buf[offset])
      break;
  }
  return sysret_errno(chdir(buf.data()));
}

void syscall_t::dispatch(reg_t mm)
{
  reg_t magicmem[8];
  memif->read(mm, sizeof(magicmem), magicmem);

  reg_t n = magicmem[0];
  if (n >= table.size() || !table[n])
    //throw std::runtime_error("bad syscall #" + std::to_string(n));
    return;
  // else
  //   fprintf(stderr, "syscall %ld is called!\n", n);

  magicmem[0] = (this->*table[n])(magicmem[1], magicmem[2], magicmem[3], magicmem[4], magicmem[5], magicmem[6], magicmem[7]);

  memif->write(mm, sizeof(magicmem), magicmem);
}

reg_t fds_t::alloc(int fd)
{
  reg_t i;
  for (i = 0; i < fds.size(); i++)
    if (fds[i] == -1)
      break;

  if (i == fds.size())
    fds.resize(i+1);

  fds[i] = fd;
  return i;
}

void fds_t::dealloc(reg_t fd)
{
  fds[fd] = -1;
}

int fds_t::lookup(reg_t fd)
{
  if (int(fd) == RISCV_AT_FDCWD)
    return AT_FDCWD;
  return fd >= fds.size() ? -1 : fds[fd];
}

void syscall_t::set_chroot(const char* where)
{
  char buf1[PATH_MAX], buf2[PATH_MAX];

  if (getcwd(buf1, sizeof(buf1)) == NULL
      || chdir(where) != 0
      || getcwd(buf2, sizeof(buf2)) == NULL
      || chdir(buf1) != 0)
  {
    fprintf(stderr, "could not chroot to %s\n", chroot.c_str());
    exit(-1);
  }

  chroot = buf2;
}

reg_t syscall_t::sys_mem_dump(reg_t snap_id, reg_t addr, reg_t len, reg_t a3, reg_t a4, reg_t a5, reg_t a6)
{
  //if (snap_count==0){
    uint64_t reg[8];
    FILE* fp;
    FILE* fp_1;
    char fileName[100];
    char fileName_1[100];
    fprintf(stderr, "mem_dump\n");
    sprintf(fileName, "snap%0d.hex", snap_count);
    sprintf(fileName_1, "clint%0d.sv", snap_count);

    if ((fp = fopen(fileName, "w")) == NULL) {
      fprintf(stderr, "Could not open file %s\n", fileName);
    }
    if ((fp_1 = fopen(fileName_1, "w")) == NULL) {
      fprintf(stderr, "Could not open file %s\n", fileName_1);
    }
    // CLINT
    // MSIP
    memif->read(0x800000, 8, (uint64_t *) reg);
    fprintf(fp_1, "force `MSIP = 64'h%016" PRIx64 ";\n", (*reg));
    // MTIMECMP
    memif->read(0x804000, 8, (uint64_t *) reg);
    fprintf(fp_1, "force `MTIMECMP = 64'h%016" PRIx64 ";\n", (*reg));
    // MTIME
    memif->read(0x80bff8, 8, (uint64_t *) reg);
    fprintf(fp_1, "force `MTIME = 64'h%016" PRIx64 ";\n", (*reg));
    
    // MEMORY
    addr = 0x80000000;
    len = (((1024ul*1024ul*1024ul*4ul)/2ul)/8ul); //2GB
    //len = (((1024*1024*20))/8); //10MB
    fprintf(fp, "%08x\n", addr);
    fprintf(fp, "%08x\n", 0x00000000);
    fprintf(fp, "%08x\n", 0x00000000);
    fprintf(fp, "%08x\n", 0x00000000);
    for (int i = 0; i < len; i++) {
      memif->read((addr + (i * 8)), 8, (uint64_t*)reg);
      //fprintf(stderr, "ADDR: %016x\n", addr + (i*8));
    //for (int i = 0; i < (len / 4); i++) {
    //  memif->read((addr + (i * 4)), 8, (uint64_t*)reg);
      fprintf(fp, "%08x\n", (*reg));
      fprintf(fp, "%08x\n", ((*reg) >> 32));
    }

    fclose(fp);
    fclose(fp_1);
    snap_count++;
    fprintf(stderr, "mem_dump done\n");
    return 0;
  //}
  //return 0;
}
