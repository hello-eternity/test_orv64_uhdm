SHELL=/bin/bash

default: tags edit-pipe

lint:
	verilator --lint-only -sv --assert --bbox-unsup --error-limit 10 +1364-1995ext+sv +1364-2001ext+sv +1364-2005ext+sv +1800-2005ext+sv +1800-2009ext+sv +1800-2012ext+sv +define+VERILATOR_LINT -f orv64.verilator.f ../../tb/smoke/tb.sv --top-module tb

.PHONY: default lint auto delete

edit-pipe:
	vim orv64.sv orv64_fetch.sv orv64_decode.sv orv64_execute.sv orv64_mem_access.sv orv64_csr.sv orv64_typedef_pkg.sv orv64_icache.sv orv64_storebuf.sv

edit-else:
	vim orv64_regfile.sv orv64_param_pkg.sv orv64_param_pkg.svpp orv64_param_pkg_vpp.vh

edit-fp:
	vim orv64_fp_add.sv orv64_fp_cmp.sv orv64_fp_mac.sv orv64_fp_div.sv orv64_fp_sqrt.sv orv64_fp_misc.sv

vpp:
	-/work/tools/vpp/vpp.linux orv64_param_pkg.svpp > orv64_param_pkg.sv
	sed -i 's|@@|::|g' orv64_param_pkg.sv

tags:
	ctags -n --fields=+i --extras=+q *.sv

.PHONY: default lint auto delete vpp

################################################################

gen_fsm=../../script/rtl/fizzim/fizzim.pl -sunburst -language SystemVerilog -simcode -nextstatevar next_state -statenamevar state_name

edit-fsm:
	java -jar ../../script/rtl/fizzim/fizzim_v14.02.26.jar &

orv64_fsm_%.sv: orv64_fsm_%.fzm
	$(gen_fsm) $(gen_fsm_option) < $<

.PHONY: edit_fsm

################################################################

xlsx=../../doc/design/orv64-design-doc.xlsx

# orv64_opcode_enum.sv: $(xlsx)
# 	../../script/rtl/parse_design_doc.py $< $@
#
# orv64_imm_type_enum.sv: $(xlsx)
# 	../../script/rtl/parse_design_doc.py $< $@

dec: orv64_decode_func_pkg.sv

.PHONY: dec

orv64_decode_func_pkg.sv: $(xlsx) ./parse_design_doc.py
	./parse_design_doc.py $< $@

################################################################

gen: vpp
	./auto_gen.py

.PHONY: gen
