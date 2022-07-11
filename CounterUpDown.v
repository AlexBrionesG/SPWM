module CounterUpDown(reset, clock, rst_syn, e, UpDown, carryUp, carryDown, cuenta_pwm, Ciclos_pwm);
	
	parameter Ancho = 7; // se quito parametro
	parameter [Ancho-1:0]valor_reset = 0;

	input clock, reset, rst_syn, e, UpDown;
	input [Ancho-1:0]Ciclos_pwm; // se agrego

	output carryUp, carryDown;
	output reg [Ancho-1:0]cuenta_pwm;
	
	always @(negedge reset, posedge clock)
		if(~reset) cuenta_pwm <= valor_reset;
		else if(rst_syn) cuenta_pwm <= valor_reset;
		else if(e & UpDown) cuenta_pwm <= cuenta_pwm + 1'b1;
		else if(e & ~UpDown) cuenta_pwm <= cuenta_pwm - 1'b1;
		
	assign carryUp = (cuenta_pwm == Ciclos_pwm && e)? 1'b1 : 1'b0; //se cambio
	assign carryDown = (cuenta_pwm == 1 && e)? 1'b1 : 1'b0;
endmodule