module LFSR(clk, reset, comp_rand);
	output logic [9:0] comp_rand;
	input logic clk;
	input logic reset;
	
	logic output_xnor;
	
	assign output_xnor = (comp_rand[0] ~^ comp_rand[3]); //10 & 7 used for 10 bit
	
	always_ff @(posedge clk) begin 
		if(reset) comp_rand <= 10'b0000000000;
		
		else comp_rand <= {output_xnor, comp_rand[9: 1]};
		
	end
endmodule

module LFSR_testbench ();

	logic [10:0] comp_rand;
	logic clk;
	logic reset;
	logic output_xnor;
	
	LSFR dut(.clk(clk), .reset(reset), .comp_rand(comp_rand));
	
	initial begin 
		clk <= 0;
		forever #(50)
		clk <= ~clk;
	end
	
	initial begin
		reset <= 1;                   @(posedge clk);
												@(posedge clk);
		reset <= 0;                   @(posedge clk);
		                              @(posedge clk);
				                        @(posedge clk);
												@(posedge clk);
		                              @(posedge clk);
		                              @(posedge clk);
		                              @(posedge clk);
		                              @(posedge clk);
		                              @(posedge clk);
		                              @(posedge clk);
		$stop;
	end
endmodule		