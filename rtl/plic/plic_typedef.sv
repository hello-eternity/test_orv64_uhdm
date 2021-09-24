// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
`ifndef __PLIC_TYPEDEF__SV__
`define __PLIC_TYPEDEF__SV__

package plic_typedef;

  typedef logic       plic_intr_en_t;
  typedef logic       plic_dbg_en_t;
  typedef logic [2:0] plic_intr_core_id_t;
  typedef logic [5:0] plic_intr_src_t;

endpackage
`endif
