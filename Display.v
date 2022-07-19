//------------------------------------------------------------------------------------------------------------------
//		Decodificador para Displays de 7 segmentos Ánodo Común
//
//	Este módulo permite mostrar el valor de frecuencia seleccionado en displays de 7 segmentos AC. Lo que hace es
//	separar cada digito para tener unidades, decenas y centenas. Luego por medio de una tabla que 
//	ya tiene decodificados los valores de cada número del 0 al 9 en su representacion para display, se mandan los 
//	digitos a su respectivo display.
//	
//------------------------------------------------------------------------------------------------------------------

module Display(Frec, Display_U, Display_D, Display_C);

	input[7:0] Frec;											//Frecuencia

	output[7:0] Display_U, Display_D, Display_C;		//Displays

	wire [7:0] F2;				//Variable para almacenar el número ya sin unidades
	wire [7:0]Tabla[9:0];	//Variable para almacenar los valores de la tabla
	
	assign
		Display_U = Tabla[Frec % 10],		//Se obtienen unidades
		F2 = Frec / 10,
		Display_D = Tabla[F2 % 10],		//Se obtienen decenas
		Display_C = Tabla[F2 / 10];		//Se obtienen centenas
	
	//-------	TABLA		-------
	assign
	//					   gfdecba
		Tabla[0] = 8'b11000000,		//0
		Tabla[1] = 8'b11111001,		//1
		Tabla[2] = 8'b10100100,		//2
		Tabla[3] = 8'b10110000,		//3
		Tabla[4] = 8'b10011001,		//4
		Tabla[5] = 8'b10010010,		//5
		Tabla[6] = 8'b10000010,		//6
		Tabla[7] = 8'b11111000,		//7
		Tabla[8] = 8'b10000000,		//8
		Tabla[9] = 8'b10010000;		//9
		
	//--------------------------

endmodule
