`ifndef __FFT_INC_H__

	// `define TOTAL_STAGE   10		// 最多可以实现2048点(11阶)FFT/IFFT。
	
	// 原来的乘法器需要6个周期，需要使用RAM资源做寄存操作。资源浪费严重。现在改成2个周期。缺点是最大工作频率降低。
	// 利用这一点也可以实现可配置。
	// 不指定的情况下，MULT_OP_DLY = 2。
	// localparam MULT_OP_DLY = 6;	

	// 仿真使用，赋值时延。
	localparam SIM_DLY = 2;
	
`endif
