`timescale 1ns/100ps

module fft_stage2 #( parameter 	TOTAL_STAGE_P = 10,
								MULT_WIDTH_P = 18 ) (
	input iclk,
	input rst_n,
	input ien,
	input [TOTAL_STAGE_P-1:0] iaddr,
	input [2*MULT_WIDTH_P-1:0] idata,
	output oen,
	output [TOTAL_STAGE_P-1:0] oaddr,
	output [2*MULT_WIDTH_P-1:0] odata
);
	`include "fft_inc.h"
	
	localparam CPLX_WIDTH = 2*MULT_WIDTH_P;

	wire bfX_oen;
	wire [TOTAL_STAGE_P-1:0] bfX_oaddr;
	wire [CPLX_WIDTH-1:0] bfX_odata;
	wire Trans_I_oen;
	wire [TOTAL_STAGE_P-1:0] Trans_I_oaddr;
	wire [CPLX_WIDTH-1:0] Trans_I_odata;
	
	fft_stage1 #( 
		.FFT_STG(2),
		.TOTAL_STAGE_P(TOTAL_STAGE_P),
		.MULT_WIDTH_P(MULT_WIDTH_P)
	) fft_stg1_inst2 (
		.iclk(iclk),
		.rst_n(rst_n),
		.ien(ien),
		.iaddr(iaddr),
		.idata(idata),
		.oen(bfX_oen),
		.oaddr(bfX_oaddr),
		.odata(bfX_odata)
	);
	
	ftrans_I #( 
		.FFT_STG(2),
		.TOTAL_STAGE_P(TOTAL_STAGE_P),
		.MULT_WIDTH_P(MULT_WIDTH_P)
	) ftrans_I_inst (
		.iclk(iclk),
		.ien(bfX_oen),
		.iaddr(bfX_oaddr),
		.idata(bfX_odata),
		.oen(Trans_I_oen),
		.oaddr(Trans_I_oaddr),
		.odata(Trans_I_odata)
	);
	
	fft_stage1 #( 
		.FFT_STG(1),
		.TOTAL_STAGE_P(TOTAL_STAGE_P),
		.MULT_WIDTH_P(MULT_WIDTH_P)
	) fft_stg1_inst1 (
		.iclk(iclk),
		.rst_n(rst_n),
		.ien(Trans_I_oen),
		.iaddr(Trans_I_oaddr),
		.idata(Trans_I_odata),
		.oen(oen),
		.oaddr(oaddr),
		.odata(odata)
	);

endmodule
