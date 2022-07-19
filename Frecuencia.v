//------------------------------------------------------------------------------------------------------------------
//		Seleccionador de frecuencia
//
//	Este módulo permite modificar el valor de frecuencia que el usuario quiere generar mediante un par de botones
//	aumentar o disminuir el valor, otro para restablecer a cierto valor, y un interruptor para poder hacer cambios
// de 1 en 1 o hacerlos de 10 en 10. Además, otro interruptor va permitir que el valor de la frecuencia sea elegido
//	por el dato que ingrese en el bus serial o por el que se elija manualmente con los botones.
//	
//------------------------------------------------------------------------------------------------------------------

module Frecuencia(Aumenta, Disminuye, Fino, Restablecer, Rx, Selec, clock, Frec);

	input Aumenta, Disminuye, Fino, Restablecer, clock, Selec;	//3 botones, 2 interruptores y clock
	input [7:0] Rx;															//Dato recibido por el bus serial

	output reg[7:0] Frec = 60;												//Frecuencia seleccionada
	
	reg [7:0] FA, FD;		//Variables internas para generar los cambios con los botones
		

	always@(negedge Aumenta) begin
			FA = Frec + 1'b1 + (Fino * 4'b1001);		//Aumenta 1 o 10 dependiendo el valor del interruptor Fino
	end

	always@(negedge Disminuye) begin
			FD = Frec - 1'b1 - (Fino * 4'b1001);		//Disminuye 1 o 10 dependiendo el valor del interruptor Fino
	end
	
	always @(posedge clock) begin
		
		if (~Restablecer)	Frec <= 60;						//Reset vuelve frecuencia a 60 Hz
		else if (Selec)		Frec <= Rx;					//Permite que la frecuencia sea seleccionada por bus serial
		else if (~Aumenta)	Frec <= FA;					//Se actualiza al valor aumentado
		else if (~Disminuye)	Frec <= FD;					//Se actualiza al valor disminuido
		else			Frec <= Frec;							//Se queda igual
				
	end
	
endmodule
