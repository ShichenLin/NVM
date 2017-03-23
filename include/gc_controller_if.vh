interface gc_controller_if;
	parameter FIFO_SIZE_BIT_NUM = 4;
	logic gc_ini, gc_start;
	logic move_done_flag, move_flag;
	logic gc_interrupt, gc_request, request_done;
	logic request_blk_clean;
	logic inital_fifo, fifo_recover_en, fifo_write_en;
	logic ini_full;
	logic [FIFO_SIZE_BIT_NUM-1:0] clean_num;
	
	modport gcc (
		input gc_ini, gc_start, move_done_flag, fifo_recover_en, clean_num, ini_full,
		output move_flag, gc_interrupt, gc_request, request_done, request_blk_clean, initial_fifo, fifo_write_en
	);
endinterface
