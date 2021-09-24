# Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

ifeq ($(JOBS),)
  JOBS := $(shell grep -c ^processor /proc/cpuinfo 2>/dev/null)
  ifeq ($(JOBS),)
    JOBS := 1
  endif
endif

.PHONY: default clean



default:
	vcs -sverilog -F ../rtl/flist/ut-divider.f +lint=TFIPC-L -full64 -debug_access+all

run:
	./simv +dump

clean:
	-rm -rf csrc DVEfiles simv simv.daidir ucli.key vcdplus.vpd
