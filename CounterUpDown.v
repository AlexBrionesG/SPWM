//------------------------------------------------------------------------------------------------------------------
//		Contador ascendente/descendente
//
//	Este módulo es un contador con dos señales de reset y una para seleccionar conteo ascendente o descendente.
//	Además, tiene señal de Carry a la salida para ambos sentidos, que para el caso del conteo hacia arriba se 
//	activará cuando la cuenta llegue a un valor establecido por medio de una entrada. 
//	Mediante un parámetro se determina la cantidad de bits que abarcará el conteo.
//	
//------------------------------------------------------------------------------------------------------------------

module CounterUpDown(reset, clock, rst_syn, e, UpDown, carryUp, carryDown, cuenta_pwm, Ciclos_pwm);
	
	parameter Ancho = 11;						//Bits de conteo
	parameter [Ancho-1:0]valor_reset = 0;	//Valor que tomará al ocurrir un reset

	input clock, reset, rst_syn, e, UpDown;	//Señales de reset, clock, sentido y habilitación	
	input [Ancho-1:0]Ciclos_pwm; 					//Valor que establece cuando se activará el CarryUp.

	output carryUp, carryDown;						//Señales de Carry
	output reg [Ancho-1:0]cuenta_pwm;			//Conteo
	
	always @(negedge reset, posedge clock)
		if(~reset) cuenta_pwm <= valor_reset;							//Si hay reset, se restablece
		else if(rst_syn) cuenta_pwm <= valor_reset;
		else if(e & UpDown) cuenta_pwm <= cuenta_pwm + 1'b1;		//Conteo ascendente
		else if(e & ~UpDown) cuenta_pwm <= cuenta_pwm - 1'b1;		//Conteo desdencente
		
	assign carryUp = (cuenta_pwm == Ciclos_pwm && e)? 1'b1 : 1'b0;		//Carry Up
	assign carryDown = (cuenta_pwm == 1 && e)? 1'b1 : 1'b0;				//Carry Down
	
endmodule
