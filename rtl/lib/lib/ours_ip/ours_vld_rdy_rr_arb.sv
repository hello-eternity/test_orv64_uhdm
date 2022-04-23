// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_vld_rdy_rr_arb #(
  parameter BACKEND_DOMAIN = 0,
  parameter N_INPUT = 2
) (
  input   logic [N_INPUT-1:0] vld,
  input   logic               rdy,
  output  logic [N_INPUT-1:0] grt,
  input   logic               rstn, clk
);

  localparam N_INPUT_BITS = $clog2(N_INPUT);

  typedef enum logic {
    ST_PASS_THROUGH,
    ST_HOLD
  } vld_rdy_rr_arb_st_t;

generate
  if (N_INPUT == 1) begin
    assign grt = vld;
  end else begin

    vld_rdy_rr_arb_st_t       rff_state, next_state;
    logic [N_INPUT_BITS-1:0]  rff_last_grt_id, grt_id;
    logic [N_INPUT-1:0]       vld_with_priority;
    logic [N_INPUT-1:0]       grt_with_priority, next_grt, rff_grt;
    logic                     rff_do_hold_grt, do_save_grt;

    // vld_with_priority
    always_comb begin
      vld_with_priority = vld;
      //if (rff_last_grt_id == N_INPUT-1) begin
      //  vld_with_priority = vld;
      //end else begin
      if (rff_last_grt_id != N_INPUT-1) begin
        for (int i = 0; i < N_INPUT; i++) begin
          if (i > rff_last_grt_id) begin
            vld_with_priority[i - rff_last_grt_id - 1'b1] = vld[i];
          end else begin
            vld_with_priority[N_INPUT - rff_last_grt_id - 1'b1 + i] = vld[i];
          end
        end
      end
    end

    // grt_with_priority
    always_comb begin
      grt_with_priority = {N_INPUT{1'b0}};
      if (|vld_with_priority) begin
        for (int i = 0; i < N_INPUT; i++) begin
          if (vld_with_priority[i] == 1'b1) begin
            grt_with_priority[i] = 1'b1;
            break;
          end
        end
      end
    end

    // next_grt
    always_comb begin
      if (rff_last_grt_id == N_INPUT-1) begin
        next_grt = grt_with_priority;
      end else begin
        for (int i = 0; i < N_INPUT; i++) begin
          if (i > rff_last_grt_id) begin
            next_grt[i] = grt_with_priority[i - rff_last_grt_id - 1'b1];
          end else begin
            next_grt[i] = grt_with_priority[N_INPUT - rff_last_grt_id - 1'b1 + i];
          end
        end
      end
    end

    always_comb begin
      grt_id = rff_last_grt_id + {{(N_INPUT_BITS-1){1'b0}}, 1'b1};
      if (|next_grt) begin
        for (int i = 0; i < N_INPUT; i++) begin
          if (next_grt[i] == 1'b1) begin
            grt_id = N_INPUT_BITS'(i);
            break;
          end
        end
      end
    end

    // Grant Update
    always_ff @(posedge clk) begin
      if (!rstn) begin
        rff_grt <= '0;
      end else begin
        if (do_save_grt) begin
          rff_grt <= grt;
        end
      end
    end

    always_ff @(posedge clk) begin
      if (!rstn) begin
        rff_last_grt_id <= N_INPUT_BITS'(N_INPUT-1);
      end else begin
        if ((|grt) & rdy) begin
          rff_last_grt_id <= grt_id;
        end
      end
    end

    always_ff @(posedge clk) begin
      if (!rstn) begin
        rff_state <= ST_PASS_THROUGH;
      end else begin
        rff_state <= next_state;
      end
    end

    always_comb begin
      case (rff_state)
        ST_HOLD: begin
          do_save_grt = '0;
          if (rdy) begin
            next_state = ST_PASS_THROUGH;
          end else begin
            next_state = ST_HOLD;
          end
        end
        default: begin
          if ((|grt) & ~rdy) begin
            do_save_grt = '1;
            next_state = ST_HOLD;
          end else begin
            do_save_grt = '0;
            next_state = ST_PASS_THROUGH;
          end
        end
      endcase
    end

    assign grt = (rff_state == ST_HOLD) ? rff_grt: next_grt;
  end
endgenerate
 
endmodule
