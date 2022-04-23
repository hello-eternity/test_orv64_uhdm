module dc_ram #( 
    parameter DEPTH      = 2, //1024,
    parameter WIDTH      = 256, 
    parameter WIDTH_BYTE = WIDTH/8,
    parameter ADDR_WIDTH = $clog2(DEPTH) // index = 10
)(
    input  logic                    clk,
    input  logic                    rst,
    input  logic                    en,
    input  logic                    rw,   // rw=0 (read), rw=1 (write)
    input  logic [WIDTH-1:0]        bit_mask,
    input  logic [ADDR_WIDTH-1:0]   addr,
    input  logic [WIDTH-1:0]        din,
    output logic [WIDTH-1:0]        qout
);

logic [DEPTH-1:0][WIDTH-1:0] ram; 


always_ff @ (posedge clk) begin
    if(rst) begin
`ifdef VCS
        for (int i = 0; i < DEPTH; i++) begin
            ram[i] <= '0;
        end
`endif
    end else if (rw & en) begin
        for (int i = 0; i < WIDTH; i=i+1) begin
            if (bit_mask[i]) begin
                ram[addr][i] <= din[i];
            end
        end
    end
end



logic [WIDTH-1:0] qout_next;
assign qout_next = ram[addr];
always_ff @ (posedge clk) begin : ram_read
    if(rst) begin
        qout <= '0;
    end else if(~rw & en) begin
        qout <= qout_next;
    end
end


`ifndef VCS
    initial begin
      for (int i = 0; i < DEPTH; i++) begin
        ram[i] = '0;
      end
    end
`endif


endmodule
