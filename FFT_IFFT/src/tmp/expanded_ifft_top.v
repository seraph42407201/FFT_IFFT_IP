module expanded_ifft_top(
pf_re,
pf_im,
pf_index,
pf_en,

ifft_oaddr,
ifft_ore,
ifft_oim,
ifft_oen,

iclk,
rst_n
);
`include "FFT.h"
input [OREAL_WIDTH-1:0] pf_re;
input [OIMGN_WIDTH-1:0] pf_im;
input [IFFT_STAGE-1:0] pf_index;
input pf_en;

output [OREAL_WIDTH-1:0] ifft_ore;
output [OIMGN_WIDTH-1:0] ifft_oim;
output [IFFT_STAGE-1:0] ifft_oaddr;
output ifft_oen;

input iclk;
input rst_n;

wire [REAL_WIDTH-1:0] ifft_ire;
wire [IMGN_WIDTH-1:0] ifft_iim;
wire [CPLX_WIDTH-1:0] ifft_data;


signed_cplx_expand #(
.IWIDTH(OCP_WIDTH),
.OWIDTH(CP_WIDTH),
.IPRE(EXTRA_PRE)
) sce0 (
.ire( pf_re ),
.iim( pf_im ),
.ore( ifft_ire ),
.oim( ifft_iim )
);

ifft128 ifft0(
.iaddr(pf_index),
.idata( { ifft_ire, ifft_iim } ),
.ien(pf_en),

.oaddr(ifft_oaddr),
.odata(ifft_data),
.oen(ifft_oen),

.iclk(iclk),
.rst_n(rst_n)
);

signed_cplx_trunc #(
.IWIDTH(CP_WIDTH),
.OWIDTH(OCP_WIDTH),
.IPRE(EXTRA_PRE)
) sct0 (
.ire(ifft_data[REAL_MSB:REAL_LSB]),
.iim(ifft_data[IMGN_MSB:IMGN_LSB]),
.ore(ifft_ore),
.oim(ifft_oim)
);


endmodule