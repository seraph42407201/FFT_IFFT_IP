module signed_cplx_trunc(
ire,
iim,
ore,
oim
);
parameter IWIDTH = 16;
parameter OWIDTH = 16;
parameter IPRE = 0;

input [IWIDTH-1:0] ire;
input [IWIDTH-1:0] iim;
output [OWIDTH-1:0] ore;
output [OWIDTH-1:0] oim;

signed_trunc #(
.IWIDTH(IWIDTH),
.OWIDTH(OWIDTH),
.IPRE(IPRE)
) st_re(
.idata(ire),
.odata(ore)
);

signed_trunc #(
.IWIDTH(IWIDTH),
.OWIDTH(OWIDTH),
.IPRE(IPRE)
) st_im(
.idata(iim),
.odata(oim)
);

endmodule
