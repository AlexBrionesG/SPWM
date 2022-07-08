module Counter(rst, clk, rst_syn, e, carry, cnt);
	parameter width = 4, cnt_max = 9;
	parameter [width-1:0]reset_value = 0;
	input clk, rst, rst_syn, e;
	output carry;
	output reg [width-1:0]cnt;
	
	always @(negedge rst, posedge clk)
		if(~rst) cnt <= reset_value;
		else if(rst_syn) cnt <= reset_value;
		else if(carry) cnt <= reset_value;
		else if(e) cnt <= cnt + 1'b1;
		
	assign carry = (cnt == cnt_max && e)? 1'b1 : 1'b0;
endmodule