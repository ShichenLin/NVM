`ifndef GARBAGE_COLLECTION_IF_VH
`define GARBAGE_COLLECTION_IF_VH

`include "NVM_pkg.vh"

interface garbage_collection_if();
	logic fifo_recover_en;
	block_t erase_blk, invalid_blk, active_blk;
	logic move_flag, invalid_flag, move_done_flag;
	logic gc_ini, gc_start;
	logic gc_interrupt, gc_request, req_done;
	logic active_request;
	block_t recover_blk, 
	modport gc (
		input 	invalid_blk, invalid_flag, active_request, move_done_flag, //inputs from remapping table block
			  		gc_start, gc_ini, //inputs from overalll controller
			  		recover_blk, fifo_recover_en //fifo input
		output 	gc_interrupt, gc_request, req_done, //outputs to overall controller
					erase_blk, active_blk, move_flag //outputs to remapping table block
					free_blk
	);
endinterface

`endif
