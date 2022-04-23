// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`define olog_fatal(x, y) begin $display("fatal: %s %s", x, y); $stop; end
`define olog_error(x, y) $display("error: %s %s", x, y)
`define olog_warning(x, y) $display("warning: %s %s", x, y)
`define olog_info(x, y)  $display("info: %s %s", x, y)
`define ORV64_SUPPORT_MULDIV
`define DW_SUPPRESS_WARN
`define ORV64_SUPPORT_FP
`define ORV64_SUPPORT_FP_DOUBLE

