`timescale 1ns/100ps

// 参数名       默认值  可配置范围   说明
// FFT_IFFT_P       1   0,1     1：FFT；0：IFFT
// TOTAL_STAGE_P    7   3~11    FFT/IFFT阶数
// MULT_OP_DLY_P    2   2,6     乘法器运算时延。
// MULT_WIDTH_P     18  9,18    FFT/IFFT运算数据实部与虚部位宽。

module FFT_IFFT #( parameter 	FFT_IFFT_P = 1, 
								TOTAL_STAGE_P = 6,
								DIV_EXP = TOTAL_STAGE_P,
								MULT_OP_DLY_P = 6,
								MULT_WIDTH_P = 18 ) (
	input iclk, 
	input rst_n,
	
	input ien,
	input [TOTAL_STAGE_P-1:0] iaddr,
	input [MULT_WIDTH_P-1:0]  iReal,
	input [MULT_WIDTH_P-1:0]  iImag,

	output oen,
	output [TOTAL_STAGE_P-1:0] oaddr,
	output [MULT_WIDTH_P-1:0]  oReal,
	output [MULT_WIDTH_P-1:0]  oImag
);
	// `include "fft_inc.h"
	
	localparam CPLX_WIDTH = 2*MULT_WIDTH_P;
	localparam INTER_MODU_WIRE_NUM = ((TOTAL_STAGE_P-1)/2);
	
	generate
		if(1==FFT_IFFT_P)
			fft #( 
				.TOTAL_STAGE_P(TOTAL_STAGE_P),
				.MULT_OP_DLY_P(MULT_OP_DLY_P),
				.MULT_WIDTH_P(MULT_WIDTH_P)
			) fft_ins (
				.iclk(iclk),
				.rst_n(rst_n),
				.ien(ien),
				.iaddr(iaddr),
				.iReal(iReal),
				.iImag(iImag),
				.oen(oen),
				.oaddr(oaddr),
				.oReal(oReal),
				.oImag(oImag)
			);
		else
			ifft #( 
				.TOTAL_STAGE_P(TOTAL_STAGE_P),
				.DIV_EXP(DIV_EXP),
				.MULT_OP_DLY_P(MULT_OP_DLY_P),
				.MULT_WIDTH_P(MULT_WIDTH_P)
			) fft_ins (
				.iclk(iclk),
				.rst_n(rst_n),
				.ien(ien),
				.iaddr(iaddr),
				.iReal(iReal),
				.iImag(iImag),
				.oen(oen),
				.oaddr(oaddr),
				.oReal(oReal),
				.oImag(oImag)
			);
	endgenerate

endmodule
