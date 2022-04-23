#include "dtm.h"
#include "memif.h"
#include "debug_defines.h"
#include "encoding.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <pthread.h>

#define RV_X(x, s, n) \
  (((x) >> (s)) & ((1 << (n)) - 1))
#define ENCODE_ITYPE_IMM(x) \
  (RV_X(x, 0, 12) << 20)
#define ENCODE_STYPE_IMM(x) \
  ((RV_X(x, 0, 5) << 7) | (RV_X(x, 5, 7) << 25))
#define ENCODE_SBTYPE_IMM(x) \
  ((RV_X(x, 1, 4) << 8) | (RV_X(x, 5, 6) << 25) | (RV_X(x, 11, 1) << 7) | (RV_X(x, 12, 1) << 31))
#define ENCODE_UTYPE_IMM(x) \
  (RV_X(x, 12, 20) << 12)
#define ENCODE_UJTYPE_IMM(x) \
  ((RV_X(x, 1, 10) << 21) | (RV_X(x, 11, 1) << 20) | (RV_X(x, 12, 8) << 12) | (RV_X(x, 20, 1) << 31))

#define LOAD(xlen, dst, base, imm) \
  (((xlen) == 64 ? 0x00003003 : 0x00002003) \
   | ((dst) << 7) | ((base) << 15) | (uint32_t)ENCODE_ITYPE_IMM(imm))
#define STORE(xlen, src, base, imm) \
  (((xlen) == 64 ? 0x00003023 : 0x00002023) \
   | ((src) << 20) | ((base) << 15) | (uint32_t)ENCODE_STYPE_IMM(imm))
#define JUMP(there, here) (0x6f | (uint32_t)ENCODE_UJTYPE_IMM((there) - (here)))
#define BNE(r1, r2, there, here) (0x1063 | ((r1) << 15) | ((r2) << 20) | (uint32_t)ENCODE_SBTYPE_IMM((there) - (here)))
#define ADDI(dst, src, imm) (0x13 | ((dst) << 7) | ((src) << 15) | (uint32_t)ENCODE_ITYPE_IMM(imm))
#define SRL(dst, src, sh) (0x5033 | ((dst) << 7) | ((src) << 15) | ((sh) << 20))
#define FENCE_I 0x100f
#define EBREAK  0x00100073
#define X0 0
#define S0 8
#define S1 9

#define AC_AR_REGNO(x) ((0x1000 | x) << AC_ACCESS_REGISTER_REGNO_OFFSET)
#define AC_AR_SIZE(x)  (((x == 128)? 4 : (x == 64 ? 3 : 2)) << AC_ACCESS_REGISTER_SIZE_OFFSET)

#define WRITE 1
#define SET 2
#define CLEAR 3
#define CSRRx(type, dst, csr, src) (0x73 | ((type) << 12) | ((dst) << 7) | ((src) << 15) | (uint32_t)((csr) << 20))

#define get_field(reg, mask) (((reg) & (mask)) / ((mask) & ~((mask) << 1)))
#define set_field(reg, mask, val) (((reg) & ~(mask)) | (((val) * ((mask) & ~((mask) << 1))) & (mask)))

#define RUN_AC_OR_DIE(a, b, c, d, e) { \
    uint32_t cmderr = run_abstract_command(a, b, c, d, e);      \
    if (cmderr) {                                               \
      die(cmderr);                                              \
    }                                                           \
  }

uint32_t dtm_t::do_command(dtm_t::req r)
{
  req_buf = r;
  target->switch_to();
  assert(resp_buf.resp == 0);
  return resp_buf.data;
}

uint32_t dtm_t::read(uint32_t addr, uint32_t raddr)
{
  return do_command((req){addr, 1, raddr});
}

uint32_t dtm_t::write(uint32_t addr, uint32_t data)
{
  //fprintf(stderr, "addr = %x, data = %x\n", addr, data);
  return do_command((req){addr, 2, data});
}

void dtm_t::nop()
{
  do_command((req){0, 0, 0});
  // TODO: handle debug console request here
}

