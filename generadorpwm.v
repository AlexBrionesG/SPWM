//------------------------------------------------------------------------------------------------------------------
//		Generador del SPWM
//
//	Este módulo utiliza el contador para generar el PWM con el ancho de pulso requerido en cada ciclo diferente.
//	Pone un valor de 1 lógico a la salida cuando el contador aun no llega al valor que dicta el ancho de 
// pulso. Cuando se llega a este valor la salida se pone a 0.
//	
//------------------------------------------------------------------------------------------------------------------

module generadorpwm(reset, clock, rst_syn, e, pwm_in, pwm_out, carry);
	parameter Ancho_contador = 14, contador_pulsos_pwm = 10000;

	input reset, clock,rst_syn, e;		//Clock, señales de reset y habilitación
	input [Ancho_contador-1:0]pwm_in;	//Valor que dicta el ancho de pulso.

	output reg pwm_out;						//Salida del SPWM
	output carry;

	wire [Ancho_contador-1:0]cuenta_pwm;	//Cuenta del PWM
	
	//------------------Módulo de contador------------------
	Counter #(Ancho_contador,contador_pulsos_pwm,0) counter(
		.reset(reset),
		.clock(clock),
		.rst_syn(rst_syn),
		.e(e),
		.carry(carry),
		.salida_cont(cuenta_pwm));
	//------------------------------------------------------
		
	always @(pwm_in, cuenta_pwm, rst_syn)
		if (rst_syn) pwm_out <= 1'b0;
		else if(cuenta_pwm < pwm_in) pwm_out <= 1'b1;		//Antes de llegar al ancho de pulso manda 1
		else pwm_out <= 1'b0;										//Despues de llegar al ancho de pulso manda 0
		
endmodule
