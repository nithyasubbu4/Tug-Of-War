module comparator (clk, reset, A, B, out);
	output logic out;
	input logic clk;
	input logic reset;
	input logic [9:0] A, B;
	
	logic comp_value;
	
	always_comb begin
		comp_value = (A > B);
		
	end
	
	
	always_ff @(posedge clk) begin
		out <= comp_value;
	end
endmodule 

module comparator_testbench ();
	logic out;
	logic clk;
	logic reset;
	logic [9:0] A, B;
	
	comparator dut(.clk, .reset, .A, .B, .out);
	
		
	initial begin 
		clk <= 0;
		forever #(50)
		clk <= ~clk;
	end
	
	initial begin
		reset <= 1;             							@(posedge clk);
																	@(posedge clk);
		reset <= 0; 											@(posedge clk);
																	@(posedge clk);
		A <= 10'b0001000111; B <= 10'b0010110000; 	@(posedge clk); //A= 71, B= 176
																	@(posedge clk);
		B <= 10'b0000100111;									@(posedge clk); //B = 39
																	@(posedge clk);
		$stop;
	end
endmodule

