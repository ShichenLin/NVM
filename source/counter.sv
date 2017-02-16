module counter(
	input logic CLK, nRST,
	input logic count_en, count_clear,
	input logic [BIT_NUM-1:0] rollover_val,
	output logic [BIT_NUM-1:0] count_val,
	output logic rollover_flag,
);

	parameter BIT_NUM = 4;
	logic [BIT_NUM-1:0] nxt_count;
	logic nxt_flag;
	
	always_ff @ (posedge CLK, negedge nRST)
	begin
		if(~nRST)
		begin
			count_val <= 0;
			rollver_flag <= 0;
		end
		else if(count_clear)
		begin
			count_val <= 0;
			rollver_flag <= 0;
		end
		else begin
			count_val <= nxt_count;
			rollver_flag <= nxt_flag;
		end
	end
	
	always_comb
	begin
		nxt_count = count_val;
		nxt_flag = rollover_flag;
		if(count_en)
		begin
			nxt_count = count_val + 1;
			if(count_val == rollover_val)
				nxt_count = 0;
			else if(count_val == rollover_val - 1)
				nxt_flag = 1;
		end
	end
endmodule
