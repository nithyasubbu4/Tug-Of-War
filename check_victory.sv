module check_victory(clk, reset, L, R, LED9, LED1, HEX0, HEX5, playAgain);
	output logic [6:0] HEX0, HEX5;
	output logic playAgain;
	input logic reset;
	input logic clk;
	input logic L, R, LED9, LED1;
	
	logic [2:0] computerCount;
	logic [2:0] userCount;
	
	enum {curr_play, winner1, winner2} ps, ns;
	
	always_comb begin 
		case(ps)
		
			curr_play: if(L & ~R & LED9) ns = winner2;
						  else if(~L & R & LED1) ns = winner1;
						  else ns = curr_play;
						  
						  
			winner1: ns = curr_play; //user
			winner2: ns = curr_play; //computer
		
		endcase
	end
	
	always_comb begin
		if(userCount == 3'b000) //0
			HEX0 = 7'b1000000;
		
		else if(userCount == 3'b001) //1
			HEX0 = 7'b1111001;
		
		else if(userCount == 3'b010) //2
			HEX0 = 7'b0100100;
		
		else if(userCount == 3'b011) //3
			HEX0 = 7'b0110000;
		
		else if(userCount == 3'b100) //4
			HEX0 = 7'b0011001;
			
		else if(userCount == 3'b101) //5
			HEX0 = 7'b0010010;
			
		else if(userCount == 3'b110) //6
			HEX0 = 7'b0000010;
		
		else 
			HEX0 = 7'b1111000;
		//
	
		
		if(computerCount == 3'b000)
			HEX5 = 7'b1000000;
			
		else if(computerCount == 3'b001)
			HEX5 = 7'b1111001;
			
		else if(computerCount == 3'b010)
			HEX5 = 7'b0100100;
			
		else if(computerCount == 3'b011)
			HEX5 = 7'b0110000;
			
		else if(computerCount == 3'b100)
			HEX5 = 7'b0011001;
			
		else if(computerCount == 3'b101)
			HEX5 = 7'b0010010;
		
		else if(computerCount == 3'b110)
			HEX5 = 7'b0000010;
			
		else
			HEX5 = 7'b1111000;
	end
	
	always_ff @(posedge clk) begin
		if(ps == curr_play & ns == winner1) begin
			userCount <= userCount + 1;
		end
		
		else if(ps == curr_play & ns == winner2) begin
			computerCount <= computerCount + 1;
		end
		
		else begin 
			userCount <= userCount;
			computerCount <= computerCount;
		end
		
		
		if(reset | HEX0 == 7'b1111000 | HEX5 == 7'b1111000) begin
			userCount <= 3'b00;
			computerCount <= 3'b00;
			ps<= curr_play;
			playAgain <= 0;
		end
		
		else if(playAgain) begin
			ps <= curr_play;
			playAgain <= 0;
		end
		
		else
			ps <= ns;
		
		if(ps == winner1 | ps == winner2)
			playAgain <= 1;
		else 
			playAgain <= 0;
		end
	
	/*always_comb begin	
		if (reset)
			playAgain = 1;
		
		else if ((ps == winner1) | (ps == winner2))
			playAgain = 1;
		
		else 
			playAgain = 0;
	end	
	
	
	always_ff @(posedge clk) begin
		
		if(reset) begin
			userCount <= 3'b000;
			computerCount <= 3'b000;
			ps <= curr_play;
		end
		
		else if(ps == curr_play & ns == winner1) begin
			
			userCount <= userCount + 1;
		
		end
		
		else if(ps == curr_play & ns == winner2) begin
			
			computerCount <= computerCount + 1;
		end
		
		else begin 
			computerCount <= computerCount;
			userCount <= userCount;	
			ps <= ns;
			
		end
	end*/
		
		//else if(playAgain) begin
			//ps <= curr_play;
			//playAgain <= 0;	
		//end
					
		
		//if(ps == winner1 | ps == winner2)
			//playAgain <= 1;
		
		//else
			//playAgain <= 0;
endmodule


module check_victory_testbench();
	logic clk;
	logic reset;
	logic L, R, LED9, LED1;
	logic playAgain;
	logic [6:0] HEX0;
	
	
	check_victory dut(.clk, .reset, .L, .R, .LED9, .LED1, .HEX0, .playAgain);
	
	initial begin
		clk <= 0;
		forever #(50)
		clk <= ~clk;
	end
	
	initial begin
		reset <= 1;         								@(posedge clk)
																@(posedge clk)
		reset <= 0;			  								@(posedge clk)
																@(posedge clk)
		
		LED9 <= 1; LED1 <= 0; L <= 1; R <= 0;		@(posedge clk)
																@(posedge clk)
																@(posedge clk)
																
		LED9 <= 0; LED1 <= 1;							@(posedge clk)
																@(posedge clk)
																@(posedge clk)
		LED9 <= 1; LED1 <= 1; 							@(posedge clk)
																@(posedge clk)	
		LED1 <= 0; R <= 1;								@(posedge clk)
																@(posedge clk)
		reset <= 1;											@(posedge clk)
																@(posedge clk)
		reset <= 0;											@(posedge clk)
																@(posedge clk)
		LED9 <= 0; LED1 <= 1; L <= 0; R <= 1;		@(posedge clk)
																@(posedge clk)
																@(posedge clk)
		LED9 <= 1;											@(posedge clk)
																@(posedge clk)
																@(posedge clk)
		LED9 <= 0; L <= 1;								@(posedge clk)
																@(posedge clk)

		$stop;
	end
endmodule  
