`timescale 1ns/100ps

module conjugate_Op #( parameter MULT_WIDTH = 18 ) (
	input  [MULT_WIDTH-1:0] iReal,
	input  [MULT_WIDTH-1:0] iImag,
	output [MULT_WIDTH-1:0] oReal,
	output [MULT_WIDTH-1:0] oImag
);
	// `include "fft_inc.h"
	
	assign oReal = iReal;
	assign oImag = -iImag;

endmodule
