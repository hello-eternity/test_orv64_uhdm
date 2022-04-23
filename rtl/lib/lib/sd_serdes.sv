// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module sd_serializer
#(
  parameter int INPUT_WIDTH = 64,
  parameter int OUTPUT_WIDTH = 8
) (
  input   logic                     s_valid,
  input   logic [INPUT_WIDTH-1:0]   s_data,
  output  logic                     s_ready,

  output  logic                     d_valid,
  output  logic [OUTPUT_WIDTH-1:0]  d_data,
  input   logic                     d_ready,

  input   logic   rstn, clk
);
  localparam int N_PART = INPUT_WIDTH / OUTPUT_WIDTH;

`ifndef SYNTHESIS
  initial begin
    assert (INPUT_WIDTH > OUTPUT_WIDTH) else $error("%m: INPUT_WIDTH=%d should be larger than OUTPUT_WIDTH=%d", INPUT_WIDTH, OUTPUT_WIDTH);
    assert (2**$clog2(N_PART) == N_PART) else $error("%m: N_PART=%d", N_PART);
  end
`endif

  //==========================================================

  logic                     s_valid_ppln;
  logic [INPUT_WIDTH-1:0]   s_data_ppln;
  logic                     s_ready_ppln;

  sd_ppln #(.WIDTH(INPUT_WIDTH), .TYPE(2)) sd_ppln_ready_u (
    .s_valid, .s_data, .s_ready,
    .d_valid(s_valid_ppln), .d_data(s_data_ppln), .d_ready(s_ready_ppln),
    .*);

  //==========================================================

  enum logic {
    ST_SER,
    ST_DONE
  } rff_state, next_state;

  logic [$clog2(N_PART)-1:0]  rff_cnt, next_cnt;
  logic                       en_cnt;

  always_comb begin
    d_data = s_data_ppln[rff_cnt*OUTPUT_WIDTH +: OUTPUT_WIDTH];

    next_cnt = rff_cnt + 1;
    next_state = rff_state;
    en_cnt = '0;
    case (rff_state)
      ST_SER: begin
        d_valid = s_valid_ppln;
        s_ready_ppln = '0;

        next_state = ST_SER;
        en_cnt = '0;
        if (s_valid_ppln) begin
          if (d_ready) begin
            if (next_cnt == '1) begin
              // s_valid & d_ready & (next_cnt == '1)
              next_state = ST_DONE;
              en_cnt = '1;
            end else begin
              // s_valid & d_ready & (next_cnt != '1)
              next_state = ST_SER;
              en_cnt = '1;
            end
          end
        end
      end
      default: begin // ST_DONE
        d_valid = '1;
        s_ready_ppln = d_ready;

        if (d_ready) begin
          next_state = ST_SER;
          en_cnt = '1;
        end else begin
          next_state = ST_DONE;
          en_cnt = '0;
        end
      end
    endcase
  end

  always_ff @ (posedge clk) begin
    if (~rstn) begin
      rff_state <= ST_SER;
      rff_cnt <= '0;
    end else begin
      rff_state <= next_state;
      if (en_cnt) begin
        rff_cnt <= next_cnt;
      end
    end
  end

endmodule


module sd_deserializer
#(
  parameter int INPUT_WIDTH = 8,
  parameter int OUTPUT_WIDTH = 64
) (
  input   logic                     s_valid,
  input   logic [INPUT_WIDTH-1:0]   s_data,
  output  logic                     s_ready,

  output  logic                     d_valid,
  output  logic [OUTPUT_WIDTH-1:0]  d_data,
  input   logic                     d_ready,

  input   logic   rstn, clk
);
  localparam int N_PART = OUTPUT_WIDTH / INPUT_WIDTH;

`ifndef SYNTHESIS
  initial begin
    assert (INPUT_WIDTH < OUTPUT_WIDTH) else $error("%m");
    assert (2**$clog2(N_PART) == N_PART) else $error("%m");
  end
`endif

  enum logic {
    ST_ACC,
    ST_DONE
  } rff_state, next_state;

  logic [OUTPUT_WIDTH-1:0]    data_saved;
  logic [$clog2(N_PART)-1:0]  rff_cnt, next_cnt;
  logic                       en_cnt;

  always_comb begin
    d_data = {s_data, data_saved[OUTPUT_WIDTH-INPUT_WIDTH-1:0]};

    next_cnt = rff_cnt + 1;
    next_state = rff_state;
    en_cnt = '0;
    case (rff_state)
      ST_ACC: begin
        d_valid = '0;
        s_ready = '1;

        if (s_valid) begin
          if (next_cnt == '1) begin
            // s_valid & (next_cnt == '1)
            next_state = ST_DONE;
            en_cnt = '1;
          end else begin
            // s_valid & (next_cnt != '1)
            next_state = ST_ACC;
            en_cnt = '1;
          end
        end else begin
          // ~s_valid
          next_state = ST_ACC;
          en_cnt = '0;
        end
      end
      default: begin // ST_DONE
        d_valid = s_valid;
        s_ready = d_ready;

        if (s_valid & d_ready) begin
          next_state = ST_ACC;
          en_cnt = '1;
        end else begin
          next_state = ST_DONE;
          en_cnt = '0;
        end
      end
    endcase
  end

  always_ff @ (posedge clk) begin
    if (~rstn) begin
      rff_state <= ST_ACC;
      rff_cnt <= '0;
    end else begin
      rff_state <= next_state;
      if (en_cnt) begin
        data_saved[(rff_cnt*INPUT_WIDTH) +: INPUT_WIDTH] <= s_data;
        rff_cnt <= next_cnt;
      end
    end
  end


endmodule
