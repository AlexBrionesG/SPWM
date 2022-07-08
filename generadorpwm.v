module generadorpwm(rst, clk, rst_syn, e, pwmin, pwmout, carry);
	parameter widthCount = 14, cntMaxCount = 10000;
	input rst, clk,rst_syn, e;
	input [widthCount-1:0]pwmin; //
	output reg pwmout; 
	output carry;
	wire [widthCount-1:0]cnt;
	
	
	Counter #(widthCount,cntMaxCount,0) counter(
		.rst(rst), 
		.clk(clk), 
		.rst_syn(rst_syn),	
		.e(e), 
		.cnt(cnt), 
		.carry(carry));
		
	always @(pwmin, cnt, rst_syn)
		if (rst_syn) pwmout <= 1'b0;
		else if(cnt < pwmin) pwmout <= 1'b1;
		else pwmout <= 1'b0;
endmodule