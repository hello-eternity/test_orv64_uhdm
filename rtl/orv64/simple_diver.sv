module diver_simple(
	input clk,
	input rst_n,
	
	input is_signed,
	input[63:0] opdata1,
	input[63:0] opdata2,
	input start_pulse,
	
	output[127:0] result,
	output done
);

	wire[64:0] div_temp;
	reg[6:0] cnt;
	reg[128:0] dividend;
	reg[1:0] state;
	reg[63:0] divisor;	 
	reg[63:0] temp_op1;
	reg[63:0] temp_op2;
	
	assign div_temp = {1'b0,dividend[127:64]} - {1'b0,divisor};

	always @ (posedge clk, negedge rst_n) 
	begin
		if (!rst_n) 
		begin
			state <= 2'd0;
		end 
		else 
		begin
		  case (state)
		  	2'd0:			
			begin               //DivFree״̬
		  		if(start_pulse) 
				begin
					
		  			if(opdata2 == 64'd0) 
					begin
		  				state <= 2'd1;
		  			end 
					else 
					begin
		  				state <= 2'd2;
		  				cnt <= 7'b0;
                        
		  				if(is_signed && opdata1[63]) 
		  					temp_op1 = ~opdata1 + 1;
						else 
		  					temp_op1 = opdata1;

		  				if(is_signed && opdata2[63]) 
		  					temp_op2 = ~opdata2 + 1;
						else 
		  					temp_op2 = opdata2;

						dividend <= {64'd0,64'd0};
						dividend[64:1] <= temp_op1;
						divisor <= temp_op2;
					end
				end        	
		  	end
		  	2'd1:		
			begin               //DivByZero״̬
         	    dividend <= {64'd0,64'd0};
				state <= 2'd3;		 		
		  	end
		  	2'd2:				
			begin               //DivOn״̬
                if(!cnt[6]) 
                begin
                    if(div_temp[64] == 1'b1) 
                    begin
                        dividend <= {dividend[127:0] , 1'b0};
                    end 
                    else 
                    begin
                        dividend <= {div_temp[63:0] , dividend[63:0] , 1'b1};
                    end
                    cnt <= cnt + 1;
                end 
                else 
                begin
                    if((is_signed == 1'b1) && ((opdata1[63] ^ opdata2[63]) == 1'b1)) 
                    begin
                        dividend[63:0] <= (~dividend[63:0] + 1);
                    end
                    if((is_signed == 1'b1) && ((opdata1[63] ^ dividend[128]) == 1'b1)) 
                    begin              
                        dividend[128:65] <= (~dividend[128:65] + 1);
                    end
                    state <= 2'd3;
                    cnt <= 7'b0;            	
                end
		  	end
		  	2'd3:			//DivEnd״̬
			if(!start_pulse)
	            state <= 2'd0;

		  endcase
		end
	end

    assign result = {dividend[63:0], dividend[128:65]};
    assign done = state == 2'd3;
	
endmodule
