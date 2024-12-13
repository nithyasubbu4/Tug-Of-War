// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, CLOCK_50);
	input logic CLOCK_50;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;

	logic key0_dFlip, key3_dFlip;

	logic KEY0, KEY3;
	
	logic [31:0] clk;
	parameter clockRate = 0; //for simulation
	//parameter clockRate = 15; //for board
	clock_divider dividedClock (CLOCK_50, clk);
	
	logic cyberPlayer;
	logic playAgain;
	
	logic [9:0] LFSR_out; 
	
	assign HEX4 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX1 = 7'b1111111;

	dFlipFlop key0_F1 (.clk(clk[clockRate]), .reset(SW[9]), .button(~KEY[0]), .out(key0_dFlip));
	dFlipFlop key3_F1 (.clk(clk[clockRate]), .reset(SW[9]), .button(cyberPlayer), .out(key3_dFlip));
	
	User_Input player (.clk(clk[clockRate]), .reset(SW[9]), .button(key0_dFlip), .out(KEY0));
	User_Input computer (.clk(clk[clockRate]), .reset(SW[9]), .button(key3_dFlip), .out(KEY3));
	
//	normalLight light1 (.clk(clk[clockRate]), .reset(SW[9]| playAgain), .L(cyberPlayer), .R(KEY0), .NL(LEDR[2]), .NR(1'b0), .lightOn(LEDR[1]));
//	normalLight light2 (.clk(clk[clockRate]), .reset(SW[9]| playAgain), .L(cyberPlayer), .R(KEY0), .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]));
//	normalLight light3 (.clk(clk[clockRate]), .reset(SW[9]| playAgain), .L(cyberPlayer), .R(KEY0), .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]));
//	normalLight light4 (.clk(clk[clockRate]), .reset(SW[9]| playAgain), .L(cyberPlayer), .R(KEY0), .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]));
//	centerLight light5 (.clk(clk[clockRate]), .reset(SW[9]| playAgain), .L(cyberPlayer), .R(KEY0), .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5]));
//	normalLight light6 (.clk(clk[clockRate]), .reset(SW[9]| playAgain), .L(cyberPlayer), .R(KEY0), .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]));
//	normalLight light7 (.clk(clk[clockRate]), .reset(SW[9]| playAgain), .L(cyberPlayer), .R(KEY0), .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]));
//	normalLight light8 (.clk(clk[clockRate]), .reset(SW[9]| playAgain), .L(cyberPlayer), .R(KEY0), .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]));
//	normalLight light9 (.clk(clk[clockRate]), .reset(SW[9]| playAgain), .L(cyberPlayer), .R(KEY0), .NL(1'b0), .NR(LEDR[8]), .lightOn(LEDR[9]));

	
	normalLight light1 (.clk(clk[clockRate]), .reset(SW[9]), .L(KEY3), .R(KEY0), .NL(LEDR[2]), .NR(1'b0), .lightOn(LEDR[1]), .playAgain(playAgain));
	normalLight light2 (.clk(clk[clockRate]), .reset(SW[9]), .L(KEY3), .R(KEY0), .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]), .playAgain(playAgain));
	normalLight light3 (.clk(clk[clockRate]), .reset(SW[9]), .L(KEY3), .R(KEY0), .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]), .playAgain(playAgain));
	normalLight light4 (.clk(clk[clockRate]), .reset(SW[9]), .L(KEY3), .R(KEY0), .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]), .playAgain(playAgain));
	centerLight light5 (.clk(clk[clockRate]), .reset(SW[9]), .L(KEY3), .R(KEY0), .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5]), .playAgain(playAgain));
	normalLight light6 (.clk(clk[clockRate]), .reset(SW[9]), .L(KEY3), .R(KEY0), .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]), .playAgain(playAgain));
	normalLight light7 (.clk(clk[clockRate]), .reset(SW[9]), .L(KEY3), .R(KEY0), .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]), .playAgain(playAgain));
	normalLight light8 (.clk(clk[clockRate]), .reset(SW[9]), .L(KEY3), .R(KEY0), .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]), .playAgain(playAgain));
	normalLight light9 (.clk(clk[clockRate]), .reset(SW[9]), .L(KEY3), .R(KEY0), .NL(1'b0), .NR(LEDR[8]), .lightOn(LEDR[9]), .playAgain(playAgain));
	
	
	LFSR generate_rand(.clk(clk[clockRate]), .reset(SW[9]), .comp_rand(LFSR_out));
	computerPlayer play(.clk(clk[clockRate]), .reset(SW[9]), .comp_value(LFSR_out), .SW(SW[8:0]), .outValue(cyberPlayer));
	
	check_victory winner (.clk(clk[clockRate]), .reset(SW[9]), .L(KEY3), .R(KEY0), .LED9(LEDR[9]), .LED1(LEDR[1]), .HEX0(HEX0), .HEX5(HEX5), .playAgain(playAgain));

endmodule 

//Testbench for the DE1_SoC

module DE1_SoC_testbench();
	logic CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	integer i;
	initial begin
		CLOCK_50 <= 0;
		forever #(100 / 2)
		CLOCK_50 <= ~CLOCK_50;
	end
	
	initial begin
																			@(posedge CLOCK_50);
		/*check reset true*/											@(posedge CLOCK_50);
		SW[9] <= 1;														@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		/*check reset false*/										@(posedge CLOCK_50);
		SW[9] <= 0;														@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 0; SW[8:0] = '1;					
		repeat(25)  @(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 1;														@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 0;														@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 1;														@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 0; 						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 1;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 0;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 1;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 0;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 1;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 0;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 1;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 0;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 1; 						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 0; 						@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 1;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 0;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		KEY[0] <= 1;							@(posedge CLOCK_50);		
												@(posedge CLOCK_50);
		
		
		SW[9] <= 1;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		SW[9] <= 0;							@(posedge CLOCK_50);
												@(posedge CLOCK_50);
		
		KEY[0] <= 0; SW[8:0] <= 9'b000011111;	
		repeat (100)		@(posedge CLOCK_50);

																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		
		/*check reset true*/											@(posedge CLOCK_50);
		SW[9] <= 1;														@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		/*check reset false*/										@(posedge CLOCK_50);
		SW[9] <= 0;														@(posedge CLOCK_50);

		KEY[0] <= 0; SW[8:0] <= 9'b000111111;	
		repeat (100)													@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);						
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		
		/*check reset true*/											@(posedge CLOCK_50);
		SW[9] <= 1;														@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		/*check reset false*/										@(posedge CLOCK_50);
		SW[9] <= 0;														@(posedge CLOCK_50);

		KEY[0] <= 0; SW[8:0] <= 9'b011111111;	
		repeat (100)		@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		
		/*check reset true*/											@(posedge CLOCK_50);
		SW[9] <= 1;														@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		/*check reset false*/										@(posedge CLOCK_50);
		SW[9] <= 0;														@(posedge CLOCK_50);
		
		KEY[0] <= 0; SW[8:0] <= 9'b111111111;	
		repeat (100)		@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		
		/*check reset true*/											@(posedge CLOCK_50);
		SW[9] <= 1;														@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		/*check reset false*/										@(posedge CLOCK_50);
		SW[9] <= 0;														@(posedge CLOCK_50);
		
		KEY[0] <= 1; SW[8:0] <= 9'b000000000;					@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 0;                                       @(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 1;													@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 0;													@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 0; SW[8:0] <= 9'b011100111;					@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 0; SW[8:0] <= 9'b011100111;					@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 1;													@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 0; SW[8:0] <= 9'b111111111;	
		repeat(20)		@(posedge CLOCK_50);
																			@(posedge CLOCK_50);

		$stop;
	end
endmodule
	