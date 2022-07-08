module spwm(rst, clk, pwm_P, pwm_N);
	input rst, clk;
	output pwm_P, pwm_N;
	
	wire rstUpDown, UpDowm, carryUp, carryDown, rdyP, rdyN; 
	wire [4:0]cnt;
	
	wire rst_synP, rst_synN, ePWMs, eCount, UpDown;
	wire [13:0]pwmin;
	
	CounterUpDown #(5,21,0) CountUp_Down(
	.rst(rst), 
	.clk(clk), 
	.rst_syn(rstUpDown), 
	.e(eCount), 
	.UpDown(UpDown), 
	.carryUp(carryUp), 
	.carryDown(carryDown), 
	.cnt(cnt));
	
	generadorpwm #(14, 9999) pwmPos(
	.rst(rst), 
	.clk(clk), 
	.rst_syn(rst_synP), 
	.e(ePWMs), 
	.pwmin(pwmin), 
	.pwmout(pwm_P),
	.carry(rdyP));

	
	generadorpwm #(14, 9999) pwmNeg(
	.rst(rst), 
	.clk(clk), 
	.rst_syn(rst_synN), 
	.e(ePWMs), 
	.pwmin(pwmin), 
	.pwmout(pwm_N),
	.carry(rdyN));
	
	assign  pwmin = cnt * 476; 
	
	fsm fsm(
	.rst(rst), 
	.clk(clk), 
	.CarryUp(carryUp), 
	.CarryDown(carryDown), 
	.rdyP(rdyP),
	.rdyN(rdyN),
	.ePWMs(ePWMs),
	.eCount(eCount),	
	.rst_synP(rst_synP), 
	.rst_synN(rst_synN), 
	.UpDown(UpDown), 
	.rstUpDown(rstUpDown));
	
endmodule
