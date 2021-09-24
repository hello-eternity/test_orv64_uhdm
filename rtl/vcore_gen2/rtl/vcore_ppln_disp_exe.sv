module vcore_ppln_disp_exe
import vcore_cfg::*;
import vcore_pkg::*;
import pygmy_typedef::*;
(
  input                     clk,
  input                     rst_n,
  input                     valid_in,       
  output                    ready_out,    
  input  vcore_i2_i3_ppln_t data_in,       
  output                    valid_out,    
  input                     ready_in,      
  output vcore_i2_i3_ppln_t data_out     
);

wire                    ppln_upd_en;
wire                    ppln_vsrc0_data_en;
wire                    ppln_vsrc1_data_en;
wire                    ppln_vls_comm_ctrl_info_en;
wire                    ppln_ent_vld_d;
wire                    ppln_ent_vld_q;

assign  ready_out                   = ~ppln_ent_vld_q | ready_in;
assign  ppln_ent_vld_d              = ~ppln_ent_vld_q & valid_in | ppln_ent_vld_q & (valid_in | ~ready_in);
assign  ppln_upd_en                 = valid_in & ready_out;
assign  ppln_vsrc0_data_en          = ppln_upd_en & data_in.vsrc0_vld;
assign  ppln_vsrc1_data_en          = ppln_upd_en & data_in.vsrc1_vld;
assign  ppln_vls_comm_ctrl_info_en  = ppln_upd_en & (data_in.opcode == VFLD | data_in.opcode == VFSLD | data_in.opcode == VFST);

std_dffr    #( 1 ) FF_PPLN_ENT_VLD(.clk( clk ),.rst_n( rst_n ),.d( ppln_ent_vld_d ),.q( ppln_ent_vld_q ));
std_dffe    #( VCORE_OPCODE_W       ) FF_PPLN_OPCODE            (.clk( clk ),.en( ppln_upd_en           ),.d( data_in.opcode          ),.q( data_out.opcode           ));
std_dffe    #( VCORE_CSR_VLEN_W     ) FF_PPLN_VLEN              (.clk( clk ),.en( ppln_upd_en           ),.d( data_in.vlen            ),.q( data_out.vlen             ));
std_dffre   #( 3                    ) FF_PPLN_ROUNDING          (.clk( clk ),.rst_n( rst_n ),.en( ppln_upd_en           ),.d( data_in.rounding        ),.q( data_out.rounding         ));
std_dffe    #( 5                    ) FF_PPLN_VDST0_ADDR        (.clk( clk ),.en( ppln_upd_en           ),.d( data_in.vdst0_addr      ),.q( data_out.vdst0_addr       ));
std_dffe    #( VCORE_VRF_ID_W       ) FF_PPLN_VDST1_ID          (.clk( clk ),.en( ppln_upd_en           ),.d( data_in.vdst1_id        ),.q( data_out.vdst1_id         ));
std_dffe    #( 1                    ) FF_PPLN_VSRC0_VLD         (.clk( clk ),.en( ppln_upd_en           ),.d( data_in.vsrc0_vld       ),.q( data_out.vsrc0_vld        ));
std_dffe    #( 1                    ) FF_PPLN_VSRC1_VLD         (.clk( clk ),.en( ppln_upd_en           ),.d( data_in.vsrc1_vld       ),.q( data_out.vsrc1_vld        ));
std_dffe    #( VCORE_VDP_W          ) FF_PPLN_VSRC0_DATA        (.clk( clk ),.en( ppln_vsrc0_data_en    ),.d( data_in.vsrc0_data      ),.q( data_out.vsrc0_data       ));
std_dffe    #( VCORE_VDP_W          ) FF_PPLN_VSRC1_DATA        (.clk( clk ),.en( ppln_vsrc1_data_en    ),.d( data_in.vsrc1_data      ),.q( data_out.vsrc1_data       ));
std_dffe    #( $bits(vcore_vls_comm_ctrl_info_t) ) FF_PPLN_VLS_COMM_INFO(.clk( clk ),.en( ppln_vls_comm_ctrl_info_en),.d( data_in.vls_comm_ctrl_info ),.q( data_out.vls_comm_ctrl_info ));


assign  valid_out   = ppln_ent_vld_q;
          
endmodule
