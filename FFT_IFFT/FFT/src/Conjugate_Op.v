`timescale 1ns/100ps

module conjugate_Op (
	idata,
	odata
);
	`include "fft_inc.h"
	
	input [`CPLX_WIDTH-1:0] idata;
	output [`CPLX_WIDTH-1:0] odata;
	
	assign odata = { idata[REAL_MSB:REAL_LSB], -idata[IMGN_MSB:IMGN_LSB] };

endmodule
