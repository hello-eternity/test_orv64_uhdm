// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __SD_PPLN_SV__
`define __SD_PPLN_SV__

module sd_ppln
#(
  parameter int     WIDTH = 8,    // width of the data
  parameter int     TYPE = 3 // BYPASS/VALID/READY/FULL
) (
  // source side
  input   logic             s_valid,
  input   logic [WIDTH-1:0] s_data,
  output  logic             s_ready,
  // destination side
  output  logic             d_valid,
  output  logic [WIDTH-1:0] d_data,
  input   logic             d_ready,
  // rst & clk
  input                     rstn, // active low reset
                            clk   // rising edge triggered clock
);

`ifndef SYNTHESIS
  initial begin
    assert ((TYPE == 0) | (TYPE == 1) | (TYPE == 2) | (TYPE == 3))
    else $fatal("sd_ppln: TYPE=%s is not valid", TYPE);
  end
`endif

  typedef enum logic {
    ST_BYPASS = 1'b0,
    ST_HOLD = 1'b1
  } ppln_ready_type_st;

  typedef enum logic [2:0] {
    ST_EMPTY    = 3'h0,
    ST_OUTPUT1  = 3'h1,
    ST_OUTPUT2  = 3'h2,
    ST_FULL1    = 3'h3,
    ST_FULL2    = 3'h4
  } ppln_full_type_st;


  generate
    //==========================================================
    // BYPASS {{{
    if (TYPE == 0) begin
      assign d_valid  = s_valid;
      assign d_data   = s_data;
      assign s_ready  = d_ready;
    end
    // }}}

    //==========================================================
    // PPLN_VALID {{{
    if (TYPE == 1) begin
      logic [WIDTH-1:0] dff_data;
      logic             rff_valid;

      always_ff @ (posedge clk) begin
        if (~rstn) begin
          rff_valid <= '0;
        end else begin
          if (s_ready) begin
            rff_valid <= s_valid;
            if (s_valid) begin
              dff_data <= s_data;
            end
          end
        end
      end

      assign d_valid = rff_valid;
      assign d_data = dff_data;

      assign s_ready = d_ready | ~d_valid;
    end
    // }}}

    //==========================================================
    // PPLN_READY {{{
    if (TYPE == 2) begin
      ppln_ready_type_st rff_state, next_state;
      logic             en;
      logic [WIDTH-1:0] dff_data;

      always_comb begin
        next_state = rff_state;
        en = '0;
        case (rff_state)
          ST_HOLD: begin
            d_valid = '1;
            d_data = dff_data;
            s_ready = '0;

            if (d_ready) begin
              next_state = ST_BYPASS;
            end
          end
          default: begin // ST_BYPASS
            d_valid = s_valid;
            d_data = s_data;
            s_ready = '1;

            if (s_valid & ~d_ready) begin
              next_state = ST_HOLD;
              en = '1;
            end
          end
        endcase
      end

      always_ff @ (posedge clk) begin
        if (~rstn) begin
          rff_state <= ST_BYPASS;
        end else begin
          rff_state <= next_state;
          if (en) begin
            dff_data <= s_data;
          end
        end
      end
    end
    // }}}

    //==========================================================
    // PPLN_FULL {{{
    if (TYPE == 3) begin
      ppln_full_type_st rff_state, next_state;

      logic [WIDTH-1:0] dff_data [2]; // 2 entries of saved data, higher overhead than PPLN_VALID and PPLN_READY
      logic             en,           // enable flop input to dff_data
                        sel_in,       // input selection to dff_data
                        sel_out;      // output selection from dff_data

      assign d_data = dff_data[sel_out];

      always_comb begin
        next_state = rff_state;
        en = '0;
        sel_in = '0;
        case (rff_state)
          ST_OUTPUT1: begin
            d_valid = '1;
            s_ready = '1;
            sel_out = '0;

            if (s_valid) begin
              if (d_ready) begin
                // s_valid & d_ready
                next_state = ST_OUTPUT1;
                en = '1;
                sel_in = '0;
              end else begin
                // s_valid & ~d_ready
                next_state = ST_FULL1;
                en = '1;
                sel_in = '1;
              end
            end else begin
              if (d_ready) begin
                // ~s_valid & d_ready
                next_state = ST_EMPTY;
                en = '0;
              end else begin
                // ~s_valid & ~d_ready
                next_state = ST_OUTPUT1;
                en = '0;
              end
            end
          end
          ST_FULL1: begin
            d_valid = '1;
            s_ready = '0;
            sel_out = '0;

            if (d_ready) begin
              next_state = ST_OUTPUT2;
              en = '0;
            end else begin
              next_state = ST_FULL1;
              en = '0;
            end
          end
          ST_OUTPUT2: begin
            d_valid = '1;
            s_ready = '1;
            sel_out = '1;

            if (s_valid) begin
              if (d_ready) begin
                // s_valid & d_ready
                next_state = ST_OUTPUT1;
                en = '1;
                sel_in = '0;
              end else begin
                // s_valid & ~d_ready
                next_state = ST_FULL2;
                en = '1;
                sel_in = '0;
              end
            end else begin
              if (d_ready) begin
                // ~s_valid & d_ready
                next_state = ST_EMPTY;
                en = '0;
              end else begin
                // ~s_valid & ~d_ready
                next_state = ST_OUTPUT2;
                en = '0;
              end
            end
          end
          ST_FULL2: begin
            d_valid = '1;
            s_ready = '0;
            sel_out = '1;

            if (d_ready) begin
              next_state = ST_OUTPUT1;
              en = '0;
            end else begin
              next_state = ST_FULL2;
              en = '0;
            end
          end
          default: begin // ST_EMPTY
            d_valid = '0;
            s_ready = '1;
            sel_out = '0;

            if (s_valid) begin
              en = '1;
              sel_in = '0;
              next_state = ST_OUTPUT1;
            end else begin
              en = '0;
              next_state = ST_EMPTY;
            end
          end
        endcase
      end

      //spyglass disable_block FlopEConst
      always_ff @ (posedge clk) begin
        if (~rstn) begin
          rff_state <= ST_EMPTY;
        end else begin
          rff_state <= next_state;

          if (en) begin
            dff_data[sel_in] <= s_data;
          end
        end
      end
      //spyglass enable_block FlopEConst

    end
    // }}}

  endgenerate

endmodule

`endif
