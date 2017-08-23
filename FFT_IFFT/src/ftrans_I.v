`timescale 1ns/100ps

module ftrans_I #( parameter 	FFT_STG = 12,
								TOTAL_STAGE_P = 10,
								MULT_WIDTH_P = 18 ) (
	input iclk,
	input ien,
	input [TOTAL_STAGE_P-1:0] iaddr,
	input [2*MULT_WIDTH_P-1:0] idata,
	output reg oen,
	output reg [TOTAL_STAGE_P-1:0] oaddr,
	output reg [2*MULT_WIDTH_P-1:0] odata
);
	`include "fft_inc.h"

	localparam REAL_MSB = 2*MULT_WIDTH_P-1;		// 35
	localparam REAL_LSB = MULT_WIDTH_P;			// 18
	localparam IMGN_MSB = MULT_WIDTH_P - 1;		// 17
	localparam IMGN_LSB = 0;					// 0

	wire k1 = iaddr[FFT_STG-1];
	wire k2 = iaddr[FFT_STG-2];
	
	always @(posedge iclk)
	begin
		if({k1, k2} == 2'b11)
			begin
				odata[REAL_MSB:REAL_LSB] <= #SIM_DLY idata[IMGN_MSB:IMGN_LSB];
				odata[IMGN_MSB:IMGN_LSB] <= #SIM_DLY -idata[REAL_MSB:REAL_LSB];
			end
		else odata <= #SIM_DLY idata;
		
		oaddr <= #SIM_DLY iaddr;
		oen <= #SIM_DLY ien;
	end

endmodule