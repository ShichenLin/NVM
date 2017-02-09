`ifndef NVM_PKG_VH
`define NVM_PKG_VH

package nvm_pkg();
	parameter WORD_W = 32;
	parameter ADDR_W = 16;
	parameter BLOCK_W = 10;
	parameter PAGE_W = 6;
	parameter AHB_MODE_W = 3;
	parameter FLASH_MODE_W = 4;
	parameter SYSTEM_MODE_W = 4;

	typedef logic [7:0] byte_t;
	typedef logic [WORD-1:0] word_t;
	typedef logic [ADDR_W-1:0] addr_t;
	typedef logic [BLOCK_W-1:0] block_t;
	typedef logic [PAGE_W-1:0] page_t;
endpackage

`endif
