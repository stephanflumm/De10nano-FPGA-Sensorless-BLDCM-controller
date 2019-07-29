module clock_divider_module(
	 output reg new_clk,
    input clk
    
    );
    
    // The constant that defines the clock speed. 
    // define_speed = 50MHz/(2*desired_clock_frequency)
		reg [20:0] define_speed = 20'd125000;
		reg [20:0] count;
		reg [20:0] count2;
		
    
		always @ (posedge(clk))
			begin
				if(count == define_speed)
					begin
						count <= 20'b0;
						new_clk = ~new_clk;
					end      
				else
					begin
						count <= count + 1'b1;
						new_clk = new_clk;
					end
				
				
				
				if(define_speed > 62500)
					begin
						if(count2 < 1000)
							begin
								count2 <= count2 + 1;
							end
						else
							begin
								define_speed <= define_speed - 1;
								count2 <= 25'b0;
							end
				end
			end

		
		
			
endmodule

