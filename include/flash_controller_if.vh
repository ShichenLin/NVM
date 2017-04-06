`ifndef FLASH_CONTROLLER_IF_VH
`define FLASH_CONTROLLER_IF_VH

interface flash_controller_if;
	//soc interface
	logic reg_change;
	logic [4:0] reg_num, request;
	logic [2:0] AHB_mode;
	block_t offset, length, write_permission;
	mode_t system_mode,;
	//garbage collection
	logic gc_request, gc_interrupt, req_done, gc_start, gc_ini;
	//remapping table
	logic error, update, done
	mode_t;
	//flash interface
	block_t W_used;
	logic R_full;
	mode_t flash_mode, ;
	
	modport fc (
		input reg_num, request, reg_change, AHB_mode, offset, length, //soc interface
		      gc_request, gc_interrupt, req_done, //garbage collection
		      error, update, done, //remapping table
		      W_used, R_full, flash_mode //flash interface
		output system_mode, write_permission, //soc interface
		       gc_start, gc_ini, //garbage collection
		       //flash interface
	);
endinterface

`endif
