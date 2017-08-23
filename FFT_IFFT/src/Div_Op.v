`timescale 1ns/100ps

module Div_Op #( parameter DIV_EXP = 7, MULT_WIDTH = 18 ) (
	input  [MULT_WIDTH-1:0] iReal,
	input  [MULT_WIDTH-1:0] iImag,
	output [MULT_WIDTH-1:0] oReal,
	output [MULT_WIDTH-1:0] oImag
);
	// `include "fft_inc.h"
	
	localparam CMPL_MSB = MULT_WIDTH - 1;		// 17

	assign oReal[CMPL_MSB:0] = { { DIV_EXP { iReal[CMPL_MSB] } }, iReal[CMPL_MSB:DIV_EXP] };
	assign oImag[CMPL_MSB:0] = { { DIV_EXP { iImag[CMPL_MSB] } }, iImag[CMPL_MSB:DIV_EXP] };

endmodule
