// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


`define __OURSRING_TYPEDEF__SV__

package oursring_typedef;
  typedef enum logic [1:0] { ST_RD, ST_WR, ST_RSP, ST_ERR } st_type_e;
  typedef enum logic [1:0] { ST_IDLE, ST_DR_OUT, ST_INDIRECT_OUT, ST_INDIRECT_IN } st_state_e;
  typedef struct packed {
    st_type_e   typ;
    logic [39:0]  addr;
    logic [63:0]  data;
  } sd_info_t;
  
endpackage

