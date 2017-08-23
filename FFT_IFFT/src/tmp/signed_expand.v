module signed_expand(
idata,
odata
);
parameter IWIDTH = 8;
parameter OWIDTH = 16;
parameter IPRE = 4;
input [IWIDTH-1:0] idata;
output [OWIDTH-1:0] odata;

assign odata = 
{
	{ IPRE { idata[IWIDTH-1]} },
	idata,
	{ OWIDTH - IWIDTH - IPRE { 1'b0 } }
};

endmodule
