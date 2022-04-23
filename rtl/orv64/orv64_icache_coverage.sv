// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// the prefetech in this icache is actually a larger cache size
module orv64_icache_coverage

  chk_multi_match: assert property (@(posedge clk) disable iff (rst !== '0) ((if2ic_en_ff & ic2if.valid) |-> (cpu_resp_valid_ff | $onehot(tag_match)))) else `olog_fatal("ORV_ICACHE", $sformatf("%m: not one hot match"));
  chk_paddr_non_x: assert property (@(posedge clk) disable iff (rst !== '0) (cpu_req_valid |-> !$isunknown(cpu_req.paddr)) ) else `olog_fatal("ORV_ICACHE", $sformatf("%m: cpu_req.paddr is x"));

endmodule
