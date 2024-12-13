module check_victory(clk, reset, L, R, LED9, LED1, HEX0);
	output logic HEX0;
	input logic reset;
	input logic clk;
	input logic L, R, LED9, LED1;
	
	enum {curr_play, winner1, winner2} ps, ns;
	
	always_comb begin 
		case(ps)
		
			curr_play: if(L & ~R & LED9) ns = winner1;
						  else if(~L & R & LED1) ns = winner2;
						  else ns = curr_play;
			endcase
		end

	always_ff @(posedge clk) begin
		if(reset)
			ps <= winner1;
			
		else
			ps <= ns;
		
	end
endmodule
		