`ifndef REMAPPING_TABLE_IF_VH
`define REMAPPING_TABLE_IF_VH

/*
	Shichen Lin
	Remapping table interface
*/

`include "NVM_pkg.vh"
import NVM_pkg::*;

interface remapping_table_if;
	
	//garbage collection
	logic invalid_flag, ative_request, move_done_flag, move_flag;
	block_t invalid_blk, erase_blk, active_blk;
	//flash interfacce
	logic get_nxt_addr, update_enable, update_done;
	flash_addr_t update_addr, flash_addr;
	//overall controller
	logic error, update, done;
	virtual_addr_t virtual_addr;
	 page_used;
	//soc interface
	logic page_enable;
	
	//buffer
	virtual_addr_t buffer_in, buffer_out;
	logic buffer_ren, buffer_wen;
	//counter
	virtual_addr_t counter_addr;
	
	modport rt (
		input  erase_blk, active_blk, move_flag, //inputs from garbage collection
			   
		output 
	);
endinterface

`endif
