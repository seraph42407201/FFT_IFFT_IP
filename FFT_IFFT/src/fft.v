`timescale 1ns/100ps

// 参数名        默认值  可配置范围	    说明
// TOTAL_STAGE_P    7    3~11          FFT/IFFT阶数
// MULT_OP_DLY_P    2    2,6           乘法器运算时延。
// MULT_WIDTH_P     18   9,18          FFT/IFFT运算数据实部与虚部位宽。

module fft #( parameter 	TOTAL_STAGE_P = 6,
							MULT_OP_DLY_P = 2,
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

	// input iclk;
	// input rst_n;

	// input ien;
	// input [TOTAL_STAGE_P-1:0] iaddr;
	// input [`REAL_WIDTH-1:0] iReal;
	// input [`IMGN_WIDTH-1:0] iImag;

	// output oen;
	// output [TOTAL_STAGE_P-1:0] oaddr;
	// output [`REAL_WIDTH-1:0] oReal;	
	// output [`IMGN_WIDTH-1:0] oImag;	
	
	// wire [CPLX_WIDTH-1:0] idata = {iReal, iImag};
	
	wire en_end;
	wire [TOTAL_STAGE_P-1:0] addr_end;
	wire [CPLX_WIDTH-1:0] data_end;
	
	wire en_w [INTER_MODU_WIRE_NUM:0];
	wire [TOTAL_STAGE_P-1:0] addr_w [INTER_MODU_WIRE_NUM:0];
	wire [CPLX_WIDTH-1:0] data_w [INTER_MODU_WIRE_NUM:0];

	assign en_w[INTER_MODU_WIRE_NUM] = ien;
	assign addr_w[INTER_MODU_WIRE_NUM] = iaddr;
	assign data_w[INTER_MODU_WIRE_NUM] = {iReal, iImag};
	
	generate
		genvar gv_stg;
		genvar gv_index;
		for(gv_stg=TOTAL_STAGE_P; gv_stg>2; gv_stg=gv_stg-2) begin:	stagX
			// gv_index = ((gv_stg-1)/2);
			fft_stageX #( 
				.FFT_STG(gv_stg),
				.TOTAL_STAGE_P(TOTAL_STAGE_P),
				.MULT_OP_DLY(MULT_OP_DLY_P),
				.MULT_WIDTH_P(MULT_WIDTH_P)
			) fft_stageX_inst (
				.iclk(iclk),
				.rst_n(rst_n),
				.iaddr(addr_w[((gv_stg-1)/2)]),
				.idata(data_w[((gv_stg-1)/2)]),
				.ien(en_w[((gv_stg-1)/2)]),
				.oaddr(addr_w[((gv_stg-1)/2)-1]),
				.odata(data_w[((gv_stg-1)/2)-1]),
				.oen(en_w[((gv_stg-1)/2)-1])
			);
		end
		if(TOTAL_STAGE_P%2)
			begin
				fft_stage1 #( 
					.FFT_STG(1),
					.TOTAL_STAGE_P(TOTAL_STAGE_P),
					.MULT_WIDTH_P(MULT_WIDTH_P)
				) stg1_inst (
					.iclk(iclk),
					.rst_n(rst_n),
					.ien(en_w[0]),
					.iaddr(addr_w[0]),
					.idata(data_w[0]),
					.oen(en_end),
					.oaddr(addr_end),
					.odata(data_end)
				);
			end
		else
			begin
 				fft_stage2 stg2_inst (
					.iclk(iclk),
					.rst_n(rst_n),
					.ien(en_w[0]),
					.iaddr(addr_w[0]),
					.idata(data_w[0]),
					.oen(en_end),
					.oaddr(addr_end),
					.odata(data_end)
				); 
			end
	endgenerate

	ftrans1 #(
		.TOTAL_STAGE_P(TOTAL_STAGE_P),
		.MULT_WIDTH_P(MULT_WIDTH_P)
	) ft1 (
		.ien(en_end),
		.iaddr(addr_end),
		.idata(data_end),
		.oen(oen),
		.oaddr(oaddr),
		.odata({oReal, oImag})
	);

endmodule
