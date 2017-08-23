`timescale 1ns/100ps

module ftrans1 #( parameter TOTAL_STAGE_P = 10,
							MULT_WIDTH_P = 18 ) (
	input  ien,
	input  [TOTAL_STAGE_P-1:0]  iaddr,
	input  [2*MULT_WIDTH_P-1:0] idata,
	output oen,
	output [TOTAL_STAGE_P-1:0]  oaddr,
	output [2*MULT_WIDTH_P-1:0] odata
);

	// `include "fft_inc.h"

	assign odata = idata;
	assign oen = ien;
	
	generate	// bit_reverse
		genvar index;
		for(index=0; index<TOTAL_STAGE_P; index=index+1) begin: bit_reverse
			assign oaddr[TOTAL_STAGE_P-index-1] = iaddr[index];
		end
	endgenerate

endmodule