void dtm_t::select_hart(int hartsel) {
}

int dtm_t::enumerate_harts() {
  int hartsel = 0;
  return hartsel;
}

void dtm_t::halt(int hartsel)
{
}

void dtm_t::resume(int hartsel)
{
}

uint64_t dtm_t::save_reg(unsigned regno)
{
  uint64_t result = 0;
  return result;
}

void dtm_t::restore_reg(unsigned regno, uint64_t val)
{
}

uint32_t dtm_t::run_abstract_command(uint32_t command,
                                     const uint32_t program[], size_t program_n,
                                     uint32_t data[], size_t data_n)
{ 
  return 0;
}

size_t dtm_t::chunk_align()
{
  return xlen / 8;
}

void dtm_t::read_chunk(uint64_t taddr, size_t len, void* dst, enum rw_target target/*Default Value*/)
{
//  uint32_t prog[ram_words];
  uint32_t data[data_words];

//  uint8_t * curr = (uint8_t*) dst;
  uint32_t result = 0;

  uint32_t addr;

  for (size_t i = 0; i < (len / 4); i++){
    data[0] = (uint32_t) (taddr + i * 4);
    if (xlen > 32) {
      data[1] = (uint32_t) ((taddr + i * 4) >> 32);
    }
    addr = (target == L2) ? DMI_L2_ADDR_LO : (target == DDR) ? DMI_DDR_ADDR_LO : (target == DMA_BURST) ? DMI_DMA_BURST_ADDR_LO : DMI_DMA_ADDR_LO;
    read(addr, data[0]);// TODO
    addr = (target == L2) ? DMI_L2_ADDR_HI : (target == DDR) ? DMI_DDR_ADDR_HI : (target == DMA_BURST) ? DMI_DMA_BURST_ADDR_HI : DMI_DMA_ADDR_HI;
    result = read(addr, data[1]);// TODO

    *((uint8_t *)dst + i * 4 + 3) = (result >> 24) & 0xff;
    *((uint8_t *)dst + i * 4 + 2) = (result >> 16) & 0xff;
    *((uint8_t *)dst + i * 4 + 1) = (result >>  8) & 0xff;
    *((uint8_t *)dst + i * 4 + 0) = (result >>  0) & 0xff;
  }

  //fprintf(stderr, "\nFESVR::read taddr = %llx, len = %d, result = %x\n", taddr, len, result);
}

void dtm_t::write_chunk(uint64_t taddr, size_t len, const void* src, enum rw_target target/*Default Value*/)
{  
//  uint32_t prog[ram_words];
  uint32_t data[data_words];

  //fprintf(stderr, "\ntaddr = %lx, len = %0ld\n", taddr, len);
  const uint8_t * curr = (const uint8_t*) src;
  uint32_t addr;
  enum rw_target _target; // used to replace dma target to burst target

  data[0] = (uint32_t) taddr;
  if (xlen > 32) {
    data[1] = (uint32_t) (taddr >> 32);
  }
  addr = (target == L2) ? DMI_L2_ADDR_LO : (target == DDR) ? DMI_DDR_ADDR_LO : (target == DMA_BURST) ? DMI_DMA_BURST_ADDR_LO : DMI_DMA_ADDR_LO;
  write(addr, data[0]);
  addr = (target == L2) ? DMI_L2_ADDR_HI : (target == DDR) ? DMI_DDR_ADDR_HI : (target == DMA_BURST) ? DMI_DMA_BURST_ADDR_HI : DMI_DMA_ADDR_HI;
  write(addr, data[1]);
  for (size_t i = 0; i < (len * 8 / xlen); i++){
    memcpy(data, curr, xlen/8);
    curr += xlen/8;
    if (((i + 1) < (len * 8 / xlen)) && (target == DMA)) {
      _target = DMA_BURST;
    } else {
      _target = target;
    }
    if (xlen == 64) {
      addr = (_target == L2) ? DMI_L2_DATA_HI : (_target == DDR) ? DMI_DDR_DATA_HI : (_target == DMA_BURST) ? DMI_DMA_BURST_DATA_HI : DMI_DMA_DATA_HI;
      write(addr, data[1]);
    }
    addr = (_target == L2) ? DMI_L2_DATA_LO : (_target == DDR) ? DMI_DDR_DATA_LO : (_target == DMA_BURST) ? DMI_DMA_BURST_DATA_LO : DMI_DMA_DATA_LO;
    write(addr, data[0]); //Triggers a command w/ autoexec.
    //fprintf(stderr, "\nFESVR::write data[0] = %x, data[1] = %x\n", data[0], data[1]);
  }
}

