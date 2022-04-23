// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __SYNC_SV__
`define __SYNC_SV__

////////////////////////////////////////////////////////////////
// double flop clock domain crossing sync for data

module sync (
  output  logic q,
  input   logic d,
  input   logic clk
);

`ifdef SYNC_UNCERTAIN_SIM
  logic r0 = $urandom_range(0, 1);
  logic tmp = $urandom_range(0, 1);
  always_ff @(posedge clk) begin
    r0 <= $urandom_range(0, 1);
  end
  always_ff @(posedge clk) begin
    if (r0) begin
      tmp <= d;
    end
    q <= tmp;
  end
`else
`ifdef USE_T28HPCP
  wire ff0_out;
  DFD4BWP35P140 ff0 (.D(d), .CP(clk), .Q(ff0_out), .QN());
  DFD4BWP35P140 ff1 (.D(ff0_out), .CP(clk), .Q(q), .QN());
`else
`ifdef FPGA
  logic d0;
  always_ff @ (posedge clk) begin
    d0 <= d;
    q <= d0;
  end
`endif
`endif
`endif
endmodule

module data_sync (
  output  logic q,
  input   logic d, //spyglass disable W240
  input   logic clk //spyglass disable W240
);

`ifdef SYNC_UNCERTAIN_SIM
  logic r0 = $urandom_range(0, 1);
  logic tmp = $urandom_range(0, 1);
  always_ff @(posedge clk) begin
    r0 <= $urandom_range(0, 1);
  end
  always_ff @(posedge clk) begin
    if (r0) begin
      tmp <= d;
    end
    q <= tmp;
  end
`else
`ifdef USE_T28HPCP
  wire ff0_out;
  DFD4BWP35P140 ff0 (.D(d), .CP(clk), .Q(ff0_out), .QN());
  DFD4BWP35P140 ff1 (.D(ff0_out), .CP(clk), .Q(q), .QN());
`else
`ifdef FPGA
  logic d0;
  always_ff @ (posedge clk) begin
    d0 <= d;
    q <= d0;
  end
`endif
`endif
`endif
endmodule


////////////////////////////////////////////////////////////////
// double flop reset signal sync (for high enable)

module rst_sync (
  output  logic rst_out,
  input   logic rst_in,
  input   logic clk
);

`ifdef SYNC_UNCERTAIN_SIM
  logic r0 = $urandom_range(0, 1);
  logic tmp = $urandom_range(0, 1);
  always_ff @(posedge clk) begin
    r0 <= $urandom_range(0, 1);
  end
  always_ff @(posedge clk or posedge rst_in) begin
    if (rst_in) begin
      tmp <= 1'b1;
    end else if (r0) begin
      tmp <= rst_in;
    end
    if (rst_in) begin
      rst_out <= 1'b1;
    end else begin
      rst_out <= tmp;
    end
  end
`else
`ifdef USE_T28HPCP
  wire rst;
  DFCND4BWP35P140 ff0 (.D(1'b0), .CP(clk), .CDN(~rst_in), .Q(), .QN(rst));
  DFCND4BWP35P140 ff1 (.D(rst),  .CP(clk), .CDN(~rst_in), .Q(), .QN(rst_out));
`else
`ifdef FPGA
  logic rst;
  always_ff @ (posedge clk) begin
    rst <= rst_in;
    rst_out <= rst;
  end
`endif
`endif
`endif
endmodule


////////////////////////////////////////////////////////////////
// double flop reset signal sync (for low enable)

module rstn_sync (
  input   logic scan_en,
  input   logic scan_rstn,
  output  logic rstn_out,
  input   logic rstn_in,
  input   logic clk
);

`ifdef SYNC_UNCERTAIN_SIM
  logic r0 = $urandom_range(0, 1);
  logic tmp = $urandom_range(0, 1);
  always_ff @(posedge clk) begin
    r0 <= $urandom_range(0, 1);
  end
  always_ff @(posedge clk or negedge rstn_in) begin
    if (!rstn_in) begin
      tmp <= 1'b0;
    end else if (r0) begin
      tmp <= rstn_in;
    end
    if (!rstn_in) begin
      rstn_out <= 1'b0;
    end else begin
      rstn_out <= tmp;
    end
  end
`else
`ifdef USE_T28HPCP
  wire rstn;
  wire rstn_temp;
  assign rstn_out = scan_en ? scan_rstn : rstn_temp;
  DFCND4BWP35P140 ff0 (.D(1'b1), .CP(clk), .CDN(rstn_in), .Q(rstn),      .QN());
  DFCND4BWP35P140 ff1 (.D(rstn), .CP(clk), .CDN(rstn_in), .Q(rstn_temp), .QN());
`else
`ifdef FPGA
  logic rstn;
  always_ff @ (posedge clk) begin
    rstn <= rstn_in;
    rstn_out <= rstn;
  end
`endif
`endif
`endif
endmodule

`endif
