`timescale 1ns/100ps

/* 	����������ת���ӵ�matlab����
	clear;
	N = 32; 	% FFT ����
	M = 2^16;   % 18λ���ȡ�

	fid = fopen('cos_data.txt','w');

	for i = 0 : N-1
		j = i + 1;
		a(j) = M*cos(2*pi*i/N);  
		re_s = my_fix_flr_bin(a(j), 18, 0);
		b(j) = -M*sin(2*pi*i/N);
		im_s = my_fix_flr_bin(b(j), 18, 0);
		fprintf(fid, '\t\t\t5\''h%02X: { ore, oim } = { 18\''h%05s, 18\''h%05s };\n', i, dec2hex(bin2dec(re_s)), dec2hex(bin2dec(im_s)));
	end

	fclose(fid);
 */


module ftwiddle11 #( parameter MULT_WIDTH = 18 ) (
	idx,
	ore,
	oim
);
	`include "fft_inc.h"

	input [10:0] idx;
	output reg [MULT_WIDTH-1:0] ore;
	output reg [MULT_WIDTH-1:0] oim;
	
	reg [MULT_WIDTH-1:0] re;
	reg [MULT_WIDTH-1:0] im;
	
	localparam TW_STAGE = 11;
	
	wire [1:0] h_addr = idx[TW_STAGE-1:TW_STAGE-2];
	wire [TW_STAGE-3:0] addr = idx[TW_STAGE-3:0];
	
	always @(*)
	begin
		case(h_addr)
			2'b00: { ore, oim } = #SIM_DLY { re, im };
			2'b01: { ore, oim } = #SIM_DLY { im, -re };
			2'b10: { ore, oim } = #SIM_DLY { -re, -im };
			2'b11: { ore, oim } = #SIM_DLY { -im, re };
			default: { ore, oim } = #SIM_DLY { 18'h10000, 18'h00000 };
		endcase
	end
	
	always @(addr)
	begin
		case(addr)
			9'h000: { re, im } = { 18'h10000, 18'h00000 };
			9'h001: { re, im } = { 18'h0FFFE, 18'h3FF36 };
			9'h002: { re, im } = { 18'h0FFFD, 18'h3FE6D };
			9'h003: { re, im } = { 18'h0FFFC, 18'h3FDA4 };
			9'h004: { re, im } = { 18'h0FFFA, 18'h3FCDB };
			9'h005: { re, im } = { 18'h0FFF7, 18'h3FC12 };
			9'h006: { re, im } = { 18'h0FFF3, 18'h3FB49 };
			9'h007: { re, im } = { 18'h0FFEF, 18'h3FA80 };
			9'h008: { re, im } = { 18'h0FFEB, 18'h3F9B7 };
			9'h009: { re, im } = { 18'h0FFE6, 18'h3F8EE };
			9'h00A: { re, im } = { 18'h0FFE0, 18'h3F825 };
			9'h00B: { re, im } = { 18'h0FFD9, 18'h3F75C };
			9'h00C: { re, im } = { 18'h0FFD2, 18'h3F693 };
			9'h00D: { re, im } = { 18'h0FFCA, 18'h3F5CA };
			9'h00E: { re, im } = { 18'h0FFC2, 18'h3F502 };
			9'h00F: { re, im } = { 18'h0FFB9, 18'h3F439 };
			9'h010: { re, im } = { 18'h0FFB0, 18'h3F370 };
			9'h011: { re, im } = { 18'h0FFA5, 18'h3F2A7 };
			9'h012: { re, im } = { 18'h0FF9B, 18'h3F1DE };
			9'h013: { re, im } = { 18'h0FF8F, 18'h3F116 };
			9'h014: { re, im } = { 18'h0FF83, 18'h3F04D };
			9'h015: { re, im } = { 18'h0FF77, 18'h3EF84 };
			9'h016: { re, im } = { 18'h0FF69, 18'h3EEBC };
			9'h017: { re, im } = { 18'h0FF5B, 18'h3EDF3 };
			9'h018: { re, im } = { 18'h0FF4D, 18'h3ED2A };
			9'h019: { re, im } = { 18'h0FF3E, 18'h3EC62 };
			9'h01A: { re, im } = { 18'h0FF2E, 18'h3EB9A };
			9'h01B: { re, im } = { 18'h0FF1E, 18'h3EAD1 };
			9'h01C: { re, im } = { 18'h0FF0D, 18'h3EA09 };
			9'h01D: { re, im } = { 18'h0FEFB, 18'h3E940 };
			9'h01E: { re, im } = { 18'h0FEE9, 18'h3E878 };
			9'h01F: { re, im } = { 18'h0FED6, 18'h3E7B0 };
			9'h020: { re, im } = { 18'h0FEC3, 18'h3E6E8 };
			9'h021: { re, im } = { 18'h0FEAF, 18'h3E620 };
			9'h022: { re, im } = { 18'h0FE9A, 18'h3E558 };
			9'h023: { re, im } = { 18'h0FE85, 18'h3E490 };
			9'h024: { re, im } = { 18'h0FE6F, 18'h3E3C8 };
			9'h025: { re, im } = { 18'h0FE59, 18'h3E300 };
			9'h026: { re, im } = { 18'h0FE42, 18'h3E239 };
			9'h027: { re, im } = { 18'h0FE2A, 18'h3E171 };
			9'h028: { re, im } = { 18'h0FE12, 18'h3E0A9 };
			9'h029: { re, im } = { 18'h0FDF9, 18'h3DFE2 };
			9'h02A: { re, im } = { 18'h0FDDF, 18'h3DF1A };
			9'h02B: { re, im } = { 18'h0FDC5, 18'h3DE53 };
			9'h02C: { re, im } = { 18'h0FDAA, 18'h3DD8C };
			9'h02D: { re, im } = { 18'h0FD8F, 18'h3DCC5 };
			9'h02E: { re, im } = { 18'h0FD73, 18'h3DBFD };
			9'h02F: { re, im } = { 18'h0FD56, 18'h3DB36 };
			9'h030: { re, im } = { 18'h0FD39, 18'h3DA70 };
			9'h031: { re, im } = { 18'h0FD1B, 18'h3D9A9 };
			9'h032: { re, im } = { 18'h0FCFD, 18'h3D8E2 };
			9'h033: { re, im } = { 18'h0FCDE, 18'h3D81B };
			9'h034: { re, im } = { 18'h0FCBE, 18'h3D755 };
			9'h035: { re, im } = { 18'h0FC9E, 18'h3D68E };
			9'h036: { re, im } = { 18'h0FC7D, 18'h3D5C8 };
			9'h037: { re, im } = { 18'h0FC5C, 18'h3D502 };
			9'h038: { re, im } = { 18'h0FC3A, 18'h3D43C };
			9'h039: { re, im } = { 18'h0FC17, 18'h3D375 };
			9'h03A: { re, im } = { 18'h0FBF4, 18'h3D2B0 };
			9'h03B: { re, im } = { 18'h0FBD0, 18'h3D1EA };
			9'h03C: { re, im } = { 18'h0FBAB, 18'h3D124 };
			9'h03D: { re, im } = { 18'h0FB86, 18'h3D05E };
			9'h03E: { re, im } = { 18'h0FB61, 18'h3CF99 };
			9'h03F: { re, im } = { 18'h0FB3A, 18'h3CED4 };
			9'h040: { re, im } = { 18'h0FB13, 18'h3CE0E };
			9'h041: { re, im } = { 18'h0FAEC, 18'h3CD49 };
			9'h042: { re, im } = { 18'h0FAC4, 18'h3CC84 };
			9'h043: { re, im } = { 18'h0FA9B, 18'h3CBBF };
			9'h044: { re, im } = { 18'h0FA72, 18'h3CAFA };
			9'h045: { re, im } = { 18'h0FA48, 18'h3CA36 };
			9'h046: { re, im } = { 18'h0FA1D, 18'h3C971 };
			9'h047: { re, im } = { 18'h0F9F2, 18'h3C8AD };
			9'h048: { re, im } = { 18'h0F9C6, 18'h3C7E9 };
			9'h049: { re, im } = { 18'h0F99A, 18'h3C725 };
			9'h04A: { re, im } = { 18'h0F96D, 18'h3C661 };
			9'h04B: { re, im } = { 18'h0F93F, 18'h3C59D };
			9'h04C: { re, im } = { 18'h0F911, 18'h3C4D9 };
			9'h04D: { re, im } = { 18'h0F8E2, 18'h3C416 };
			9'h04E: { re, im } = { 18'h0F8B3, 18'h3C352 };
			9'h04F: { re, im } = { 18'h0F883, 18'h3C28F };
			9'h050: { re, im } = { 18'h0F852, 18'h3C1CC };
			9'h051: { re, im } = { 18'h0F821, 18'h3C109 };
			9'h052: { re, im } = { 18'h0F7F0, 18'h3C046 };
			9'h053: { re, im } = { 18'h0F7BD, 18'h3BF83 };
			9'h054: { re, im } = { 18'h0F78A, 18'h3BEC1 };
			9'h055: { re, im } = { 18'h0F757, 18'h3BDFF };
			9'h056: { re, im } = { 18'h0F723, 18'h3BD3C };
			9'h057: { re, im } = { 18'h0F6EE, 18'h3BC7A };
			9'h058: { re, im } = { 18'h0F6B9, 18'h3BBB8 };
			9'h059: { re, im } = { 18'h0F683, 18'h3BAF7 };
			9'h05A: { re, im } = { 18'h0F64C, 18'h3BA35 };
			9'h05B: { re, im } = { 18'h0F615, 18'h3B974 };
			9'h05C: { re, im } = { 18'h0F5DD, 18'h3B8B3 };
			9'h05D: { re, im } = { 18'h0F5A5, 18'h3B7F2 };
			9'h05E: { re, im } = { 18'h0F56C, 18'h3B731 };
			9'h05F: { re, im } = { 18'h0F533, 18'h3B670 };
			9'h060: { re, im } = { 18'h0F4F9, 18'h3B5B0 };
			9'h061: { re, im } = { 18'h0F4BE, 18'h3B4EF };
			9'h062: { re, im } = { 18'h0F483, 18'h3B42F };
			9'h063: { re, im } = { 18'h0F447, 18'h3B36F };
			9'h064: { re, im } = { 18'h0F40A, 18'h3B2B0 };
			9'h065: { re, im } = { 18'h0F3CD, 18'h3B1F0 };
			9'h066: { re, im } = { 18'h0F390, 18'h3B131 };
			9'h067: { re, im } = { 18'h0F352, 18'h3B071 };
			9'h068: { re, im } = { 18'h0F313, 18'h3AFB2 };
			9'h069: { re, im } = { 18'h0F2D3, 18'h3AEF4 };
			9'h06A: { re, im } = { 18'h0F294, 18'h3AE35 };
			9'h06B: { re, im } = { 18'h0F253, 18'h3AD77 };
			9'h06C: { re, im } = { 18'h0F212, 18'h3ACB8 };
			9'h06D: { re, im } = { 18'h0F1D0, 18'h3ABFA };
			9'h06E: { re, im } = { 18'h0F18E, 18'h3AB3C };
			9'h06F: { re, im } = { 18'h0F14B, 18'h3AA7F };
			9'h070: { re, im } = { 18'h0F108, 18'h3A9C1 };
			9'h071: { re, im } = { 18'h0F0C4, 18'h3A904 };
			9'h072: { re, im } = { 18'h0F07F, 18'h3A847 };
			9'h073: { re, im } = { 18'h0F03A, 18'h3A78A };
			9'h074: { re, im } = { 18'h0EFF4, 18'h3A6CE };
			9'h075: { re, im } = { 18'h0EFAE, 18'h3A612 };
			9'h076: { re, im } = { 18'h0EF67, 18'h3A555 };
			9'h077: { re, im } = { 18'h0EF1F, 18'h3A499 };
			9'h078: { re, im } = { 18'h0EED7, 18'h3A3DE };
			9'h079: { re, im } = { 18'h0EE8F, 18'h3A322 };
			9'h07A: { re, im } = { 18'h0EE45, 18'h3A267 };
			9'h07B: { re, im } = { 18'h0EDFC, 18'h3A1AC };
			9'h07C: { re, im } = { 18'h0EDB1, 18'h3A0F1 };
			9'h07D: { re, im } = { 18'h0ED66, 18'h3A037 };
			9'h07E: { re, im } = { 18'h0ED1B, 18'h39F7C };
			9'h07F: { re, im } = { 18'h0ECCF, 18'h39EC2 };
			9'h080: { re, im } = { 18'h0EC82, 18'h39E08 };
			9'h081: { re, im } = { 18'h0EC35, 18'h39D4F };
			9'h082: { re, im } = { 18'h0EBE7, 18'h39C95 };
			9'h083: { re, im } = { 18'h0EB99, 18'h39BDC };
			9'h084: { re, im } = { 18'h0EB4A, 18'h39B23 };
			9'h085: { re, im } = { 18'h0EAFA, 18'h39A6B };
			9'h086: { re, im } = { 18'h0EAAA, 18'h399B2 };
			9'h087: { re, im } = { 18'h0EA59, 18'h398FA };
			9'h088: { re, im } = { 18'h0EA08, 18'h39842 };
			9'h089: { re, im } = { 18'h0E9B6, 18'h3978A };
			9'h08A: { re, im } = { 18'h0E964, 18'h396D3 };
			9'h08B: { re, im } = { 18'h0E911, 18'h3961C };
			9'h08C: { re, im } = { 18'h0E8BE, 18'h39565 };
			9'h08D: { re, im } = { 18'h0E86A, 18'h394AE };
			9'h08E: { re, im } = { 18'h0E815, 18'h393F8 };
			9'h08F: { re, im } = { 18'h0E7C0, 18'h39342 };
			9'h090: { re, im } = { 18'h0E76A, 18'h3928C };
			9'h091: { re, im } = { 18'h0E714, 18'h391D6 };
			9'h092: { re, im } = { 18'h0E6BD, 18'h39121 };
			9'h093: { re, im } = { 18'h0E666, 18'h3906C };
			9'h094: { re, im } = { 18'h0E60E, 18'h38FB7 };
			9'h095: { re, im } = { 18'h0E5B6, 18'h38F02 };
			9'h096: { re, im } = { 18'h0E55D, 18'h38E4E };
			9'h097: { re, im } = { 18'h0E503, 18'h38D9A };
			9'h098: { re, im } = { 18'h0E4A9, 18'h38CE6 };
			9'h099: { re, im } = { 18'h0E44E, 18'h38C33 };
			9'h09A: { re, im } = { 18'h0E3F3, 18'h38B80 };
			9'h09B: { re, im } = { 18'h0E397, 18'h38ACD };
			9'h09C: { re, im } = { 18'h0E33B, 18'h38A1A };
			9'h09D: { re, im } = { 18'h0E2DE, 18'h38968 };
			9'h09E: { re, im } = { 18'h0E281, 18'h388B6 };
			9'h09F: { re, im } = { 18'h0E223, 18'h38804 };
			9'h0A0: { re, im } = { 18'h0E1C4, 18'h38753 };
			9'h0A1: { re, im } = { 18'h0E165, 18'h386A1 };
			9'h0A2: { re, im } = { 18'h0E106, 18'h385F0 };
			9'h0A3: { re, im } = { 18'h0E0A5, 18'h38540 };
			9'h0A4: { re, im } = { 18'h0E045, 18'h38490 };
			9'h0A5: { re, im } = { 18'h0DFE4, 18'h383E0 };
			9'h0A6: { re, im } = { 18'h0DF82, 18'h38330 };
			9'h0A7: { re, im } = { 18'h0DF1F, 18'h38281 };
			9'h0A8: { re, im } = { 18'h0DEBD, 18'h381D1 };
			9'h0A9: { re, im } = { 18'h0DE59, 18'h38123 };
			9'h0AA: { re, im } = { 18'h0DDF5, 18'h38074 };
			9'h0AB: { re, im } = { 18'h0DD91, 18'h37FC6 };
			9'h0AC: { re, im } = { 18'h0DD2C, 18'h37F18 };
			9'h0AD: { re, im } = { 18'h0DCC6, 18'h37E6B };
			9'h0AE: { re, im } = { 18'h0DC60, 18'h37DBD };
			9'h0AF: { re, im } = { 18'h0DBFA, 18'h37D10 };
			9'h0B0: { re, im } = { 18'h0DB93, 18'h37C64 };
			9'h0B1: { re, im } = { 18'h0DB2B, 18'h37BB7 };
			9'h0B2: { re, im } = { 18'h0DAC3, 18'h37B0C };
			9'h0B3: { re, im } = { 18'h0DA5A, 18'h37A60 };
			9'h0B4: { re, im } = { 18'h0D9F1, 18'h379B5 };
			9'h0B5: { re, im } = { 18'h0D987, 18'h3790A };
			9'h0B6: { re, im } = { 18'h0D91D, 18'h3785F };
			9'h0B7: { re, im } = { 18'h0D8B2, 18'h377B4 };
			9'h0B8: { re, im } = { 18'h0D847, 18'h3770A };
			9'h0B9: { re, im } = { 18'h0D7DB, 18'h37661 };
			9'h0BA: { re, im } = { 18'h0D76F, 18'h375B7 };
			9'h0BB: { re, im } = { 18'h0D702, 18'h3750E };
			9'h0BC: { re, im } = { 18'h0D695, 18'h37466 };
			9'h0BD: { re, im } = { 18'h0D627, 18'h373BD };
			9'h0BE: { re, im } = { 18'h0D5B8, 18'h37315 };
			9'h0BF: { re, im } = { 18'h0D549, 18'h3726E };
			9'h0C0: { re, im } = { 18'h0D4DA, 18'h371C6 };
			9'h0C1: { re, im } = { 18'h0D46A, 18'h3711F };
			9'h0C2: { re, im } = { 18'h0D3F9, 18'h37079 };
			9'h0C3: { re, im } = { 18'h0D388, 18'h36FD2 };
			9'h0C4: { re, im } = { 18'h0D317, 18'h36F2C };
			9'h0C5: { re, im } = { 18'h0D2A5, 18'h36E87 };
			9'h0C6: { re, im } = { 18'h0D232, 18'h36DE1 };
			9'h0C7: { re, im } = { 18'h0D1BF, 18'h36D3C };
			9'h0C8: { re, im } = { 18'h0D14C, 18'h36C98 };
			9'h0C9: { re, im } = { 18'h0D0D8, 18'h36BF4 };
			9'h0CA: { re, im } = { 18'h0D063, 18'h36B50 };
			9'h0CB: { re, im } = { 18'h0CFEE, 18'h36AAC };
			9'h0CC: { re, im } = { 18'h0CF79, 18'h36A09 };
			9'h0CD: { re, im } = { 18'h0CF03, 18'h36966 };
			9'h0CE: { re, im } = { 18'h0CE8C, 18'h368C4 };
			9'h0CF: { re, im } = { 18'h0CE15, 18'h36822 };
			9'h0D0: { re, im } = { 18'h0CD9E, 18'h36780 };
			9'h0D1: { re, im } = { 18'h0CD26, 18'h366DF };
			9'h0D2: { re, im } = { 18'h0CCAD, 18'h3663E };
			9'h0D3: { re, im } = { 18'h0CC34, 18'h3659E };
			9'h0D4: { re, im } = { 18'h0CBBB, 18'h364FD };
			9'h0D5: { re, im } = { 18'h0CB41, 18'h3645E };
			9'h0D6: { re, im } = { 18'h0CAC6, 18'h363BE };
			9'h0D7: { re, im } = { 18'h0CA4B, 18'h3631F };
			9'h0D8: { re, im } = { 18'h0C9D0, 18'h36280 };
			9'h0D9: { re, im } = { 18'h0C954, 18'h361E2 };
			9'h0DA: { re, im } = { 18'h0C8D7, 18'h36144 };
			9'h0DB: { re, im } = { 18'h0C85B, 18'h360A7 };
			9'h0DC: { re, im } = { 18'h0C7DD, 18'h36009 };
			9'h0DD: { re, im } = { 18'h0C75F, 18'h35F6D };
			9'h0DE: { re, im } = { 18'h0C6E1, 18'h35ED0 };
			9'h0DF: { re, im } = { 18'h0C662, 18'h35E34 };
			9'h0E0: { re, im } = { 18'h0C5E3, 18'h35D99 };
			9'h0E1: { re, im } = { 18'h0C563, 18'h35CFD };
			9'h0E2: { re, im } = { 18'h0C4E3, 18'h35C62 };
			9'h0E3: { re, im } = { 18'h0C462, 18'h35BC8 };
			9'h0E4: { re, im } = { 18'h0C3E1, 18'h35B2E };
			9'h0E5: { re, im } = { 18'h0C35F, 18'h35A94 };
			9'h0E6: { re, im } = { 18'h0C2DD, 18'h359FB };
			9'h0E7: { re, im } = { 18'h0C25A, 18'h35962 };
			9'h0E8: { re, im } = { 18'h0C1D7, 18'h358CA };
			9'h0E9: { re, im } = { 18'h0C154, 18'h35832 };
			9'h0EA: { re, im } = { 18'h0C0D0, 18'h3579A };
			9'h0EB: { re, im } = { 18'h0C04B, 18'h35703 };
			9'h0EC: { re, im } = { 18'h0BFC6, 18'h3566C };
			9'h0ED: { re, im } = { 18'h0BF41, 18'h355D6 };
			9'h0EE: { re, im } = { 18'h0BEBB, 18'h35540 };
			9'h0EF: { re, im } = { 18'h0BE35, 18'h354AA };
			9'h0F0: { re, im } = { 18'h0BDAE, 18'h35415 };
			9'h0F1: { re, im } = { 18'h0BD26, 18'h35380 };
			9'h0F2: { re, im } = { 18'h0BC9F, 18'h352EC };
			9'h0F3: { re, im } = { 18'h0BC17, 18'h35258 };
			9'h0F4: { re, im } = { 18'h0BB8E, 18'h351C4 };
			9'h0F5: { re, im } = { 18'h0BB05, 18'h35131 };
			9'h0F6: { re, im } = { 18'h0BA7B, 18'h3509F };
			9'h0F7: { re, im } = { 18'h0B9F1, 18'h3500C };
			9'h0F8: { re, im } = { 18'h0B967, 18'h34F7A };
			9'h0F9: { re, im } = { 18'h0B8DC, 18'h34EE9 };
			9'h0FA: { re, im } = { 18'h0B851, 18'h34E58 };
			9'h0FB: { re, im } = { 18'h0B7C5, 18'h34DC8 };
			9'h0FC: { re, im } = { 18'h0B739, 18'h34D37 };
			9'h0FD: { re, im } = { 18'h0B6AC, 18'h34CA8 };
			9'h0FE: { re, im } = { 18'h0B61F, 18'h34C18 };
			9'h0FF: { re, im } = { 18'h0B592, 18'h34B8A };
			9'h100: { re, im } = { 18'h0B504, 18'h34AFB };
			9'h101: { re, im } = { 18'h0B475, 18'h34A6D };
			9'h102: { re, im } = { 18'h0B3E7, 18'h349E0 };
			9'h103: { re, im } = { 18'h0B357, 18'h34953 };
			9'h104: { re, im } = { 18'h0B2C8, 18'h348C6 };
			9'h105: { re, im } = { 18'h0B237, 18'h3483A };
			9'h106: { re, im } = { 18'h0B1A7, 18'h347AE };
			9'h107: { re, im } = { 18'h0B116, 18'h34723 };
			9'h108: { re, im } = { 18'h0B085, 18'h34698 };
			9'h109: { re, im } = { 18'h0AFF3, 18'h3460E };
			9'h10A: { re, im } = { 18'h0AF60, 18'h34584 };
			9'h10B: { re, im } = { 18'h0AECE, 18'h344FA };
			9'h10C: { re, im } = { 18'h0AE3B, 18'h34471 };
			9'h10D: { re, im } = { 18'h0ADA7, 18'h343E8 };
			9'h10E: { re, im } = { 18'h0AD13, 18'h34360 };
			9'h10F: { re, im } = { 18'h0AC7F, 18'h342D9 };
			9'h110: { re, im } = { 18'h0ABEA, 18'h34251 };
			9'h111: { re, im } = { 18'h0AB55, 18'h341CA };
			9'h112: { re, im } = { 18'h0AABF, 18'h34144 };
			9'h113: { re, im } = { 18'h0AA29, 18'h340BE };
			9'h114: { re, im } = { 18'h0A993, 18'h34039 };
			9'h115: { re, im } = { 18'h0A8FC, 18'h33FB4 };
			9'h116: { re, im } = { 18'h0A865, 18'h33F2F };
			9'h117: { re, im } = { 18'h0A7CD, 18'h33EAB };
			9'h118: { re, im } = { 18'h0A735, 18'h33E28 };
			9'h119: { re, im } = { 18'h0A69D, 18'h33DA5 };
			9'h11A: { re, im } = { 18'h0A604, 18'h33D22 };
			9'h11B: { re, im } = { 18'h0A56B, 18'h33CA0 };
			9'h11C: { re, im } = { 18'h0A4D1, 18'h33C1E };
			9'h11D: { re, im } = { 18'h0A437, 18'h33B9D };
			9'h11E: { re, im } = { 18'h0A39D, 18'h33B1C };
			9'h11F: { re, im } = { 18'h0A302, 18'h33A9C };
			9'h120: { re, im } = { 18'h0A266, 18'h33A1C };
			9'h121: { re, im } = { 18'h0A1CB, 18'h3399D };
			9'h122: { re, im } = { 18'h0A12F, 18'h3391E };
			9'h123: { re, im } = { 18'h0A092, 18'h338A0 };
			9'h124: { re, im } = { 18'h09FF6, 18'h33822 };
			9'h125: { re, im } = { 18'h09F58, 18'h337A4 };
			9'h126: { re, im } = { 18'h09EBB, 18'h33728 };
			9'h127: { re, im } = { 18'h09E1D, 18'h336AB };
			9'h128: { re, im } = { 18'h09D7F, 18'h3362F };
			9'h129: { re, im } = { 18'h09CE0, 18'h335B4 };
			9'h12A: { re, im } = { 18'h09C41, 18'h33539 };
			9'h12B: { re, im } = { 18'h09BA1, 18'h334BE };
			9'h12C: { re, im } = { 18'h09B02, 18'h33444 };
			9'h12D: { re, im } = { 18'h09A61, 18'h333CB };
			9'h12E: { re, im } = { 18'h099C1, 18'h33352 };
			9'h12F: { re, im } = { 18'h09920, 18'h332D9 };
			9'h130: { re, im } = { 18'h0987F, 18'h33261 };
			9'h131: { re, im } = { 18'h097DD, 18'h331EA };
			9'h132: { re, im } = { 18'h0973B, 18'h33173 };
			9'h133: { re, im } = { 18'h09699, 18'h330FC };
			9'h134: { re, im } = { 18'h095F6, 18'h33086 };
			9'h135: { re, im } = { 18'h09553, 18'h33011 };
			9'h136: { re, im } = { 18'h094AF, 18'h32F9C };
			9'h137: { re, im } = { 18'h0940B, 18'h32F27 };
			9'h138: { re, im } = { 18'h09367, 18'h32EB3 };
			9'h139: { re, im } = { 18'h092C3, 18'h32E40 };
			9'h13A: { re, im } = { 18'h0921E, 18'h32DCD };
			9'h13B: { re, im } = { 18'h09178, 18'h32D5A };
			9'h13C: { re, im } = { 18'h090D3, 18'h32CE8 };
			9'h13D: { re, im } = { 18'h0902D, 18'h32C77 };
			9'h13E: { re, im } = { 18'h08F86, 18'h32C06 };
			9'h13F: { re, im } = { 18'h08EE0, 18'h32B95 };
			9'h140: { re, im } = { 18'h08E39, 18'h32B25 };
			9'h141: { re, im } = { 18'h08D91, 18'h32AB6 };
			9'h142: { re, im } = { 18'h08CEA, 18'h32A47 };
			9'h143: { re, im } = { 18'h08C42, 18'h329D8 };
			9'h144: { re, im } = { 18'h08B99, 18'h3296A };
			9'h145: { re, im } = { 18'h08AF1, 18'h328FD };
			9'h146: { re, im } = { 18'h08A48, 18'h32890 };
			9'h147: { re, im } = { 18'h0899E, 18'h32824 };
			9'h148: { re, im } = { 18'h088F5, 18'h327B8 };
			9'h149: { re, im } = { 18'h0884B, 18'h3274D };
			9'h14A: { re, im } = { 18'h087A0, 18'h326E2 };
			9'h14B: { re, im } = { 18'h086F5, 18'h32678 };
			9'h14C: { re, im } = { 18'h0864A, 18'h3260E };
			9'h14D: { re, im } = { 18'h0859F, 18'h325A5 };
			9'h14E: { re, im } = { 18'h084F3, 18'h3253C };
			9'h14F: { re, im } = { 18'h08448, 18'h324D4 };
			9'h150: { re, im } = { 18'h0839B, 18'h3246C };
			9'h151: { re, im } = { 18'h082EF, 18'h32405 };
			9'h152: { re, im } = { 18'h08242, 18'h3239F };
			9'h153: { re, im } = { 18'h08194, 18'h32339 };
			9'h154: { re, im } = { 18'h080E7, 18'h322D3 };
			9'h155: { re, im } = { 18'h08039, 18'h3226E };
			9'h156: { re, im } = { 18'h07F8B, 18'h3220A };
			9'h157: { re, im } = { 18'h07EDC, 18'h321A6 };
			9'h158: { re, im } = { 18'h07E2E, 18'h32142 };
			9'h159: { re, im } = { 18'h07D7E, 18'h320E0 };
			9'h15A: { re, im } = { 18'h07CCF, 18'h3207D };
			9'h15B: { re, im } = { 18'h07C1F, 18'h3201B };
			9'h15C: { re, im } = { 18'h07B6F, 18'h31FBA };
			9'h15D: { re, im } = { 18'h07ABF, 18'h31F5A };
			9'h15E: { re, im } = { 18'h07A0F, 18'h31EF9 };
			9'h15F: { re, im } = { 18'h0795E, 18'h31E9A };
			9'h160: { re, im } = { 18'h078AC, 18'h31E3B };
			9'h161: { re, im } = { 18'h077FB, 18'h31DDC };
			9'h162: { re, im } = { 18'h07749, 18'h31D7E };
			9'h163: { re, im } = { 18'h07697, 18'h31D21 };
			9'h164: { re, im } = { 18'h075E5, 18'h31CC4 };
			9'h165: { re, im } = { 18'h07532, 18'h31C68 };
			9'h166: { re, im } = { 18'h0747F, 18'h31C0C };
			9'h167: { re, im } = { 18'h073CC, 18'h31BB1 };
			9'h168: { re, im } = { 18'h07319, 18'h31B56 };
			9'h169: { re, im } = { 18'h07265, 18'h31AFC };
			9'h16A: { re, im } = { 18'h071B1, 18'h31AA2 };
			9'h16B: { re, im } = { 18'h070FD, 18'h31A49 };
			9'h16C: { re, im } = { 18'h07048, 18'h319F1 };
			9'h16D: { re, im } = { 18'h06F93, 18'h31999 };
			9'h16E: { re, im } = { 18'h06EDE, 18'h31942 };
			9'h16F: { re, im } = { 18'h06E29, 18'h318EB };
			9'h170: { re, im } = { 18'h06D73, 18'h31895 };
			9'h171: { re, im } = { 18'h06CBD, 18'h3183F };
			9'h172: { re, im } = { 18'h06C07, 18'h317EA };
			9'h173: { re, im } = { 18'h06B51, 18'h31795 };
			9'h174: { re, im } = { 18'h06A9A, 18'h31741 };
			9'h175: { re, im } = { 18'h069E3, 18'h316EE };
			9'h176: { re, im } = { 18'h0692C, 18'h3169B };
			9'h177: { re, im } = { 18'h06875, 18'h31649 };
			9'h178: { re, im } = { 18'h067BD, 18'h315F7 };
			9'h179: { re, im } = { 18'h06705, 18'h315A6 };
			9'h17A: { re, im } = { 18'h0664D, 18'h31555 };
			9'h17B: { re, im } = { 18'h06594, 18'h31505 };
			9'h17C: { re, im } = { 18'h064DC, 18'h314B5 };
			9'h17D: { re, im } = { 18'h06423, 18'h31466 };
			9'h17E: { re, im } = { 18'h0636A, 18'h31418 };
			9'h17F: { re, im } = { 18'h062B0, 18'h313CA };
			9'h180: { re, im } = { 18'h061F7, 18'h3137D };
			9'h181: { re, im } = { 18'h0613D, 18'h31330 };
			9'h182: { re, im } = { 18'h06083, 18'h312E4 };
			9'h183: { re, im } = { 18'h05FC8, 18'h31299 };
			9'h184: { re, im } = { 18'h05F0E, 18'h3124E };
			9'h185: { re, im } = { 18'h05E53, 18'h31203 };
			9'h186: { re, im } = { 18'h05D98, 18'h311BA };
			9'h187: { re, im } = { 18'h05CDD, 18'h31170 };
			9'h188: { re, im } = { 18'h05C21, 18'h31128 };
			9'h189: { re, im } = { 18'h05B66, 18'h310E0 };
			9'h18A: { re, im } = { 18'h05AAA, 18'h31098 };
			9'h18B: { re, im } = { 18'h059ED, 18'h31051 };
			9'h18C: { re, im } = { 18'h05931, 18'h3100B };
			9'h18D: { re, im } = { 18'h05875, 18'h30FC5 };
			9'h18E: { re, im } = { 18'h057B8, 18'h30F80 };
			9'h18F: { re, im } = { 18'h056FB, 18'h30F3B };
			9'h190: { re, im } = { 18'h0563E, 18'h30EF7 };
			9'h191: { re, im } = { 18'h05580, 18'h30EB4 };
			9'h192: { re, im } = { 18'h054C3, 18'h30E71 };
			9'h193: { re, im } = { 18'h05405, 18'h30E2F };
			9'h194: { re, im } = { 18'h05347, 18'h30DED };
			9'h195: { re, im } = { 18'h05288, 18'h30DAC };
			9'h196: { re, im } = { 18'h051CA, 18'h30D6B };
			9'h197: { re, im } = { 18'h0510B, 18'h30D2C };
			9'h198: { re, im } = { 18'h0504D, 18'h30CEC };
			9'h199: { re, im } = { 18'h04F8E, 18'h30CAD };
			9'h19A: { re, im } = { 18'h04ECE, 18'h30C6F };
			9'h19B: { re, im } = { 18'h04E0F, 18'h30C32 };
			9'h19C: { re, im } = { 18'h04D4F, 18'h30BF5 };
			9'h19D: { re, im } = { 18'h04C90, 18'h30BB8 };
			9'h19E: { re, im } = { 18'h04BD0, 18'h30B7C };
			9'h19F: { re, im } = { 18'h04B10, 18'h30B41 };
			9'h1A0: { re, im } = { 18'h04A4F, 18'h30B06 };
			9'h1A1: { re, im } = { 18'h0498F, 18'h30ACC };
			9'h1A2: { re, im } = { 18'h048CE, 18'h30A93 };
			9'h1A3: { re, im } = { 18'h0480D, 18'h30A5A };
			9'h1A4: { re, im } = { 18'h0474C, 18'h30A22 };
			9'h1A5: { re, im } = { 18'h0468B, 18'h309EA };
			9'h1A6: { re, im } = { 18'h045CA, 18'h309B3 };
			9'h1A7: { re, im } = { 18'h04508, 18'h3097C };
			9'h1A8: { re, im } = { 18'h04447, 18'h30946 };
			9'h1A9: { re, im } = { 18'h04385, 18'h30911 };
			9'h1AA: { re, im } = { 18'h042C3, 18'h308DC };
			9'h1AB: { re, im } = { 18'h04200, 18'h308A8 };
			9'h1AC: { re, im } = { 18'h0413E, 18'h30875 };
			9'h1AD: { re, im } = { 18'h0407C, 18'h30842 };
			9'h1AE: { re, im } = { 18'h03FB9, 18'h3080F };
			9'h1AF: { re, im } = { 18'h03EF6, 18'h307DE };
			9'h1B0: { re, im } = { 18'h03E33, 18'h307AD };
			9'h1B1: { re, im } = { 18'h03D70, 18'h3077C };
			9'h1B2: { re, im } = { 18'h03CAD, 18'h3074C };
			9'h1B3: { re, im } = { 18'h03BE9, 18'h3071D };
			9'h1B4: { re, im } = { 18'h03B26, 18'h306EE };
			9'h1B5: { re, im } = { 18'h03A62, 18'h306C0 };
			9'h1B6: { re, im } = { 18'h0399E, 18'h30692 };
			9'h1B7: { re, im } = { 18'h038DA, 18'h30665 };
			9'h1B8: { re, im } = { 18'h03816, 18'h30639 };
			9'h1B9: { re, im } = { 18'h03752, 18'h3060D };
			9'h1BA: { re, im } = { 18'h0368E, 18'h305E2 };
			9'h1BB: { re, im } = { 18'h035C9, 18'h305B7 };
			9'h1BC: { re, im } = { 18'h03505, 18'h3058D };
			9'h1BD: { re, im } = { 18'h03440, 18'h30564 };
			9'h1BE: { re, im } = { 18'h0337B, 18'h3053B };
			9'h1BF: { re, im } = { 18'h032B6, 18'h30513 };
			9'h1C0: { re, im } = { 18'h031F1, 18'h304EC };
			9'h1C1: { re, im } = { 18'h0312B, 18'h304C5 };
			9'h1C2: { re, im } = { 18'h03066, 18'h3049E };
			9'h1C3: { re, im } = { 18'h02FA1, 18'h30479 };
			9'h1C4: { re, im } = { 18'h02EDB, 18'h30454 };
			9'h1C5: { re, im } = { 18'h02E15, 18'h3042F };
			9'h1C6: { re, im } = { 18'h02D4F, 18'h3040B };
			9'h1C7: { re, im } = { 18'h02C8A, 18'h303E8 };
			9'h1C8: { re, im } = { 18'h02BC3, 18'h303C5 };
			9'h1C9: { re, im } = { 18'h02AFD, 18'h303A3 };
			9'h1CA: { re, im } = { 18'h02A37, 18'h30382 };
			9'h1CB: { re, im } = { 18'h02971, 18'h30361 };
			9'h1CC: { re, im } = { 18'h028AA, 18'h30341 };
			9'h1CD: { re, im } = { 18'h027E4, 18'h30321 };
			9'h1CE: { re, im } = { 18'h0271D, 18'h30302 };
			9'h1CF: { re, im } = { 18'h02656, 18'h302E4 };
			9'h1D0: { re, im } = { 18'h0258F, 18'h302C6 };
			9'h1D1: { re, im } = { 18'h024C9, 18'h302A9 };
			9'h1D2: { re, im } = { 18'h02402, 18'h3028C };
			9'h1D3: { re, im } = { 18'h0233A, 18'h30270 };
			9'h1D4: { re, im } = { 18'h02273, 18'h30255 };
			9'h1D5: { re, im } = { 18'h021AC, 18'h3023A };
			9'h1D6: { re, im } = { 18'h020E5, 18'h30220 };
			9'h1D7: { re, im } = { 18'h0201D, 18'h30206 };
			9'h1D8: { re, im } = { 18'h01F56, 18'h301ED };
			9'h1D9: { re, im } = { 18'h01E8E, 18'h301D5 };
			9'h1DA: { re, im } = { 18'h01DC6, 18'h301BD };
			9'h1DB: { re, im } = { 18'h01CFF, 18'h301A6 };
			9'h1DC: { re, im } = { 18'h01C37, 18'h30190 };
			9'h1DD: { re, im } = { 18'h01B6F, 18'h3017A };
			9'h1DE: { re, im } = { 18'h01AA7, 18'h30165 };
			9'h1DF: { re, im } = { 18'h019DF, 18'h30150 };
			9'h1E0: { re, im } = { 18'h01917, 18'h3013C };
			9'h1E1: { re, im } = { 18'h0184F, 18'h30129 };
			9'h1E2: { re, im } = { 18'h01787, 18'h30116 };
			9'h1E3: { re, im } = { 18'h016BF, 18'h30104 };
			9'h1E4: { re, im } = { 18'h015F6, 18'h300F2 };
			9'h1E5: { re, im } = { 18'h0152E, 18'h300E1 };
			9'h1E6: { re, im } = { 18'h01465, 18'h300D1 };
			9'h1E7: { re, im } = { 18'h0139D, 18'h300C1 };
			9'h1E8: { re, im } = { 18'h012D5, 18'h300B2 };
			9'h1E9: { re, im } = { 18'h0120C, 18'h300A4 };
			9'h1EA: { re, im } = { 18'h01143, 18'h30096 };
			9'h1EB: { re, im } = { 18'h0107B, 18'h30088 };
			9'h1EC: { re, im } = { 18'h00FB2, 18'h3007C };
			9'h1ED: { re, im } = { 18'h00EE9, 18'h30070 };
			9'h1EE: { re, im } = { 18'h00E21, 18'h30064 };
			9'h1EF: { re, im } = { 18'h00D58, 18'h3005A };
			9'h1F0: { re, im } = { 18'h00C8F, 18'h3004F };
			9'h1F1: { re, im } = { 18'h00BC6, 18'h30046 };
			9'h1F2: { re, im } = { 18'h00AFD, 18'h3003D };
			9'h1F3: { re, im } = { 18'h00A35, 18'h30035 };
			9'h1F4: { re, im } = { 18'h0096C, 18'h3002D };
			9'h1F5: { re, im } = { 18'h008A3, 18'h30026 };
			9'h1F6: { re, im } = { 18'h007DA, 18'h3001F };
			9'h1F7: { re, im } = { 18'h00711, 18'h30019 };
			9'h1F8: { re, im } = { 18'h00648, 18'h30014 };
			9'h1F9: { re, im } = { 18'h0057F, 18'h30010 };
			9'h1FA: { re, im } = { 18'h004B6, 18'h3000C };
			9'h1FB: { re, im } = { 18'h003ED, 18'h30008 };
			9'h1FC: { re, im } = { 18'h00324, 18'h30005 };
			9'h1FD: { re, im } = { 18'h0025B, 18'h30003 };
			9'h1FE: { re, im } = { 18'h00192, 18'h30002 };
			9'h1FF: { re, im } = { 18'h000C9, 18'h30001 };
			default: { re, im } = { 18'h10000, 18'h00000 };
		endcase
	end

endmodule