
module ric
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import plic_typedef::*;
  import station_dma_pkg::*;
  #(
    parameter int NIRQ=18,
    parameter int NCORE=4
  ) (
    input   logic clk,

    //IO side
    input   logic               [NIRQ-1:0]  irq_in,

    //program IRQ owner
    input   plic_intr_core_id_t [NIRQ-1:0]  s2b_intr_core_id,

    //IRQ enable
    input   plic_intr_en_t      [NIRQ-1:0]  s2b_intr_en,

    //IRQ DBG enable
    input   plic_dbg_en_t       [NIRQ-1:0]  s2b_dbg_en,

    output  plic_intr_src_t     [NCORE-1:0]  b2s_intr_src,
    output  logic               [NCORE-1:0] external_int
);
  logic [NIRQ-1:0]  irq_sync_in;
  generate
    for (genvar i = 0; i < NIRQ; i++) begin
      data_sync plic_sync_u (.d(irq_in[i]), .q(irq_sync_in[i]), .clk(clk));
    end
  endgenerate

  generate
    for (genvar i = 0; i < NCORE; i++) begin
      always_comb begin
        //priority encoder
        external_int[i] = 1'b0;
        b2s_intr_src[i] = {$bits(plic_intr_src_t){1'b0}};
        for (int j = 0; j < NIRQ; j++) begin  //0 has the higest priority
          if ((s2b_intr_core_id[j] == i) & s2b_intr_en[j] & (irq_sync_in[j] | s2b_dbg_en[j])) begin
            external_int[i] = 1'b1;
            b2s_intr_src[i] = j;
            break;
          end
        end
      end
    end
  endgenerate
 
  `ifndef SYNTHESIS
  genvar ii,jj;
  logic [NIRQ-1:0] ext_int_taken[NCORE-1:0];
  logic [NIRQ-1:0] ext_int_taken_onehot[NCORE-1:0];
  
  generate
    for(ii=0;ii<NCORE;ii++) begin : GEN_EXT_INT_TAKEN_LOOP_0
        for(jj=0;jj<NIRQ;jj++) begin : GEN_EXT_INT_TAKEN_LOOP_1
            assign  ext_int_taken[ii][jj] = (s2b_intr_core_id[jj] == ii) & s2b_intr_en[jj] & (s2b_dbg_en[jj] | irq_sync_in[jj]);
        end
        assign ext_int_taken_onehot[ii][0] = ext_int_taken[ii][0];
        for(jj=1;jj<NIRQ;jj++)begin : GEN_EXT_INT_TAKEN_ONEHOT
            assign ext_int_taken_onehot[ii][jj] = (~|ext_int_taken[ii][jj-1:0]) & ext_int_taken[ii][jj];
        end
    end
    for(ii=0;ii<NCORE;ii++)begin : GEN_ASSERT
        assert_on_external_int : assert property ( @(posedge clk) ( (|ext_int_taken[ii]) |-> external_int[ii]))
        else
            `olog_error("plic assertion","missing valid external interrupt") ;
        assert_on_intr_src : assert property ( @(posedge clk) ( external_int[ii] |-> ext_int_taken_onehot[ii][b2s_intr_src[ii]]))
        else 
            `olog_error("plic assertion","wrong b2s_intr_src") ;
    end
  endgenerate
  `endif
endmodule
