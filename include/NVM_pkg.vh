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
	parameter BLOCK_NUM = 1024; //2^BLOCK_W
	parameter PAGE_NUM = 64; //2^PAGE_W
	typedef logic [7:0] byte_t;
	typedef logic [WORD-1:0] word_t;
	typedef logic [ADDR_W-1:0] addr_t;
	typedef logic [BLOCK_W-1:0] block_t;
	typedef logic [PAGE_W-1:0] page_t;
	
	//garbage collection
	parameter GC_THRESHOLD = ;
	typedef enum logic [3:0] {
		IDLE = 4'd0,
		INTERRUPT = 4'd1,
		INI = 4'd2,
		INI_DONE = 4'b3,
		MOVE_START = 4'd4,
		FINISH = 4'd5
	} gc_state_t;
endpackage

`endif
