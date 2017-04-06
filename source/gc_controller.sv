/*
	Shichen Lin
	Garbage collection controller
*/

`include "gc_controller_if.vh"

module gc_controller(
	input logic CLK, nRST
	gc_controller_if.gcc gccif
);
	
	gc_state_t state, nxtstate;
	
	always_ff @ (posedge CLK, negedge nRST)
	begin
		if(~nRST)
			state <= 0;
		else
			state <= nxtstate;
	end
	
	always_comb
	begin
		nxtstate = IDLE;
		gccif.move_flag = 0;
		gccif.gc_interrupt = 0;
		gccif.gc_request = 0;
		gccif.request_done = 0;
		gccif.request_blk_clean = 0;
		gccif.initial_fifo = 0;
		gccif.fifo_write-en = 0;
		casez(state)
			IDLE: begin
				if(gccif.clean_num < GC_THRESHOLD) gccif.gc_request = 1;
				if(gccif.clean_num == 1 && ~gccif.fifo_recover_en && ~gccif.gc_ini && ~gccif.gc_start) nxtstate = INTERRUPT
				else if(gccif.gc_ini) nxtstate = INI;
				else if(gccif.gc_start) nxtstate = MOVE_START;
			end
			INTERRUPT: begin
				gccif.gc_interrupt = 1;
				if(gccif.gc_start) nxtstate = MOVE_START;
				else nxtstate = INTERRUPT;
			end
			INI: begin
				gccif.initial_fifo = 1;
				gccif.fifo_write-en = 1;
				if(gccif.ini_full) nxtstate = INI_DONE;
				else nxtstate = INI;
			end
			INI_DONE: begin
			end
			MOVE_START: begin
				gccif.move_flag = 1;
				if(gccif.move_done_flag) nxtstate = FINISH
				else nxtstate = MOVE_START;
			end
			FINISH: begin
				gccif.request_done = 1;
				gccif.request_blk_clean = 1;
				gccif.fifo_write_en = 1;
			end
		endcase
	end
endmodule
