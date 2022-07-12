module Display(Frec, Display_U, Display_D, Display_C);

	input[7:0] Frec;

	output[7:0] Display_U, Display_D, Display_C;

	wire [7:0] F2;
	wire [7:0]Tabla[9:0];
	
	assign
		Display_U = Tabla[Frec % 10],
		F2 = Frec / 10,
		Display_D = Tabla[F2 % 10],
		Display_C = Tabla[F2 / 10];

	assign
		Tabla[0] = 8'b11000000,
		Tabla[1] = 8'b11111001,
		Tabla[2] = 8'b10100100,
		Tabla[3] = 8'b10110000,
		Tabla[4] = 8'b10011001,
		Tabla[5] = 8'b10010010,
		Tabla[6] = 8'b10000010,
		Tabla[7] = 8'b11111000,
		Tabla[8] = 8'b10000000,
		Tabla[9] = 8'b10010000;

endmodule