#include "debug_tick.h"

namespace {
  // Remove args that will confuse dtm, such as those that require two tokens, like VCS code coverage "-cm line+cond"
  std::vector<std::string> filter_argv_for_dtm(int argc, char** argv)
  {
    std::vector<std::string> out;
    for (int i = 1; i < argc; ++i) { // start with 1 to skip my executable name
      if (!strncmp(argv[i], "-cm", 3)) {
        ++i; // skip this one and the next one
      }
      else {
        out.push_back(argv[i]);
      }
    }
    return out;
  }
}

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
)
{
  //fprintf(stderr, "Enter Debug Tick\n");
  if (dtm == NULL) {
    dtm = new dtm_t(filter_argv_for_dtm(argc, argv));
  }

  dtm_t::resp resp_bits;
  resp_bits.resp = debug_resp_bits_resp;
  resp_bits.data = debug_resp_bits_data;

  dtm->tick
  (
    debug_req_ready,
    debug_resp_valid,
    resp_bits
  );

  *debug_resp_ready = dtm->resp_ready();
  *debug_req_valid = dtm->req_valid();
  *debug_req_bits_addr = dtm->req_bits().addr;
  *debug_req_bits_op = dtm->req_bits().op;
  *debug_req_bits_data = dtm->req_bits().data;
  *debug_tohost_addr = dtm->get_tohost_addr();
  *debug_fromhost_addr = dtm->get_fromhost_addr();

  //fprintf(stderr, "Exit Debug Tick\n");
//  return dtm->done() ? (dtm->exit_code() << 1 | 1) : 0;
  return dtm;
}

