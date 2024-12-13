module centerLight (clk, reset, L, R, NL, NR, lightOn, playAgain);
	output logic lightOn;
	input logic clk;
	input logic reset;
	input logic L, R, NL, NR, playAgain;
	
	enum {on, off} ps, ns;
	
	always_comb begin
		case(ps)
		
			on: if(~R & L | R & ~L) ns = off;
				 else ns = on;
				 
			
			off: if(NR & ~R & L | NL & ~L & R) ns = on;
				  else ns = off;
		
		endcase
	end
	
	always_comb begin 
		case(ps)
			on: lightOn = 1;
			
			off: lightOn = 0;
			
		endcase
	end
	
	always_ff @(posedge clk) begin
		if(reset | playAgain)
			ps <= on;
			
		else
			ps <= ns;
		
	end
endmodule

module centerLight_testbench();
	logic lightOn;
	logic clk;
	logic reset;
	logic L, R, NL, NR, playAgain;
	
	centerLight dut(.clk, .reset, .L, .R, .NL, .NR, .lightOn, .playAgain);
	
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
		
		R <= 0; L <= 1; NL <= 0; NR <= 1;			@(posedge clk)
																@(posedge clk)
																@(posedge clk)
																
		NL <= 1; NR <= 0;									@(posedge clk)
																@(posedge clk)
																@(posedge clk)
		R <= 1; L <= 0; 									@(posedge clk)
																@(posedge clk)
																@(posedge clk)

		
		NL <= 0; NR <= 1;									@(posedge clk)
																@(posedge clk)
																@(posedge clk)
																

		L<= 1; NL <= 0; NR <= 1;						@(posedge clk)
																@(posedge clk)
																@(posedge clk)
																@(posedge clk)
		reset <= 1;											@(posedge clk)
																@(posedge clk)
		
		R <= 1; L <= 0; NL <= 1; NR <= 0;         @(posedge clk)
																@(posedge clk)
																@(posedge clk)
																@(posedge clk)
		R <= 0; L <= 1; NL <= 0; NR <= 0;         @(posedge clk)
																@(posedge clk)
																@(posedge clk)
																@(posedge clk)
		R <= 1; L <= 0; NL <= 0; NR <= 0;         @(posedge clk)
																@(posedge clk)
																@(posedge clk)
																@(posedge clk)
		

		$stop;
	end
endmodule 