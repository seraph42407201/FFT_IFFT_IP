`timescale 1ns/100ps

module BF_op #( parameter MULT_WIDTH = 18 ) (
	input  [2*MULT_WIDTH-1:0] ia,
	input  [2*MULT_WIDTH-1:0] ib,
	output [2*MULT_WIDTH-1:0] oa,
	output [2*MULT_WIDTH-1:0] ob
);
	// `include "fft_inc.h"
	
	localparam REAL_MSB = 2*MULT_WIDTH-1;		// 35
	localparam REAL_LSB = MULT_WIDTH;			// 18
	localparam IMGN_MSB = MULT_WIDTH - 1;		// 17
	localparam IMGN_LSB = 0;					// 0

	assign oa[REAL_MSB:REAL_LSB] = ia[REAL_MSB:REAL_LSB] + ib[REAL_MSB:REAL_LSB];
	assign oa[IMGN_MSB:IMGN_LSB] = ia[IMGN_MSB:IMGN_LSB] + ib[IMGN_MSB:IMGN_LSB];

	assign ob[REAL_MSB:REAL_LSB] = ia[REAL_MSB:REAL_LSB] - ib[REAL_MSB:REAL_LSB];
	assign ob[IMGN_MSB:IMGN_LSB] = ia[IMGN_MSB:IMGN_LSB] - ib[IMGN_MSB:IMGN_LSB];

endmodule
