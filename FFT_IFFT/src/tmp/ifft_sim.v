`timescale 1ns/100ps

module ifft_sim();
	
	`include "fft_inc.h"
	
	localparam FFT_STAGE = 10;
	localparam MULT_OP_DLY_P = 2;
	localparam MULT_WIDTH_P = 18;
	localparam FFT_MAX = 1<<FFT_STAGE;
	localparam IEN_TIME = FFT_MAX*20+3;
	
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
	
	initial
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
		#112 ien = 1'b1;
		#IEN_TIME ien = 1'b0;
	end
	
	integer index = 0;
	initial
	begin
		iaddr = 0;
		$readmemh("real.vec", Ireal_r);
		$readmemh("imag.vec", Iimag_r);
		#92 for(index=0; index<FFT_MAX; index=index+1)
		begin
			#20 iReal = Ireal_r[index];
				iImag = Iimag_r[index];
			iaddr <= index;
		end
	end
	
	
	integer w_file;
    initial w_file = $fopen("data_out.txt");
    always @(oaddr)
    begin
        $fdisplay(w_file, "%d   %d    %d", oaddr, $signed(oReal), $signed(oImag));
    end
	
	
	ifft #( 
		.TOTAL_STAGE_P(FFT_STAGE),
		.MULT_OP_DLY_P(MULT_OP_DLY_P),
		.MULT_WIDTH_P(MULT_WIDTH_P)
	) ifft_ins (
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