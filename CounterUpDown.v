module CounterUpDown(rst, clk, rst_syn, e, UpDown, carryUp, carryDown, cnt);
	parameter width = 6, cnt_max = 41;
	parameter [width-1:0]reset_value = 0;
	input clk, rst, rst_syn, e, UpDown;
	output carryUp, carryDown;
	output reg [width-1:0]cnt;
	
	always @(negedge rst, posedge clk)
		if(~rst) cnt <= reset_value;
		else if(rst_syn) cnt <= reset_value;
		else if(e & UpDown) cnt <= cnt + 1'b1;
		else if(e & ~UpDown) cnt <= cnt - 1'b1;
		
	assign carryUp = (cnt == cnt_max && e)? 1'b1 : 1'b0;
	assign carryDown = (cnt == 1 && e)? 1'b1 : 1'b0;
endmodule