module bldc_FSM(
	output wire [5:0]output_pins,
	input fsm_clk, pwm_input
);


//STATES
	parameter AH_BL      = 3'b000; 
	parameter AH_CL      = 3'b001; 
	parameter BH_CL      = 3'b010; 
	parameter BH_AL      = 3'b011; 
	parameter CH_AL		= 3'b100;
	parameter CH_BL      = 3'b101;
	
//OUTPUTS
	//Since module is not TLE, we need our outputs to be wires
	reg pin_11 = 1'b0; 
	reg pin_10 = 1'b0; 
	reg pin_09 = 1'b0; 	
	reg pin_5  = 1'b0; 
	reg pin_4  = 1'b0;
	reg pin_3  = 1'b0; 	
		
		
//STATE VARIABLES		
	reg [2:0] currentState;
	reg [2:0] nextState;

//NET INSTANTIATIONS
	//Assign wire outputs to internal net regs
	//Only do this if you have you have combinational regs, yet output has to be wire
	assign output_pins[5]  = pin_11;
	assign output_pins[4]  = pin_10;
	assign output_pins[3]  = pin_09;
	assign output_pins[2]  = pin_5;
	assign output_pins[1]  = pin_4;
	assign output_pins[0]  = pin_3;
	
	
//STATE MEMORY BLOCK
	always @ (posedge(fsm_clk))
		begin: stateMemory
			currentState <= nextState;	
		end
	
//NEXT STATE LOGIC BLOCK
	always @(currentState)
		begin: nextStateLogic
			case(currentState)
				AH_BL:
					begin
						nextState = AH_CL;
					end
				AH_CL:
					begin 
						nextState = BH_CL;
					end
				BH_CL:
					begin
						nextState = BH_AL;
					end
				BH_AL:
					begin
						nextState = CH_AL;
					end
				CH_AL:
				   begin
						nextState = CH_BL;
					end
				CH_BL:
				   begin
						nextState = AH_BL;
					end
				default:
					begin
						nextState = AH_CL;
					end
			endcase
		end
		
//OUTPUT LOGIC
	always @(currentState)
		begin: outputLogic
			case(currentState)
				AH_BL:
					begin
						pin_11   = pwm_input;//PWM
						pin_10   = 1'b1;//HIGH
						pin_09   = 1'b0;
						pin_5    = 1'b1;//HIGH
						pin_4    = 1'b0;
						pin_3    = 1'b0;
					end
				AH_CL:
					begin 
						pin_11   = pwm_input;//PWM
						pin_10   = 1'b0;
						pin_09   = 1'b1;//HIGH
						pin_5    = 1'b1;//HIGH
						pin_4    = 1'b0;
						pin_3    = 1'b0;
					end
				BH_CL:
					begin
						pin_11   = 1'b0;
						pin_10   = pwm_input;//PWM
						pin_09   = 1'b1;//HIGH
						pin_5    = 1'b0;
						pin_4    = 1'b1;//HIGH
						pin_3    = 1'b0;
					end
				BH_AL:
					begin
						pin_11   = 1'b1;//HIGH
						pin_10   = pwm_input;//PWM
						pin_09   = 1'b0;
						pin_5    = 1'b0;
						pin_4    = 1'b1;//HIGH
						pin_3    = 1'b0;
					end
				CH_AL:
					begin
						pin_11   = 1'b1;//HIGH
						pin_10   = 1'b0;
						pin_09   = pwm_input;//PWM
						pin_5    = 1'b0;
						pin_4    = 1'b0;
						pin_3    = 1'b1;//HIGH
					end
				CH_BL:
					begin
						pin_11   = 1'b0;
						pin_10   = 1'b1;//HIGH
						pin_09   = pwm_input;//PWM
						pin_5    = 1'b0;
						pin_4    = 1'b0;
						pin_3    = 1'b1;//HIGH
					end
				default:
					begin
						pin_11   = pwm_input;//PWM
						pin_10   = 1'b1;//HIGH
						pin_09   = 1'b0;
						pin_5    = 1'b1;//HIGH
						pin_4    = 1'b0;
						pin_3    = 1'b0;
					end
			endcase
		end
endmodule	