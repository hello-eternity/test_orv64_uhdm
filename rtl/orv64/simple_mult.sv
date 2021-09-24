module simple_mult(
    input[63:0]             a,                            
    input[63:0]             b,
    input                   ce,
    
    input                   is_signed_a,
    input                   is_signed_b,
    
    output reg              done,
    output reg[127:0]       product,
    input                    clk,
    input                    rst_n
    );
    
    reg[127:0] _product;
    reg[6:0] cnt; 
    wire[63:0] op_a, op_b;
    assign op_a = is_signed_a & a[63] ? (~a) + 1 : a;
    assign op_b = is_signed_b & b[63] ? (~b) + 1 : b;
    
    always @(posedge clk, negedge rst_n)
    begin
        if (!rst_n)
        begin
            cnt <= 7'b0;
            _product <= 128'd0;
            done <= 1'b0;
        end
        else if (!cnt[6])
        begin
            done <= 1'b0;
            if (ce)
            begin
                if (op_b[cnt])
                    if (cnt == 7'd0)
                        _product <= op_a;
                    else
                        _product <= _product + (op_a << cnt);
                if ((op_b >> cnt) == 'b0)
                    cnt <= 7'b1000000;
                else
                    cnt <= cnt + 1;
            end
            else
            begin
                _product <= 'b0;
                cnt <= 1'b0;
            end
        end
        else
        begin
            cnt <= 7'd0;
            done <= 1'b1;
        end
    end
    
    always_comb
    begin
        product = _product;
        if (is_signed_b) // must be ss
            if(a[63] ^ b[63])
                product = (~_product) + 1;
        else if (is_signed_a)   //must be su
            if(a[63])
                product = (~_product) + 1;
    end
    
endmodule
