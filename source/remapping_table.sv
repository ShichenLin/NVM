/*
	Shichen Lin
	Remapping table
*/

`include "remapping_table_if.vh"

module remapping_table(
	input logic CLK, nRST,
	remapping_table_if.rt rtif
);

	always_ff @ (posedge CLK, negedge nRST)
	begin
		if(~nRST)
		
		else
	end
	
	always_comb
	begin
	
	end
endmodule
