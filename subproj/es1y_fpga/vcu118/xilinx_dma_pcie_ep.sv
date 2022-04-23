//-----------------------------------------------------------------------------
//
// (c) Copyright 2012-2012 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//-----------------------------------------------------------------------------
//
// Project    : The Xilinx PCI Express DMA 
// File       : xilinx_dma_pcie_ep.sv
// Version    : 4.1
//-----------------------------------------------------------------------------
`timescale 1ps / 1ps

module xilinx_dma_pcie_ep
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  #(
   parameter PL_LINK_CAP_MAX_LINK_WIDTH          = 16,            // 1- X1; 2 - X2; 4 - X4; 8 - X8
   parameter PL_SIM_FAST_LINK_TRAINING           = "FALSE",      // Simulation Speedup
   parameter PL_LINK_CAP_MAX_LINK_SPEED          = 4,             // 1- GEN1; 2 - GEN2; 4 - GEN3
   parameter C_DATA_WIDTH                        = 512 ,
   parameter EXT_PIPE_SIM                        = "FALSE",  // This Parameter has effect on selecting Enable External PIPE Interface in GUI.
   parameter C_ROOT_PORT                         = "FALSE",      // PCIe block is in root port mode
   parameter C_DEVICE_NUMBER                     = 0,            // Device number for Root Port configurations only
   parameter AXIS_CCIX_RX_TDATA_WIDTH     = 256, 
   parameter AXIS_CCIX_TX_TDATA_WIDTH     = 256,
   parameter AXIS_CCIX_RX_TUSER_WIDTH     = 46,
   parameter AXIS_CCIX_TX_TUSER_WIDTH     = 46
   )
   (
    output [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0] pci_exp_txp,
    output [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0] pci_exp_txn,
    input [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0]  pci_exp_rxp,
    input [(PL_LINK_CAP_MAX_LINK_WIDTH - 1) : 0]  pci_exp_rxn,

//VU9P_TUL_EX_String= FALSE



    output 					 led_0,
    output 					 led_1,
    output 					 led_2,
    output 					 led_3,
    input 					 sys_clk_p,
    input 					 sys_clk_n,
    input 					 sys_rst_n,

    // OURSRING
    output logic                                 or_req_awvalid,
    output oursring_req_if_aw_t                  or_req_aw,
    input  logic                                 or_req_awready,
    // w
    output logic                                 or_req_wvalid,
    output oursring_req_if_w_t                   or_req_w,
    input  logic                                 or_req_wready,
    // b
    input  logic                                 or_rsp_bvalid,
    input  oursring_resp_if_b_t                  or_rsp_b,
    output logic                                 or_rsp_bready,
    // ar
    output logic                                 or_req_arvalid,
    output oursring_req_if_ar_t                  or_req_ar,
    input  logic                                 or_req_arready,
    // r
    input  logic                                 or_rsp_rvalid,
    input  oursring_resp_if_r_t                  or_rsp_r,
    output logic                                 or_rsp_rready,

    // Output
    output logic                                 rst_out,
   // Input 
   input logic                                  or_clk
 );

   //-----------------------------------------------------------------------------------------------------------------------

   
   // Local Parameters derived from user selection
   localparam integer 				   USER_CLK_FREQ         = ((PL_LINK_CAP_MAX_LINK_SPEED == 3'h4) ? 5 : 4);
   localparam TCQ = 1;
   localparam C_S_AXI_ID_WIDTH = 4; 
   localparam C_M_AXI_ID_WIDTH = 4; 
   localparam C_S_AXI_DATA_WIDTH = C_DATA_WIDTH;
   localparam C_M_AXI_DATA_WIDTH = C_DATA_WIDTH;
   localparam C_S_AXI_ADDR_WIDTH = 64;
   localparam C_M_AXI_ADDR_WIDTH = 64;
   localparam C_NUM_USR_IRQ	 = 1;
   
   wire 					   user_lnk_up;
   
   //----------------------------------------------------------------------------------------------------------------//
   //  AXI Interface                                                                                                 //
   //----------------------------------------------------------------------------------------------------------------//
   
   wire 					   user_clk;
   wire 					   user_resetn;
   
  // Wires for Avery HOT/WARM and COLD RESET
   wire 					   avy_sys_rst_n_c;
   wire 					   avy_cfg_hot_reset_out;
   reg 						   avy_sys_rst_n_g;
   reg 						   avy_cfg_hot_reset_out_g;
   assign avy_sys_rst_n_c = avy_sys_rst_n_g;
   assign avy_cfg_hot_reset_out = avy_cfg_hot_reset_out_g;
   initial begin 
      avy_sys_rst_n_g = 1;
      avy_cfg_hot_reset_out_g =0;
   end
   


  //----------------------------------------------------------------------------------------------------------------//
  //    System(SYS) Interface                                                                                       //
  //----------------------------------------------------------------------------------------------------------------//

    wire                                    sys_clk;
    wire                                    sys_clk_gt;
    wire                                    sys_rst_n_c;

  // User Clock LED Heartbeat
     reg [25:0] 			     user_clk_heartbeat;
     reg [((2*C_NUM_USR_IRQ)-1):0]		usr_irq_function_number=0;
     reg [C_NUM_USR_IRQ-1:0] 		     usr_irq_req = 0;
     wire [C_NUM_USR_IRQ-1:0] 		     usr_irq_ack;

      //-- AXI Master Write Address Channel
     wire [C_M_AXI_ADDR_WIDTH-1:0] m_axi_awaddr;
     wire [C_M_AXI_ID_WIDTH-1:0] m_axi_awid;
     wire [2:0] 		 m_axi_awprot;
     wire [1:0] 		 m_axi_awburst;
     wire [2:0] 		 m_axi_awsize;
     wire [3:0] 		 m_axi_awcache;
     wire [7:0] 		 m_axi_awlen;
     wire 			 m_axi_awlock;
     wire 			 m_axi_awvalid;
     wire 			 m_axi_awready;

     //-- AXI Master Write Data Channel
     wire [C_M_AXI_DATA_WIDTH-1:0]     m_axi_wdata;
     wire [(C_M_AXI_DATA_WIDTH/8)-1:0] m_axi_wstrb;
     wire 			       m_axi_wlast;
     wire 			       m_axi_wvalid;
     wire 			       m_axi_wready;
     //-- AXI Master Write Response Channel
     wire 			       m_axi_bvalid;
     wire 			       m_axi_bready;
     wire [C_M_AXI_ID_WIDTH-1 : 0]     m_axi_bid ;
     wire [1:0]                        m_axi_bresp ;

     //-- AXI Master Read Address Channel
     wire [C_M_AXI_ID_WIDTH-1 : 0]     m_axi_arid;
     wire [C_M_AXI_ADDR_WIDTH-1:0]     m_axi_araddr;
     wire [7:0]                        m_axi_arlen;
     wire [2:0]                        m_axi_arsize;
     wire [1:0]                        m_axi_arburst;
     wire [2:0] 		       m_axi_arprot;
     wire 			       m_axi_arvalid;
     wire 			       m_axi_arready;
     wire 			       m_axi_arlock;
     wire [3:0] 		       m_axi_arcache;

     //-- AXI Master Read Data Channel
     wire [C_M_AXI_ID_WIDTH-1 : 0]   m_axi_rid;
     wire [C_M_AXI_DATA_WIDTH-1:0]   m_axi_rdata;
     wire [1:0] 		     m_axi_rresp;
     wire 			     m_axi_rvalid;
     wire 			     m_axi_rready;

/*
// declare wires for AXI bypass
     reg 			                m_axib_wready;
     reg 			                m_axib_wvalid;
     reg [C_M_AXI_DATA_WIDTH-1:0]   m_axib_wdata;
     reg			                m_axib_rready;
     reg 			                m_axib_rvalid;
     reg [C_M_AXI_DATA_WIDTH-1:0]   m_axib_rdata;
     reg [C_M_AXI_ADDR_WIDTH-1:0]   m_axib_awaddr;
     reg [C_M_AXI_ADDR_WIDTH-1:0]   m_axib_araddr;
*/



    wire [2:0]    msi_vector_width;
    wire          msi_enable;
    wire [3:0]                  leds;

  wire [5:0]                          cfg_ltssm_state;

  // Ref clock buffer
  IBUFDS_GTE4 # (.REFCLK_HROW_CK_SEL(2'b00)) refclk_ibuf (.O(sys_clk_gt), .ODIV2(sys_clk), .I(sys_clk_p), .CEB(1'b0), .IB(sys_clk_n));
  // Reset buffer
  IBUF   sys_reset_n_ibuf (.O(sys_rst_n_c), .I(sys_rst_n));
  // LED 0 pysically resides in the reconfiguable area for Tandem with 
  // Field Updates designs so the OBUF must included in the app hierarchy.
  assign led_0 = leds[0];
  // LEDs 1-3 physically reside in the stage1 region for Tandem with Field 
  // Updates designs so the OBUF must be instantiated at the top-level and
  // added to the stage1 region
  OBUF led_1_obuf (.O(led_1), .I(leds[1]));
  OBUF led_2_obuf (.O(led_2), .I(leds[2]));
  OBUF led_3_obuf (.O(led_3), .I(leds[3]));

`ifndef TB_USE_DMA_STATION_LOCAL_IF
  // Core Top Level Wrapper
  xdma_0 xdma_0_i 
     (
      //---------------------------------------------------------------------------------------//
      //  PCI Express (pci_exp) Interface                                                      //
      //---------------------------------------------------------------------------------------//
      .sys_rst_n       ( sys_rst_n_c ),
      .sys_clk         ( sys_clk ),
      .sys_clk_gt      ( sys_clk_gt),
      
      // Tx
      .pci_exp_txn     ( pci_exp_txn ),
      .pci_exp_txp     ( pci_exp_txp ),
      
      // Rx
      .pci_exp_rxn     ( pci_exp_rxn ),
      .pci_exp_rxp     ( pci_exp_rxp ),


       // AXI MM Interface
      .m_axi_awid      (m_axi_awid  ),
      .m_axi_awaddr    (m_axi_awaddr),
      .m_axi_awlen     (m_axi_awlen),
      .m_axi_awsize    (m_axi_awsize),
      .m_axi_awburst   (m_axi_awburst),
      .m_axi_awprot    (m_axi_awprot),
      .m_axi_awvalid   (m_axi_awvalid),
      .m_axi_awready   (m_axi_awready),
      .m_axi_awlock    (m_axi_awlock),
      .m_axi_awcache   (m_axi_awcache),
      .m_axi_wdata     (m_axi_wdata),
      .m_axi_wstrb     (m_axi_wstrb),
      .m_axi_wlast     (m_axi_wlast),
      .m_axi_wvalid    (m_axi_wvalid),
      .m_axi_wready    (m_axi_wready),
      .m_axi_bid       (m_axi_bid),
      .m_axi_bresp     (m_axi_bresp),
      .m_axi_bvalid    (m_axi_bvalid),
      .m_axi_bready    (m_axi_bready),
      .m_axi_arid      (m_axi_arid),
      .m_axi_araddr    (m_axi_araddr),
      .m_axi_arlen     (m_axi_arlen),
      .m_axi_arsize    (m_axi_arsize),
      .m_axi_arburst   (m_axi_arburst),
      .m_axi_arprot    (m_axi_arprot),
      .m_axi_arvalid   (m_axi_arvalid),
      .m_axi_arready   (m_axi_arready),
      .m_axi_arlock    (m_axi_arlock),
      .m_axi_arcache   (m_axi_arcache),
      .m_axi_rid       (m_axi_rid),
      .m_axi_rdata     (m_axi_rdata),
      .m_axi_rresp     (m_axi_rresp),
//    .m_axi_rlast     (m_axi_rlast),
// rlast was originally hooked up to the axi bram
// however, when we switched out for pcie2oursring we have no rlast signal
// we can't leave it floating or else vivado implementation will fail
// so we tie it to high because we are not using burst anyways
      .m_axi_rlast     (1'b1),
      .m_axi_rvalid    (m_axi_rvalid),
      .m_axi_rready    (m_axi_rready),

      .usr_irq_req       (usr_irq_req),
      .usr_irq_ack       (usr_irq_ack),
      .msi_enable        (msi_enable),
      .msi_vector_width  (msi_vector_width),

     // Config managemnet interface
      .cfg_mgmt_addr  ( 19'b0 ),
      .cfg_mgmt_write ( 1'b0 ),
      .cfg_mgmt_write_data ( 32'b0 ),
      .cfg_mgmt_byte_enable ( 4'b0 ),
      .cfg_mgmt_read  ( 1'b0 ),
      .cfg_mgmt_read_data (),
      .cfg_mgmt_read_write_done (),

      //-- AXI Global
      .axi_aclk        ( user_clk ),
      .axi_aresetn     ( user_resetn ),
      .user_lnk_up     ( user_lnk_up )
    );
`endif

// ila to monitor axi
  ila_0 ila_dma (
    .clk        (user_clk),
    .probe0     (m_axi_wready),
    .probe1     (m_axi_awaddr),
    .probe2     (2'b0),
    .probe3     (m_axi_wvalid),
    .probe4     (m_axi_rready),
    .probe5     (m_axi_araddr),
    .probe6     (m_axi_rvalid),
    .probe7     (m_axi_bvalid),
    .probe8     (m_axi_bready),
    .probe9     (m_axi_awvalid),
    .probe10    (m_axi_wdata),
    .probe11    (m_axi_arvalid),
    .probe12    (1'b0),
    .probe13    (2'b0),
    .probe14    (m_axi_rdata),

    .probe15    (64'b0),
    .probe16    (1'b0),
    .probe17    (3'b0),
    .probe18    (3'b0),
    .probe19    (m_axi_awid),
    .probe20    (m_axi_arid),
    .probe21    (8'b0),
    .probe22    (1'b0),
    .probe23    (3'b0),
    .probe24    (2'b0),
    .probe25    (m_axi_bid),
    .probe26    (1'b0),
    .probe27    (8'b0),
    .probe28    (3'b0),
    .probe29    (2'b0),
    .probe30    (1'b0),
    .probe31    (m_axi_rid),
    .probe32    (4'b0),
    .probe33    (4'b0),
    .probe34    (4'b0),
    .probe35    (1'b0),
    .probe36    (4'b0),
    .probe37    (4'b0),
    .probe38    (4'b0),
    .probe39    (1'b0),
    .probe40    (1'b0),
    .probe41    (1'b0),
    .probe42    (1'b0),
    .probe43    (1'b0)
    );
 
  //Why Do this ? FIXME
  //wire [7:0] slave_bid;
  //wire [7:0] slave_rid;
  //
  //assign m_axi_bid = slave_bid[C_M_AXI_ID_WIDTH-1 : 0];
  //assign m_axi_rid = slave_rid[C_M_AXI_ID_WIDTH-1 : 0];

  logic slave_req_awvalid;
  logic [63:0] slave_req_awaddr;
  logic [7:0]  slave_req_awid;
  logic  [7:0] slave_req_awlen;
  logic  [7:0] slave_req_arlen;
  logic slave_req_awready;
  logic slave_req_wvalid ;
  logic [511:0]slave_req_wdata  ;
  logic slave_req_wlast ;
  logic slave_req_wready ;
  logic slave_rsp_bvalid ;
  logic [7:0]  slave_rsp_bid;
  logic [1:0]  slave_rsp_bresp  ;
  logic slave_rsp_bready ;
  logic slave_req_arvalid;
  logic [63:0] slave_req_araddr ;
  logic [7:0]  slave_req_arid;
  logic slave_req_arready;
  logic slave_rsp_rvalid ;
  logic [7:0]  slave_rsp_rid;
  logic [511:0]slave_rsp_rdata  ;
  logic [1:0]slave_rsp_rresp  ;
  logic slave_rsp_rready ;
  logic slave_rsp_rlast;
  logic clk;
  logic rstn;
  logic  [(C_M_AXI_DATA_WIDTH/8)-1:0] slave_req_wstrb;

  assign slave_req_awvalid     = m_axi_awvalid;
  assign slave_req_awaddr      = m_axi_awaddr;
  assign slave_req_awlen       = m_axi_awlen;
  assign slave_req_awid        = m_axi_awid;
  assign m_axi_awready         = slave_req_awready;

  assign slave_req_wvalid      = m_axi_wvalid;
  assign slave_req_wdata       = m_axi_wdata;
  assign slave_req_wlast       = m_axi_wlast;
  assign slave_req_wstrb       = m_axi_wstrb;
  assign m_axi_wready          = slave_req_wready;
  
  assign m_axi_bvalid          = slave_rsp_bvalid;
  assign m_axi_bid             = slave_rsp_bid;
  assign m_axi_bresp           = slave_rsp_bresp;
  assign slave_rsp_bready      = m_axi_bready;

  assign slave_req_arvalid     = m_axi_arvalid;
  assign slave_req_araddr      = m_axi_araddr;
  assign slave_req_arid        = m_axi_arid;
  assign slave_req_arlen       = m_axi_arlen;
  assign m_axi_arready         = slave_req_arready;

  assign m_axi_rvalid          = slave_rsp_rvalid;
  assign m_axi_rid             = slave_rsp_rid;
  assign m_axi_rdata           = slave_rsp_rdata;
  assign m_axi_rresp           = slave_rsp_rresp;
  assign m_axi_rlast           = slave_rsp_rlast;
  assign slave_rsp_rready      = m_axi_rready;
  assign clk                   = user_clk;
  assign rstn                  = user_resetn;

pcie2oursring pcie2oursring_i (
  .slave_req_awvalid,
  .slave_req_awaddr ,
  .slave_req_awid,
  .slave_req_awready,
  .slave_req_awlen,
 
  .slave_req_wvalid ,
  .slave_req_wdata  ,
  .slave_req_wlast  ,
  .slave_req_wstrb  ,
  .slave_req_wready ,

  .slave_req_arlen,
  .slave_rsp_bvalid ,
  .slave_rsp_bid,
  .slave_rsp_bresp  ,
  .slave_rsp_bready ,
 
  .slave_req_arvalid,
  .slave_req_araddr ,
  .slave_req_arid,
  .slave_req_arready,
 
  .slave_rsp_rvalid ,
  .slave_rsp_rlast  ,
  .slave_rsp_rid,
  .slave_rsp_rdata  ,
  .slave_rsp_rresp  ,
  .slave_rsp_rready ,

  .or_req_awvalid,
  .or_req_aw,
  .or_req_awready,

  .or_req_wvalid,
  .or_req_w,
  .or_req_wready,

  .or_rsp_bvalid,
  .or_rsp_b,
  .or_rsp_bready,

  .or_req_arvalid,
  .or_req_ar,
  .or_req_arready,

  .or_rsp_rvalid,
  .or_rsp_r,
  .or_rsp_rready,

  .rst_out,

  .clk,
  .rstn,
  .or_clk
  );

endmodule
