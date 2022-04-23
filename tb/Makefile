# Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

export DW_LIB_PATH=/opt/cad/synopsys/installs/syn/P-2019.03/dw/sim_ver

ifeq ($(JOBS),)
  JOBS := $(shell grep -c ^processor /proc/cpuinfo 2>/dev/null)
  ifeq ($(JOBS),)
    JOBS := 1
  endif
endif

.PHONY: vcs benchmarks cosim clean

seed=1

benchmarks:
	make -j$(JOBS) -C ./test_program/benchmarks
	make -j$(JOBS) -C ./test_program/isa XLEN=64
cosim:
	make -C ./cosim

vcs:
	make -j$(JOBS) -C ./cosim
	vcs -sverilog cosim/cosim.so -F ../rtl/flist/orv64-sim.f +lint=TFIPC-L -full64 -debug_access+all

verdi:
	Verdi-SX -sverilog +define+VCS cosim/cosim.so -F ../rtl/flist/orv64-sim.f +lint=TFIPC-L -top testbench


clean:
	-rm -rf ./*.vpd
	-rm -r ./obj_dir
	-rm -rf ./csrc ./simv.daidir ./simv
	-rm -rf ./logs
	-make -C ./test_program/benchmarks clean
	-make -C ./test_program/isa clean
	-make -C ./cosim clean
