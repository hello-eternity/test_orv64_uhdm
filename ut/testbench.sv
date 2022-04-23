typedef enum logic [3:0] {
    CORNER_SET,
    CORNER_WAIT,
    CORNER_FIN,
    RANDOM_SET,
    RANDOM_WAIT,
    RANDOM_FIN
} state_t;

module testbench
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
#(
    parameter orv64_data_t CASE_NUM = 8,
    parameter orv64_data_t GROUP_NUM = 4,
    parameter orv64_data_t RANDOM_CASE_NUM = 100,
    parameter orv64_data_t OP_TYPE[GROUP_NUM] = '{ORV64_DIV_TYPE_Q, ORV64_DIV_TYPE_QU, ORV64_DIV_TYPE_QW, ORV64_DIV_TYPE_QUW},
    parameter string OP_NAME[GROUP_NUM] = '{"TYPE_Q", "TYPE_QU", "TYPE_QW", "TYPE_QUW"},


    parameter orv64_data_t Q_DIVIDEND[GROUP_NUM][CASE_NUM] = '{{20, -20, 20, -20, -64'd1<<63, -64'd1<<63, 1, 0},
                                                                {20, -20, 20, -20, -64'd1<<63, -64'd1<<63, 1, 0},
                                                                {20, -20, 20, -20, -1<<31, -1<<31, 1, 0},
                                                                {20, -20, 20, -20, -1<<31, -1<<31, 1, 0}},
    parameter orv64_data_t Q_DIVISOR[GROUP_NUM][CASE_NUM] = '{{3, -3, -3, 3, -64'd1<<63, -1, -1, -1},
                                                                {3, 64'd3074457345618258599, 0, 0, -64'd1<<63, 0, -1, -1},{3, -3, -3, 3, -1<<31, -1, -1, -1},
                                                                {3, 715827879, 0, 0, -1<<31, 0, -1, -1}},
    parameter orv64_data_t Q_ANSWER[GROUP_NUM][CASE_NUM] = '{{6, 6, -6, -6, 1, 64'd1<<63, -1, 0},
                                                                {6, 6, -1, -1, 1, -1, 0, 0}, 
                                                                {6, 6, -6, -6, 1, -1<<31, -1, 0}, 
                                                                {6, 6, -1, -1, 1, -1, 0, 0}}
    
)
(

);

logic clk;
logic rst;


initial begin
`ifdef VCS
	if ($test$plusargs("dump")) begin
        $vcdpluson();
    end
`else
	// $dumpfile("orv64.vcd");
	// $dumpvars(0, top0);
`endif
end

initial begin
	$display("init\n\n");
	clk = 1'b0;
	// $dumpon;
	forever #1 clk = ~clk;
	// $dumpoff;
end

initial begin
	rst = 1'b1;
	#20;
	rst = 1'b0;
end

orv64_data_t      rdq, rdr;
logic               complete;
orv64_data_t      rs1, rs2;
orv64_div_type_t  div_type;
logic       start_pulse;

logic [5:0] state;
integer index, group;

orv64_data_t rrs1, rrs2, ans;

always @(*) begin
    if (rs1[$bits(rs1)-1]) begin
        rrs1 = ~rs1 + 1;
    end
    else begin
        rrs1 = rs1;
    end
    if (rs2[$bits(rs2)-1]) begin
        rrs2 = ~rs2 + 1;
    end
    else if (rs2 == 0)begin
        rrs2 = 1;
    end
    else begin
        rrs2 = rs2;
    end

    if (rs2 == 0) begin
        ans = -64'd1;
    end
    else if(rs1[$bits(rs1)-1] ^ rs2[$bits(rs2)-1]) begin
        ans = ~(rrs1 / rrs2) + 1;
    end
    else begin
        ans = rrs1 / rrs2;
    end

end

always @(posedge clk) begin
    if (rst) begin
        rs1 <= 0;
        rs2 <= 0;
        div_type <= OP_TYPE[0];
        start_pulse <= 0;
        state <= 0;
        index <= 0;
        group <= 0;
    end
    else begin
        case (state)
            CORNER_SET: begin
                rs1 <= Q_DIVIDEND[group][index];
                rs2 <= Q_DIVISOR[group][index];
                start_pulse <= 1;
                state <= CORNER_WAIT;
            end
            CORNER_WAIT: begin
                start_pulse <= 0;
                if (complete) 
                    state <= CORNER_FIN;
            end
            CORNER_FIN: begin
                $write("group: %s case %d: 0x%x / 0x%x = 0x%x    ", OP_NAME[group], index, Q_DIVIDEND[group][index], Q_DIVISOR[group][index], Q_ANSWER[group][index]);
                if (rdq == Q_ANSWER[group][index]) begin
                    $write("PASS\n");
                end
                else begin
                    $write("FAIL output: 0x%x\n", rdq);
                end

                if (index == CASE_NUM - 1) begin
                    if (group == GROUP_NUM - 1) begin
                        $display("random test");
                        index <= 0;
                        state <= RANDOM_SET;
                    end
                    else begin
                        index <= 0;
                        group <= group + 1;
                        div_type <= OP_TYPE[group + 1];
                        state <= CORNER_SET;
                    end
                end
                else begin
                    index <= index + 1;
                    state <= CORNER_SET;
                end
            end
            RANDOM_SET: begin
                rs1 <= {$random, $random};
                rs2 <= {32'd0, $random};
                start_pulse <= 1;
                state <= RANDOM_WAIT;
                div_type <= ORV64_DIV_TYPE_Q;
            end
            RANDOM_WAIT: begin
                start_pulse <= 0;
                if (complete) 
                    state <= RANDOM_FIN;
            end
            RANDOM_FIN: begin
                
                $write("random case %d: 0x%x / 0x%x = 0x%x    ", index, rs1, rs2, ans);
                if (rdq == ans) begin
                    $write("PASS\n");
                end
                else begin
                    $write("FAIL output: 0x%x\n", rdq);
                end
                if (index == RANDOM_CASE_NUM) begin
                    $finish;
                end
                else begin
                    index <= index + 1;
                    state <= RANDOM_SET;
                end
            end
        endcase
    end
end


orv64_div dut
(
  .rdq, 
  .rdr,
  .complete,
  .rs1, 
  .rs2,
  .div_type,
  .start_pulse,
  .rst, 
  .clk
);

endmodule

