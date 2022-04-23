// See LICENSE for license details.

#ifndef __HTIF_H
#define __HTIF_H

#include "memif.h"
#include "syscall.h"
#include "device.h"
#include <string.h>
#include <vector>
#include <map>
#include<stdio.h>

#define ES1Y 0
#define ES1X 1
#define DEMO 2
#define PYGMY_E 3

class htif_proj;
#if PROJ_NUM == ES1Y
class es1y;
#elif PROJ_NUM == ES1X
class es1x;
#elif PROJ_NUM == DEMO
class demo;
#elif PROJ_NUM == PYGMY_E
class pygmy_e;
#endif

class htif_t
{
 public:
  htif_t(const std::vector<std::string>& target_args);
  virtual ~htif_t();

  virtual void start();
  virtual void stop();

  int run();
  bool done();
  int exit_code();

  void OURSBUS_WRITE(uint64_t addr, uint64_t data);
  void OURSBUS_CHECK(uint64_t addr, uint64_t refdata, const char * msg = "");
  void OURSBUS_READ(uint64_t addr, uint64_t & data);
  void OURSBUS_READ_4B(uint64_t addr, uint64_t & data);
  virtual memif_t& memif() { return mem; }
  virtual addr_t get_tohost_addr() { return tohost_addr; }
  virtual addr_t get_fromhost_addr() { return fromhost_addr; };
  virtual addr_t get_tohost() { return mem.read_uint64(tohost_addr); }
  virtual addr_t get_fromhost() { return mem.read_uint64(fromhost_addr); };
  std::map<std::string, uint64_t> symbols;
  std::map<std::string, int64_t> symbols_s;
  std::map<int64_t, std::string> addr_to_symbols;
  std::map<std::string, uint64_t> program_symbols;
  std::map<std::string, int64_t> program_symbols_s;
  std::map<int64_t, std::string> addr_to_program_symbols;
  virtual std::map<int64_t, std::string> get_addr_to_symbols() { return addr_to_symbols; };
  virtual std::map<int64_t, std::string> get_addr_to_program_symbols() { return addr_to_program_symbols; };
  virtual uint64_t get_snap_period() { return snap_period; }
  virtual uint64_t get_snap_initial() { return snap_initial; }

 protected:
  virtual void reset() = 0;

  virtual void read_chunk(addr_t taddr, size_t len, void* dst, enum rw_target target = L2) = 0;
  virtual void write_chunk(addr_t taddr, size_t len, const void* srcm, enum rw_target target = L2) = 0;
  virtual void clear_chunk(addr_t taddr, size_t len, enum rw_target target = L2);

  virtual size_t chunk_align() = 0;
  virtual size_t chunk_max_size() = 0;

  virtual void load_program();
  virtual void idle() {}

  const std::vector<std::string>& host_args() { return hargs; }

  reg_t get_entry_point() { return entry; }

 private:
  bool debug_interrupt = true;
  int count;
  htif_proj * project;
  FILE * vfile = stderr;
  addr_t tohost_addr;
  addr_t fromhost_addr;
  memif_t mem; reg_t entry;
  bool writezeros;
  std::vector<std::string> hargs;
  std::vector<std::string> targs;
  std::map<std::string, std::string> argmap;
  std::map<std::string, htif_proj*> projmap;
  std::string sig_file;
  addr_t sig_addr; // torture
  addr_t sig_len; // torture
  int exitcode;
  bool stopped;
  std::string path;
  device_list_t device_list;
  syscall_t syscall_proxy;
  bcd_t bcd;
  std::vector<device_t*> dynamic_devices;
  uint64_t snap_period;
  uint64_t snap_initial;

  const std::vector<std::string>& target_args() { return targs; }


  friend class memif_t;
  friend class syscall_t;
#if PROJ_NUM == ES1Y
  friend class es1y;
#elif PROJ_NUM == ES1X
  friend class es1x;
#elif PROJ_NUM == DEMO
  friend class demo;
#elif PROJ_NUM == PYGMY_E
  friend class pygmy_e;
#endif
};

#endif // __HTIF_H

