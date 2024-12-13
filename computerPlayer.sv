module computerPlayer (clk, reset, comp_value, SW, outValue);
	output logic outValue;
	input logic clk;
	input logic reset;
	input logic [9:0] comp_value;
	input logic [8:0] SW;
	
	logic [9:0] SW_concate;
	
	assign SW_concate = {1'b0, SW};
	
	comparator computerMove (.clk, .reset, .A(SW_concate), .B(comp_value), .out(outValue));
endmodule

module computerPlayer_testbench();
	logic outValue;
	logic clk;
	logic reset;
	logic [9:0] comp_value;
	logic [8:0] SW;
	logic [9:0] SW_concate;
	
	computerPlayer dut(.clk, .reset, .comp_value, .SW, .outValue);
	
	initial begin
		clk <= 0;
		forever #(50)
		clk <= ~clk;
	end
	
	initial begin
		reset <= 1;													@(posedge clk);
																		@(posedge clk);
		reset <= 0; 												@(posedge clk);
																		@(posedge clk);
		comp_value = 10'b0000000001; SW = 9'b00000010; 	@(posedge clk);
																		@(posedge clk);
		comp_value = 10'b0000000011;						 	@(posedge clk);
																		@(posedge clk);
		$stop;
	end
endmodule 