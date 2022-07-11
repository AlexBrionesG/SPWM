module generadorpwm(reset, clock, rst_syn, e, pwm_in, pwm_out, carry);
	parameter Ancho_contador = 14, contador_pulsos_pwm = 10000;

	input reset, clock,rst_syn, e;
	input [Ancho_contador-1:0]pwm_in; //

	output reg pwm_out; 
	output carry;

	wire [Ancho_contador-1:0]cuenta_pwm;
	
	
	Counter #(Ancho_contador,contador_pulsos_pwm,0) counter(
		.reset(reset),
		.clock(clock),
		.rst_syn(rst_syn),
		.e(e),
		.carry(carry),
		.salida_cont(cuenta_pwm));
		
	always @(pwm_in, cuenta_pwm, rst_syn)
		if (rst_syn) pwm_out <= 1'b0;
		else if(cuenta_pwm < pwm_in) pwm_out <= 1'b1;
		else pwm_out <= 1'b0;
endmodule