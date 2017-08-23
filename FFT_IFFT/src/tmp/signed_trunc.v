module signed_trunc(
idata,
odata
);
parameter IWIDTH = 16;
parameter OWIDTH = 8;
parameter IPRE = 4;

input [IWIDTH-1:0] idata;
output [OWIDTH-1:0] odata;

assign odata = idata[IWIDTH-IPRE-1:IWIDTH-IPRE-OWIDTH];

endmodule
