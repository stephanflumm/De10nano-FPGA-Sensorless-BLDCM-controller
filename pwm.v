module pwm #(parameter CTR_LEN = 8) 
  (
	 output reg pwm_q,
    input clk,
    input rst,
    input [CTR_LEN - 1 : 0] compare   //Same length as counter, as counter includes all values. Compare is assigned a single value
  );
  
  
  //Instantiate variables
  reg pwm_d;//pwm_q;
  reg [CTR_LEN - 1: 0] counter_d, counter_q;			//can consider this one counter, weird version of counting, which assigns d to q on clock signal
																	//and then does the + 1 in the combinational block
  
 
  //PWM signal
  //assign pwm = pwm_q;		//Since pwm output is a wire, we have to assign it outside of sequential blocks															
 
 
  //Combinational counting block
  //Also a compare block
  always @(*) begin
    counter_d = counter_q + 1'b1;
 
    if (compare > counter_q)		//If compare is > then stored count, toggle pwm, store it in D, wait to be triggered in next loop
      pwm_d = 1'b1;
    else
      pwm_d = 1'b0;
  end
 
  //Sequential Block
  //Only executes on clock cycles
  always @(posedge clk) begin
    if (rst) 
		 begin
			counter_q <= 1'b0;
		 end 
	 else 
		begin
			counter_q <= counter_d;
		end
    pwm_q <= pwm_d;					//PWM signal transferred on clock cycle								
  end
 
 
 
endmodule


