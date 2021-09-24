
create_proj:
	vivado -mode batch -source script/vcu118/create_proj.tcl

run_synth: 
	vivado -mode batch -source run_synth.tcl

run_impl:
	vivado -mode batch -source run_impl.tcl

copy_bitfile:
	rm -rf $(PROJ_ROOT)/hardware/soc/bitfile/report
	mkdir -p $(PROJ_ROOT)/hardware/soc/bitfile/report
	cp -R fpga_es1y_vcu118.runs/impl_1/*.rpt $(PROJ_ROOT)/hardware/soc/bitfile/report/
	cp fpga_es1y_vcu118.runs/impl_1/pygmy_es1y_fpga_vcu118.bit fpga_es1y_vcu118.runs/impl_1/pygmy_es1y_fpga_vcu118.ltx $(PROJ_ROOT)/hardware/soc/bitfile 

generate_bitfile: create_proj run_synth run_impl copy_bitfile

clean:
	rm -rf fpga_es1y_vcu118.*
	rm -rf vivado*

.PHONY:
	clean

