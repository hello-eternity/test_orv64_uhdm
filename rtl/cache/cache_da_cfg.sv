`ifndef _CACHE_DA_CFG__SV_
`define _CACHE_DA_CFG__SV_

package cache_da_cfg;
  import pygmy_cfg::*;
  import pygmy_typedef::*;

  typedef enum logic [2:0] {
    FLUSH_IDLE   = 0,
    FLUSH_ACTIVE = 1,
    FLUSH_RD_ACK = 2,
    FLUSH_WR_ACK = 3
  } flush_state_t;

  typedef enum logic [1 : 0] {
    DA_IDLE   = 0,
    DA_REQ    = 1,
    DA_RD_ACK = 2,
    DA_WR_ACK = 3
  } da_state_t;

  typedef enum logic [2 : 0] {
    L2_FLUSH_NONE = 0,
    L2_FLUSH_ADDR = 1,
    L2_FLUSH_IDX  = 2,
    L2_FLUSH_ALL  = 3
  } flush_op_t;

  typedef enum logic [OB_RAM_ID_WIDTH - 1 : 0] {
    VLDRAM    = 0,
    DIRTYRAM  = 1,
    TAGRAM    = 2,
    DATARAM   = 3,
    LRURAM    = 4,
    HPMCOUNTER= 5,
    ILLEGAL   = 6
  } ram_id_t;

endpackage
`endif
