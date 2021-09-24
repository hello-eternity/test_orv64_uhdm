# Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# export DC_HOME = $(dir $(shell which dc_shell))..
# export ORV64_SRC_PATH = $(dir $(shell pwd))

.PHONY: default, t28, clean

#tsmc 28ns synth
t28:
	rm -rf rpt
	rm -rf run
	rm -rf log 
	rm -rf output
	mkdir rpt
	mkdir log 
	mkdir run
	mkdir output
	cd run && dc_shell-t -f ../script/synth.tcl | tee -i ../log/dc_t28.log
clean:
	rm -rf rpt
	rm -rf log 
	rm -rf run
	rm -rf output

