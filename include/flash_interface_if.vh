`ifndef FLASH_INTERFACE_IF_VH
`define FLASH_INTERFACE_IF_VH

interface flash_interface_if;
	logic CE, WE, RE, ALE, CLE, WP, RB;
	byte_t data;
	//overall controller
	logic R_full;
	block_t W_used;
	logic [3:0]
	//remapping table
	logic update_done, update_enable, get_next_addr;
	flash_addr_t update_addr, addr
	//soc interface
	logic W_full, R_empty, W_enable, R_enable;
	word_t W_data, R_data;
	block_t CSR_offset, CSR_length;
	modport fi (
		input data
		      update_done, update_enable, //remapping table
		      //overall controller
		      W_data, W_enable, CSR_offset, CSR_length, R_enable, //soc interface
		output CE, WE, RE, ALE, CLE, WP, RB,
		       get_next_addr, //remapping table
		       W_used, R_full, flash_mode //overall controller
		       W_full, R_data, R_empty
	);
endinterface

`endif