void dtm_t::die(uint32_t cmderr)
{
  const char * codes[] = {
    "OK",
    "BUSY",
    "NOT_SUPPORTED",
    "EXCEPTION",
    "HALT/RESUME"
  };
  const char * msg;
  if (cmderr < (sizeof(codes) / sizeof(*codes))){
    msg = codes[cmderr];
  } else {
    msg = "OTHER";
  }
  //throw std::runtime_error("Debug Abstract Command Error #" + std::to_string(cmderr) + "(" +  msg + ")");
  printf("ERROR: %s:%d, Debug Abstract Command Error #%d (%s)", __FILE__, __LINE__, cmderr, msg);
  printf("ERROR: %s:%d, Should die, but allowing simulation to continue and fail.", __FILE__, __LINE__);
  write(DMI_ABSTRACTCS, DMI_ABSTRACTCS_CMDERR);

}

void dtm_t::clear_chunk(uint64_t taddr, size_t len, enum rw_target target/* = DONT_TOUCH*/)
{
//  uint32_t prog[ram_words];
//  uint32_t data[data_words];
//  
//  uint64_t s0 = save_reg(S0);
//  uint64_t s1 = save_reg(S1);
//
//  uint32_t command;

}

uint64_t dtm_t::write_csr(unsigned which, uint64_t data)
{
  return modify_csr(which, data, WRITE);
}

uint64_t dtm_t::set_csr(unsigned which, uint64_t data)
{
  return modify_csr(which, data, SET);
}

uint64_t dtm_t::clear_csr(unsigned which, uint64_t data)
{
  return modify_csr(which, data, CLEAR);
}

uint64_t dtm_t::read_csr(unsigned which)
{
  return set_csr(which, 0);
}

uint64_t dtm_t::modify_csr(unsigned which, uint64_t data, uint32_t type)
{
  return 0;
}

size_t dtm_t::chunk_max_size()
{
  // Arbitrary choice. 4k Page size seems reasonable.
  return 2048;
}

uint32_t dtm_t::get_xlen()
{
  return 64;
}

void dtm_t::fence_i()
{
}

void host_thread_main(void* arg)
{
  ((dtm_t*)arg)->producer_thread();
}

void dtm_t::reset()
{
} 

void dtm_t::idle()
{
  for (int idle_cycles = 0; idle_cycles < max_idle_cycles; idle_cycles++)
    nop();
}

void dtm_t::producer_thread()
{
  htif_t::run();

  while (true)
    nop();
}

void dtm_t::start_host_thread()
{
  req_wait = false;
  resp_wait = false;

  target = context_t::current();
  host.init(host_thread_main, this);
  host.switch_to();
}

dtm_t::dtm_t(const std::vector<std::string>& args)
  : htif_t(args)
{
  start_host_thread();
}

dtm_t::~dtm_t()
{
}

void dtm_t::tick(
  bool      req_ready,
  bool      resp_valid,
  resp      resp_bits)
{
  if (!resp_wait) {
    if (!req_wait) {
      req_wait = true;
    } else if (req_ready) {
      req_wait = false;
      resp_wait = true;
    }
  }

  if (resp_valid) {
    assert(resp_wait);
    resp_wait = false;

    resp_buf = resp_bits;
    host.switch_to();
  }
}

void dtm_t::return_resp(resp resp_bits){
  resp_buf = resp_bits;
  host.switch_to();
}
