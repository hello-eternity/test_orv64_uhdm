
module boot_from_flash_with_buf
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_slow_io_pkg::*;
  #(
    parameter BUF_DEPTH = 8
  ) (
  // Oursring Master
  input  oursring_resp_if_b_t axim_rsp_if_b,
  input  oursring_resp_if_r_t axim_rsp_if_r,
  input  logic                axim_rsp_if_rvalid,
  output logic                axim_rsp_if_rready,
  input  logic                axim_rsp_if_bvalid,
  output logic                axim_rsp_if_bready,
  output logic                axim_req_if_awvalid,
  output logic                axim_req_if_wvalid,
  output logic                axim_req_if_arvalid,
  output oursring_req_if_ar_t axim_req_if_ar,
  output oursring_req_if_aw_t axim_req_if_aw,
  output oursring_req_if_w_t  axim_req_if_w,
  input  logic                axim_req_if_arready,
  input  logic                axim_req_if_wready,
  input  logic                axim_req_if_awready,
  // Oursring Slave
  output oursring_resp_if_b_t axis_rsp_if_b,
  output oursring_resp_if_r_t axis_rsp_if_r,
  output logic                axis_rsp_if_rvalid,
  input  logic                axis_rsp_if_rready,
  output logic                axis_rsp_if_bvalid,
  input  logic                axis_rsp_if_bready,
  input  logic                axis_req_if_awvalid,
  input  logic                axis_req_if_wvalid,
  input  logic                axis_req_if_arvalid,
  input  oursring_req_if_ar_t axis_req_if_ar,
  input  oursring_req_if_aw_t axis_req_if_aw,
  input  oursring_req_if_w_t  axis_req_if_w,
  output logic                axis_req_if_arready,
  output logic                axis_req_if_wready,
  output logic                axis_req_if_awready,
  input  logic                clk,
  input  logic                rstn,
  input  logic                s2b_boot_from_flash_ena
  );

  logic                axis_req_if_awvalid_buf;
  logic                axis_req_if_wvalid_buf;
  logic                axis_req_if_arvalid_buf;
  oursring_req_if_ar_t axis_req_if_ar_buf;
  oursring_req_if_aw_t axis_req_if_aw_buf;
  oursring_req_if_w_t  axis_req_if_w_buf;
  logic                axis_req_if_arready_buf;
  logic                axis_req_if_wready_buf;
  logic                axis_req_if_awready_buf;

  ours_vld_rdy_buf #(
    .WIDTH($bits(oursring_req_if_aw_t)),
    .DEPTH(BUF_DEPTH)
  ) aw_buf (
    .slave_valid  (axis_req_if_awvalid),
    .slave_info   (axis_req_if_aw),
    .slave_ready  (axis_req_if_awready),
    .master_valid (axis_req_if_awvalid_buf),
    .master_info  (axis_req_if_aw_buf),
    .master_ready (axis_req_if_awready_buf),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk)
    );

  ours_vld_rdy_buf #(
    .WIDTH($bits(oursring_req_if_w_t)),
    .DEPTH(BUF_DEPTH)
  ) w_buf (
    .slave_valid  (axis_req_if_wvalid),
    .slave_info   (axis_req_if_w),
    .slave_ready  (axis_req_if_wready),
    .master_valid (axis_req_if_wvalid_buf),
    .master_info  (axis_req_if_w_buf),
    .master_ready (axis_req_if_wready_buf),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk)
    );

  ours_vld_rdy_buf #(
    .WIDTH($bits(oursring_req_if_ar_t)),
    .DEPTH(BUF_DEPTH)
  ) ar_buf (
    .slave_valid  (axis_req_if_arvalid),
    .slave_info   (axis_req_if_ar),
    .slave_ready  (axis_req_if_arready),
    .master_valid (axis_req_if_arvalid_buf),
    .master_info  (axis_req_if_ar_buf),
    .master_ready (axis_req_if_arready_buf),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk)
    );

  boot_from_flash boot_from_flash_u (
    .axim_rsp_if_b                (axim_rsp_if_b),
    .axim_rsp_if_r                (axim_rsp_if_r),
    .axim_rsp_if_rvalid           (axim_rsp_if_rvalid),
    .axim_rsp_if_rready           (axim_rsp_if_rready),
    .axim_rsp_if_bvalid           (axim_rsp_if_bvalid),
    .axim_rsp_if_bready           (axim_rsp_if_bready),
    .axim_req_if_awvalid          (axim_req_if_awvalid),
    .axim_req_if_wvalid           (axim_req_if_wvalid),
    .axim_req_if_arvalid          (axim_req_if_arvalid),
    .axim_req_if_ar               (axim_req_if_ar),
    .axim_req_if_aw               (axim_req_if_aw),
    .axim_req_if_w                (axim_req_if_w),
    .axim_req_if_arready          (axim_req_if_arready),
    .axim_req_if_wready           (axim_req_if_wready),
    .axim_req_if_awready          (axim_req_if_awready),
    .axis_rsp_if_b                (axis_rsp_if_b),
    .axis_rsp_if_r                (axis_rsp_if_r),
    .axis_rsp_if_rvalid           (axis_rsp_if_rvalid),
    .axis_rsp_if_rready           (axis_rsp_if_rready),
    .axis_rsp_if_bvalid           (axis_rsp_if_bvalid),
    .axis_rsp_if_bready           (axis_rsp_if_bready),
    .axis_req_if_awvalid          (axis_req_if_awvalid_buf),
    .axis_req_if_wvalid           (axis_req_if_wvalid_buf),
    .axis_req_if_arvalid          (axis_req_if_arvalid_buf),
    .axis_req_if_ar               (axis_req_if_ar_buf),
    .axis_req_if_aw               (axis_req_if_aw_buf),
    .axis_req_if_w                (axis_req_if_w_buf),
    .axis_req_if_arready          (axis_req_if_arready_buf),
    .axis_req_if_wready           (axis_req_if_wready_buf),
    .axis_req_if_awready          (axis_req_if_awready_buf),
    .clk                          (clk),
    .rstn                         (rstn),
    .s2b_boot_from_flash_ena      (s2b_boot_from_flash_ena)
    );

endmodule
