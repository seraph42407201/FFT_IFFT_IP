`timescale 1ns/100ps

module BF_stgX #( parameter 	FFT_STG = 12,
								TOTAL_STAGE_P = 10,
								MULT_WIDTH_P = 18 ) (
	input iclk,
	input rst_n,
	input ien,
	input [TOTAL_STAGE_P-1:0] iaddr,
	input [2*MULT_WIDTH_P-1:0] idata,
	output reg oen,
	output reg [TOTAL_STAGE_P-1:0] oaddr,
	output reg [2*MULT_WIDTH_P-1:0] odata
);
	`include "fft_inc.h"
	
	localparam TOTAL_ADDR_MAX 	= { TOTAL_STAGE_P { 1'b1 } };
	localparam STG_MAX			= { FFT_STG { 1'b1 } };
	localparam STG_HALFMAX		= ( STG_MAX >> 1 );

	localparam CPLX_WIDTH = 2*MULT_WIDTH_P;

	wire [CPLX_WIDTH-1 : 0] bf_ia;
	wire [CPLX_WIDTH-1 : 0] bf_ib;
	wire [CPLX_WIDTH-1 : 0] bf_oa;
	wire [CPLX_WIDTH-1 : 0] bf_ob;

	wire is_load;
	wire is_calc;
	wire with_dump;
	reg dump = 0;
	reg [FFT_STG-2:0] dump_cnt = 0;

	reg [CPLX_WIDTH-1 : 0] r [STG_HALFMAX : 0];

	wire [CPLX_WIDTH-1 : 0] wdata_in;
	wire [FFT_STG-2 : 0] waddr_in;
	wire wen_in;

	reg [CPLX_WIDTH-1 : 0] rdata = 0;
	reg [CPLX_WIDTH-1 : 0] rdata_out = 0;
	wire [FFT_STG-2 : 0] raddr_in;


	assign is_load = ~iaddr[FFT_STG-1];	// iaddr[FFT_STG-1:0] <= STG_HALFMAX;		// is_load = ~iaddr[FFT_STG-1];
	assign is_calc = iaddr[FFT_STG-1]; 	// iaddr[FFT_STG-1:0] > STG_HALFMAX;		// is_calc = iaddr[FFT_STG-1];

	// for sync-ram: registered write port, unregistered read port
	always @(posedge iclk)
	begin
		if(wen_in) r[waddr_in] <= #SIM_DLY  wdata_in;
		rdata_out <= #SIM_DLY r[raddr_in];
	end
	always @(posedge iclk)
	begin
		rdata <= #SIM_DLY rdata_out;
	end

	//    ram wr sigal
	assign waddr_in = iaddr[FFT_STG-2:0];
	assign wdata_in = is_load ? idata : bf_ob;
	assign wen_in = ien;
	//    ram rd signal
	assign raddr_in = (with_dump ? dump_cnt : iaddr[FFT_STG-2:0]) + 2'b10;

	// bufferfly
	assign bf_ia = rdata;
	assign bf_ib = idata;

	always @(posedge iclk)
	begin
		if(is_calc & ien) // actually started
		begin
			odata <= #SIM_DLY bf_oa;
			oaddr <= #SIM_DLY oaddr + 1'b1;
			oen <= #SIM_DLY 1'b1;
		end
		else if((is_load | ~ien) & with_dump)
		begin
			odata <= #SIM_DLY rdata;
			oaddr <= #SIM_DLY oaddr + 1'b1;
			oen <= #SIM_DLY 1'b1;
		end
		else // input address is big, but is not writing
		begin
			odata <= #SIM_DLY 0;
			oaddr <= #SIM_DLY  TOTAL_ADDR_MAX;
			oen <= #SIM_DLY 1'b0;
		end
	end

	always @(posedge iclk)
	begin
		if(iaddr[FFT_STG-1:0] == STG_MAX && ien)
		begin
			dump <= #SIM_DLY 1'b1;
			dump_cnt <= #SIM_DLY 0;
		end
		else if(dump)
		begin
			if(dump_cnt == STG_HALFMAX) dump <= #SIM_DLY 1'b0;
			dump_cnt <= #SIM_DLY dump_cnt + 1'b1;
		end
	end

	assign with_dump = dump;

	BF_op #(
		.MULT_WIDTH(MULT_WIDTH_P)
	) bf0 (
		.ia(bf_ia),
		.ib(bf_ib),
		.oa(bf_oa),		// ia + ib
		.ob(bf_ob)		// ia - ib
	);

endmodule
