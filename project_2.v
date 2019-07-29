module project_2(output wire [5:0]output_pins,
					  input  wire clk, rst
					  
);

//Net instantiations
		wire new_clk_net;
		wire interim_pwm_net;
		
//Module instantiations	

		//CLOCK DIVIDER
		clock_divider_module cdm_1 (
				.new_clk(new_clk_net),
				.clk(clk)
		);	

		//PWM MODULE
		pwm #(.CTR_LEN(10)) pwm_1 (
				.pwm_q(interim_pwm_net),
				.clk(clk),
				.rst(~rst),
				.compare(10'd512)
		);
		
		
		//BLDC FSM
		bldc_FSM fsm1 (
				.output_pins(output_pins),
				.fsm_clk(new_clk_net),
				.pwm_input(interim_pwm_net)
				
		);
		
		
	
endmodule	

