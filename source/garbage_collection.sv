`include "garbage_collection_if.vh"
`include "gc_controller_if.vh"

module garbage_collection(
	input logic CLK, nRST,
	garbage_collection_if.gc gcif
);

	parameter FIFO_SIZE = 16;
	parameter FIFO_SIZE_BIT_NUM = 4;
	block_t [FIFO_SIZE-1:0] fifo, nxt_fifo;
	logic [FIFO_SIZE_BIT_NUM -1:0] clean_num, nxt_clean_num;
	gc_controller_if gccif();
	
	gc_controller gcc (gccif);
	
	always_ff @ (posedge CLK, negedge nRST)
	begin
		if(~nRST)
		begin
			fifo <= 0;
			clean_num <= 0;
		end
		else begin
			fifo <= nxt_fifo;
			clean_num <= nxt_clean_num;
		end
	end
		
	always_comb
	begin
		nxt_fifo = fifo;
		nxt_clean_num = clean_num;
		if(gcif.active_request)
		begin
			nxt_fifo = fifo >> BLOCK_W;
			nxt_clean_num = clean_num - 1;
		end
		else if(gccif.fifo_write_en || gcif.fifo_recover_en)
		begin
			nxt_fifo = fifo & (fifo_in << clean_num * BLOCK_W);
			nxt_clean_num = clean_num + 1;
		end
	end
	
	//gc_controller
	assign gccif.move_done_flag = gcif.move_done_flag;
	assign gccif.gc_ini = gcif.gc_ini;
	assign gccif.gc_start = gcif.gc_start;
	assign gccif.fifo_recover_en = gcif.fifo_recover_en;
	assign gccif.clean_num = clean_num;
	assign gccif.ini_full = ;
	assign gcif.move_flag = gccif.move_flag;
	assign gcif.gc_interrupt = gccif.gc_interrupt;
	assign gcif.gc_request = gccif.gc_reqeust;
	assign gcif.request_done = gccif.request_done;
	
	assign gcif.active_blk = fifo[0];
	assign fifo_in = gccif.initial_fifo ? count_val : (gcif.fifo_recover_en ? recover_blk : erase_blk);
endmodule
