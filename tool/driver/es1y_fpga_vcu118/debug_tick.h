#include "../../fesvr//fesvr/dtm.h"
//#include "/home/ours-demo/pygmy-es1x/tool/riscv/include/fesvr//dtm.h"

dtm_t * debug_tick
(
  unsigned char* debug_req_valid,
  unsigned char  debug_req_ready,
  int*           debug_req_bits_addr,
  int*           debug_req_bits_op,
  int*           debug_req_bits_data,
  uint64_t*      debug_tohost_addr,
  uint64_t*      debug_fromhost_addr,

  unsigned char  debug_resp_valid,
  unsigned char* debug_resp_ready,
  int            debug_resp_bits_resp,
  int            debug_resp_bits_data,
  int            argc,
  char const*    argv[],
  dtm_t*         dtm
);
