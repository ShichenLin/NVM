`include "garbage_collection_if.vh"

module garbage_collection(
	input logic CLK, nRST,
	garbage_collection_if.gc gcif
);

	parameter FIFO_SIZE = 16;
	parameter FIFO_SIZE_BIT_NUM = 4;
	
	block_t [FIFO_SIZE-1:0] fifo;
	block_t [FIFO_SIZE-1:0] nxt_fifo;
	logic [FIFO_SIZE_BIT_NUM-1:0] clean_num, nxt_clean_num;
	block_t ini_blk_count, nxt_ini_blk_count;
	page_t dirty_page_count [BLOCK_NUM-1:0];
	page_t nxt_dirty_page_count [BLOCK_NUM-1:0];
	
	//intermediate variable
	logic ini_full;
	block_t most_dirty_blk, nxt_most_dirty_blk;
	
	gc_controller_if gccif();
	
	gc_controller gcc (gccif);
	
	always_ff @ (posedge CLK, negedge nRST)
	begin
		if(~nRST)
		begin
			fifo <= 0;
			clean_num <= 0;
			ini_block_num <= 0;
			dirty_page_count <= `{default:`0};
			most_dirty_blk <= 0;
		end
		else begin
			fifo <= nxt_fifo;
			clean_num <= nxt_clean_num;
			ini_blk_count <= nxt_ini_blk_count;
			dirty_page_count <= nxt_dirty_page_count;
			most_dirty_blk <= nxt_most_dirty_blk;
		end
	end
	
	always_comb
	begin
		if(gccif.initial_fifo && ini_blk_count < 1023) nxt_ini_blk_count = ini_blk_count + 1;
		else nxt_ini_blk_count = ini_blk_count;
		nxt_fifo = fifo;
		nxt_clean_num = clean_num;
		nxt_dirty_page_count = dirty_page_count;
		nxt_most_dirty_blk <= most_dirty_blk;
		if(gcif.invalid_flag)
		begin
			nxt_dirty_page_count[gcif.invalid_blk] = dirty_page_count[gcif.invalid_blk] + 1;
			if(dirty_page_count[gcif.invalid_blk] + 1 > dirty_page_count[most_dirty_blk]) nxt_most_dirty_blk = gcif.invalid_blk;
		end
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
	assign gcif.erase_blk = most_dirty_blk;
	assign gcif.active_blk = fifo[0];
	assign gcif.ini_full = ini_blk_count == 1023;
	assign fifo_in = gccif.initial_fifo ? count_val : (gcif.fifo_recover_en ? recover_blk : erase_blk);	
endmodule
