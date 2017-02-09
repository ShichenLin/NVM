`ifndef GARBAGE_COLLECTION_IF_VH
`define GARBAGE_COLLECTION_IF_VH

`include "NVM_pkg.vh"

interface garbage_collection_if();
	logic recover_en;
	block_t erase_blk_num, invalid_blk_num, active_blk_num;
	logic move_flag, invalid_flag, move_done_flag;
	logic gc_ini, gc_start;
	logic gc_interrupt, gc_request, req_done;
	logic new_active_request;
	modport gc (
		input 	invalid_blk_num, invalid_flag, new_active_request, move_done_flag, //inputs from remapping table block
			  	gc_start, gc_ini, //inputs from overalll controller
		output 	gc_interrupt, gc_request, req_done, //outputs to overall controller
				erase_blk_num, active_blk_num, move_flag //outputs to remapping table block
	);
endinterface

`endif
