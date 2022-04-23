// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __ICG_SV__
`define __ICG_SV__

module icg
#(
  parameter int BACKEND_DOMAIN = 0,
  parameter DRIVEN=4
) (
  output logic clkg,
  input  logic en,
  input  logic tst_en,
  input  logic clk
);
    assign clkg = clk;
endmodule

`endif
