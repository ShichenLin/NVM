`ifndef SOC_INTERFACE_IF_VH
`define SOC_INTERFACE_IF_VH

interface SOC_interface_if;
	word_t haddr, hwdata, hrdata;
	logic hwrite, hready, hresp, hsel_s2;
	logic [2:0] hsize;
	logic [3:0] hport;
	//overall controller
	logic reg_change;
	block_t write_permission, offset, length;
	mode_t system_mode;
	logic [3:0] request, reg_num;
	logic [2:0] AHB_mode;
	//remapping table
	logic page_enable;
	flash_addr_t ;
	//flash interface
	word_t W_data, R_data
	block_t CSR_offset, CSR_length;
	logic W_enable, W_full, R_enable, R_empty;
	
	modport si (
		input hadr, hsize, hport, hwdata, hwrite, hsel_s2,
		      system_mode, write_permission, //overall controller
		      page_enable, //remapping table
		      W_full, R_data, R_empty,
		output hrdata, hready, hresp,
		       reqeust, reg_num, AHB_mode, offset, length, //overall controller
		       //remapping table
		       W_data, w_enable, CSR_offset, CSR_length, R_enable //flash interface
	);
endinterface

`endif
