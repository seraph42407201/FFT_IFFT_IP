
// This module is IFFT, based on FFT
//   
//     Input -> conjugate -> fft_stageX -> ... -> fft_stage1
//     -> conjugate -> divN
//     -> Output

`timescale 1ns/100ps

// 参数名        默认值  可配置范围	    说明
// TOTAL_STAGE_P    7   3~11            FFT/IFFT阶数
// DIV_EXP          TOTAL_STAGE_P       IFFT末尾数据处理。
// MULT_OP_DLY_P    2   2,6             乘法器运算时延。
// MULT_WIDTH_P     18  9,18            FFT/IFFT运算数据实部与虚部位宽。

module ifft #( parameter 	TOTAL_STAGE_P = 10,
							DIV_EXP = TOTAL_STAGE_P,
							MULT_OP_DLY_P = 2,
							MULT_WIDTH_P = 18 ) (
	input iclk, 
	input rst_n,
	input ien,
	input [TOTAL_STAGE_P-1:0] iaddr,
	input [MULT_WIDTH_P-1:0]  iReal,
	input [MULT_WIDTH_P-1:0]  iImag,
	output reg oen,
	output reg [TOTAL_STAGE_P-1:0] oaddr,
	output reg [MULT_WIDTH_P-1:0]  oReal,
	output reg [MULT_WIDTH_P-1:0]  oImag
);
	// `include "fft_inc.h"
	
	localparam CPLX_WIDTH = 2*MULT_WIDTH_P;
	localparam INTER_MODU_WIRE_NUM = ((TOTAL_STAGE_P-1)/2);
	
	wire en_end;
	wire [TOTAL_STAGE_P-1:0] addr_end;
	wire [CPLX_WIDTH-1:0] data_end;
	
	wire [MULT_WIDTH_P-1:0] Real_w;	
	wire [MULT_WIDTH_P-1:0] Imag_w;	

	// 末端处理：共轭->除去N->输出。
	wire en_e;
	wire [TOTAL_STAGE_P-1:0] addr_e;
	wire [MULT_WIDTH_P-1:0] real_f;
	wire [MULT_WIDTH_P-1:0] imag_f;
	wire [MULT_WIDTH_P-1:0] real_g;
	wire [MULT_WIDTH_P-1:0] imag_g;
	wire [MULT_WIDTH_P-1:0] Real_e;	
	wire [MULT_WIDTH_P-1:0] Imag_e;	
	
	conjugate_Op #( 
		.MULT_WIDTH(MULT_WIDTH_P)
	) conjugate_inst (
		.iReal(iReal),
		.iImag(iImag),
		.oReal(Real_w),
		.oImag(Imag_w)
	);
	
	fft #( 
		.TOTAL_STAGE_P(TOTAL_STAGE_P),
		.MULT_OP_DLY_P(MULT_OP_DLY_P),
		.MULT_WIDTH_P(MULT_WIDTH_P)
	) fft_ins (
		.iclk(iclk),
		.rst_n(rst_n),
		.ien(ien),
		.iaddr(iaddr),
		.iReal(Real_w),
		.iImag(Imag_w),
		.oen(en_e),
		.oaddr(addr_e),
		.oReal(Real_e),
		.oImag(Imag_e)
	);
	

	conjugate_Op #( 
		.MULT_WIDTH(MULT_WIDTH_P)
	) conjugate_inst1 (
		.iReal(Real_e),
		.iImag(Imag_e),
		.oReal(real_f),
		.oImag(imag_f)
	);
	
	Div_Op #( 
		.DIV_EXP(DIV_EXP),
		.MULT_WIDTH(MULT_WIDTH_P)
	) div_inst (
		.iReal(real_f),
		.iImag(imag_f),
		.oReal(real_g),
		.oImag(imag_g)
	);
	
	always @(posedge iclk)
	begin
		oen = en_e;
		oaddr = addr_e;
		oReal = real_g;
		oImag = imag_g;
	end

endmodule
