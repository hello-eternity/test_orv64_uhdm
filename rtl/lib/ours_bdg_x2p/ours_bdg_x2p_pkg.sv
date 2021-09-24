//===============================================
// Filename     : ours_dbg_pkg.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2019-12-16 17:47:30
// Description  : ours bridge package defination
//              1) number of peripherals can be configured
//              2) address space for each peripheral can be configured, by now, for simplicity,all peripherals have the same address space size.
//              3) FIFO depth can be configured
//              4) data width can be configured for AXI side and APB side, should be the same width.
//              5) address width for AXI and APB can be configured
//================================================

//`define OURS_BDG_X2P_PERI_NUM                   20
//`define OURS_BDG_X2P_PERI_BASE_ADDR             `OURS_BDG_X2P_AXI_ADDR_W'h0
//`define OURS_BDG_X2P_PERI_ADDR_SPACE_SZ         `OURS_BDG_X2P_AXI_ADDR_W'h400
//
//
//`define OURS_BDG_X2P_FIFO_DEPTH                 2
//
//`define OURS_BDG_X2P_AXI_ID_W                   12
//`define OURS_BDG_X2P_AXI_ADDR_W                 40
//`define OURS_BDG_X2P_AXI_LEN_W                  4
//`define OURS_BDG_X2P_AXI_LOCK_W                 2
//`define OURS_BDG_X2P_AXI_DATA_W                 32
//`define OURS_BDG_X2P_AXI_WSTRB_W                4
//`define OURS_BDG_X2P_APB_ADDR_W                 32
//`define OURS_BDG_X2P_APB_DATA_W                 32

package ours_bdg_x2p_pkg;

parameter OURS_BDG_X2P_AXI_ID_W                   = 12;
parameter OURS_BDG_X2P_AXI_ADDR_W                 = 40;
parameter OURS_BDG_X2P_AXI_LEN_W                  = 4;
parameter OURS_BDG_X2P_AXI_LOCK_W                 = 2;
parameter OURS_BDG_X2P_AXI_DATA_W                 = 32;
parameter OURS_BDG_X2P_AXI_WSTRB_W                = 4;
parameter OURS_BDG_X2P_APB_ADDR_W                 = 32;
parameter OURS_BDG_X2P_APB_DATA_W                 = 32;
//axi4
typedef struct packed {
    logic [OURS_BDG_X2P_AXI_ID_W-1:0]       awid;
    logic [OURS_BDG_X2P_AXI_ADDR_W-1:0]     awaddr;
    logic [OURS_BDG_X2P_AXI_LEN_W-1:0]      awlen;
    logic [OURS_BDG_X2P_AXI_LOCK_W-1:0]     awlock;
    logic [1:0]                             awburst;
    logic [2:0]                             awsize;
    logic [3:0]                             awcache;
    logic [2:0]                             awprot;
} axi_aw_t;

typedef struct packed {
    logic [OURS_BDG_X2P_AXI_ID_W-1:0]       wid;
    logic [OURS_BDG_X2P_AXI_DATA_W-1:0]     wdata;
    logic [OURS_BDG_X2P_AXI_WSTRB_W-1:0]    wstrb;
    logic                                   wlast;
} axi_w_t;

typedef struct packed {
    logic [OURS_BDG_X2P_AXI_ID_W-1:0]       bid;
    logic [1:0]                             bresp;
} axi_b_t;
typedef struct packed {
    logic [OURS_BDG_X2P_AXI_ID_W-1:0]       arid;
    logic [OURS_BDG_X2P_AXI_ADDR_W-1:0]     araddr;
    logic [OURS_BDG_X2P_AXI_LEN_W-1:0]      arlen;
    logic [OURS_BDG_X2P_AXI_LOCK_W-1:0]     arlock;
    logic [1:0]                             arburst;
    logic [2:0]                             arsize;
    logic [3:0]                             arcache;
    logic [2:0]                             arprot;
} axi_ar_t;
typedef struct packed {
    logic [OURS_BDG_X2P_AXI_ID_W-1:0]       rid;
    logic [OURS_BDG_X2P_AXI_DATA_W-1:0]     rdata;
    logic [1:0]                             rresp;
    logic                                   rlast;
} axi_r_t;

typedef struct packed {
    logic                                   pwrite;
    logic   [OURS_BDG_X2P_APB_ADDR_W-1:0]   paddr;
    logic   [OURS_BDG_X2P_APB_DATA_W-1:0]   pwdata;
} apb_req_t;
typedef struct packed {
    logic   [OURS_BDG_X2P_APB_DATA_W-1:0]   prdata;
    logic                                   pslverr;
} apb_resp_t;

typedef struct packed {
    logic                                   pwrite;
    logic   [OURS_BDG_X2P_AXI_ID_W-1:0]     req_id;
} cvt_queue_req_id_t;

endpackage

