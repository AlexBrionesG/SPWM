//------------------------------------------------------------------------------------------------------------------
//		Contador
//
//	Este módulo es un contador muy básico cuya función es llevar la cuenta para cambiar el valor de la salida del
//	SPWM cuando el ancho de pulso requerido sea completado.
//	
//------------------------------------------------------------------------------------------------------------------

module Counter(reset, clock, rst_syn, e, carry, salida_cont);
	parameter ancho = 14, cnt_max = 9999;
	parameter [ancho-1:0]reset_value = 0;
	
	input clock, reset, rst_syn, e;
	output carry;
	output reg [ancho-1:0]salida_cont;
	
	always @(negedge reset, posedge clock)
		if(~reset) salida_cont <= reset_value;
		else if(rst_syn) salida_cont <= reset_value;
		else if(carry) salida_cont <= reset_value;
		else if(e) salida_cont <= salida_cont + 1'b1;
		
	assign carry = (salida_cont == cnt_max && e)? 1'b1 : 1'b0;
endmodule