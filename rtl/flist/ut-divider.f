+incdir+.
+incdir+$DW_LIB_PATH 
+incdir+../common 
+incdir+../orv64 
+incdir+../lib

//testbench.sv $(LIB_FILES) $(SIM_FILES) $(RTL_FILES) $(DW_FILES) ./cosim/main.so




../common/def.sv
../common/pygmy_cfg.sv
../common/pygmy_func.sv
../common/pygmy_typedef.sv
../orv64/orv64_param_pkg.sv
../orv64/orv64_typedef_pkg.sv
../orv64/orv64_func_pkg.sv
../orv64/orv64_decode_func_pkg.sv
../common/pygmy_intf_typedef-sim.sv
../lib/xpm_memory.sv
../lib/xilinx_sram-sim.sv
../lib/sd_hold_valid.sv
../common/station_vp.sv
../lib/clock/icg-sim.sv
../lib/ours_ip/ours_vld_rdy_buf.sv
../lib/ours_ip/ours_fifo.sv
../lib/ours_ip/ours_vld_rdy_rr_arb.sv
../lib/ours_ip/ours_vld_rdy_rr_arb_buf.sv
../lib/ot_ip/misc/sd_ppln_cell_rstn.v
../lib/ot_ip/misc/sd_ppln_delay_rstn.v
../lib/flop_sram.sv


$DW_LIB_PATH/DW_ram_rw_s_dff.v 
$DW_LIB_PATH/DW_div_seq.v 
$DW_LIB_PATH/DW_mult_seq.v 

$DW_LIB_PATH/DW_ifp_addsub.v   
$DW_LIB_PATH/DW_ifp_mult.v
$DW_LIB_PATH/DW_ifp_fp_conv.v
$DW_LIB_PATH/DW_fp_addsub_DG.v  
$DW_LIB_PATH/DW_fp_addsub.v     
$DW_LIB_PATH/DW_fp_add.v        
$DW_LIB_PATH/DW_fp_mac_DG.v
$DW_LIB_PATH/DW_fp_cmp_DG.v     
$DW_LIB_PATH/DW_fp_mac.v
$DW_LIB_PATH/DW_fp_cmp.v        
$DW_LIB_PATH/DW_fp_mult_DG.v
$DW_LIB_PATH/DW_fp_div_DG.v     
$DW_LIB_PATH/DW_fp_mult.v
$DW_LIB_PATH/DW_fp_div_seq.v    
$DW_LIB_PATH/DW_fp_recip_DG.v
$DW_LIB_PATH/DW_fp_div.v        
$DW_LIB_PATH/DW_fp_recip.v
$DW_LIB_PATH/DW_fp_dp2.v             
$DW_LIB_PATH/DW_fp_sqrt.v
$DW_LIB_PATH/DW_fp_dp4.v        
$DW_LIB_PATH/DW_fp_square.v    
$DW_LIB_PATH/DW_fp_sub_DG.v      
$DW_LIB_PATH/DW_fp_sub.v
$DW_LIB_PATH/DW_fp_flt2i.v      
$DW_LIB_PATH/DW_fp_sum3_DG.v
$DW_LIB_PATH/DW_fp_i2flt.v      
$DW_LIB_PATH/DW_fp_sum3.v
$DW_LIB_PATH/DW_fp_ifp_conv.v   
$DW_LIB_PATH/DW_fp_sum4.v

../orv64/orv64_div.sv 

../../ut/testbench.sv
