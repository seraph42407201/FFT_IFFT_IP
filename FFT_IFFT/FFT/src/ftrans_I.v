`timescale 1ns/100ps

module ftrans_I 
#( parameter FFT_STG = 7 )
(
	iclk,
	iaddr,
	idata,
	ien,
	
	oaddr,
	odata,
	oen
);
	`include "fft_inc.h"

	input iclk;
	input [`TOTAL_STAGE-1:0] iaddr;
	input [`CPLX_WIDTH-1:0] idata;
	input ien;
	output reg [`TOTAL_STAGE-1:0] oaddr;
	output reg [`CPLX_WIDTH-1:0] odata;
	output reg oen;

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
