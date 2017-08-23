`timescale 1ns/100ps

module fft_ifft_sim();
	`include "fft_inc.h"
	
	localparam FFT_IFFT_P = 1;
	localparam FFT_STAGE = 10;
	localparam DIV_EXP = FFT_STAGE;
	localparam MULT_OP_DLY_P = 6;
	localparam MULT_WIDTH_P = 18;
	localparam FFT_MAX = 1<<FFT_STAGE;
	localparam IEN_TIME = FFT_MAX*20;
	
	reg iclk;
	reg rst_n;
	reg [FFT_STAGE-1:0] iaddr;
	reg [MULT_WIDTH_P-1:0] iReal = 0;
	reg [MULT_WIDTH_P-1:0] iImag = 0;
	reg ien;
	wire [MULT_WIDTH_P-1:0] oReal;
	wire [MULT_WIDTH_P-1:0] oImag;
	wire [FFT_STAGE-1:0] oaddr;
	wire oen;
	reg [MULT_WIDTH_P-1:0] Ireal_r [FFT_MAX-1:0];
	reg [MULT_WIDTH_P-1:0] Iimag_r [FFT_MAX-1:0];
	
	initial			// 初始化时钟和复位信号
	begin
		rst_n <= 1;
		iclk <= 0;
		rst_n <= #20 0;
		
		forever
			#10 iclk = ~iclk;
	end
	
	initial
	begin
		ien = 1'b0;
		#1112 ien = 1'b1;
		#IEN_TIME ien = 1'b0;
		
		repeat(20) begin
			#100 ien = 1'b1;
			#IEN_TIME ien = 1'b0;
		end
	end
	
	integer index = 0;
	initial
	begin
		iaddr = 0;
		$readmemh("real.vec", Ireal_r);
		$readmemh("imag.vec", Iimag_r);
		#1092 for(index=0; index<FFT_MAX; index=index+1)
		begin
			#20 
				iaddr <= index;
				iReal <= Ireal_r[index];
				iImag <= Iimag_r[index];
				// iReal <= $random % 65535;    // Ireal_r[index];
				// iImag <= $random % 65535;    // Iimag_r[index];
				// iReal <= $realtobits($itor($random(index) % 65535))[MULT_WIDTH_P-1:0];    // Ireal_r[index];
				// iImag <= $realtobits($itor($random(index) % 65535))[MULT_WIDTH_P-1:0];    // Iimag_r[index];
		end
		
		repeat(20) begin
			#100 for(index=0; index<FFT_MAX; index=index+1) begin
				#20 
					iaddr <= index;
					iReal <= Ireal_r[index];
					iImag <= Iimag_r[index];
					// iReal <= $random % 65535;    // Ireal_r[index];
					// iImag <= $random % 65535;    // Iimag_r[index];
			end
		end
	end
	
	integer w_file;
    initial w_file = $fopen("data_out.txt");
    always @(oaddr)
    begin
        $fdisplay(w_file, "%d   %d    %d", oaddr, $signed(oReal), $signed(oImag));
    end
	
	FFT_IFFT #( 
		.FFT_IFFT_P(FFT_IFFT_P),
		.TOTAL_STAGE_P(FFT_STAGE),
		.DIV_EXP(DIV_EXP),
		.MULT_OP_DLY_P(MULT_OP_DLY_P),
		.MULT_WIDTH_P(MULT_WIDTH_P)
	) fft_ifft_ins (
		.iclk(iclk),
		.rst_n(rst_n),
		.iaddr(iaddr),
		.iReal(iReal),
		.iImag(iImag),
		.ien(ien),
		.oReal(oReal),
		.oImag(oImag),
		.oaddr(oaddr),
		.oen(oen)
	);
endmodule
