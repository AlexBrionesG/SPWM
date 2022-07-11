module Selector_pulsador(Aumenta, Disminuye, Fino, Restablecer, clock, Ciclos_pwm, Cte, Display_U, Display_D, Display_C);
	input Aumenta, Disminuye, Fino, Restablecer, clock;
	output reg[10:0] Ciclos_pwm;
	output reg[16:0] Cte;
	output reg[7:0] Display_U, Display_D, Display_C;
	
	reg [7:0] Frecuencia, F2, FA, FD, FR;
	wire [7:0]Tabla[9:0];
	
	always@(negedge Aumenta) begin
			FA = Frecuencia + 1'b1 + (Fino * 4'b1001);
	end

	always@(negedge Disminuye) begin
			FD = Frecuencia - 1'b1 - (Fino * 4'b1001);
	end
	
	always @* begin
		
		if (~Restablecer) 
			Frecuencia = 60;
		else if (~Aumenta)
			Frecuencia = FA;
		else if (~Disminuye)
			Frecuencia = FD;
		
		Ciclos_pwm = 1250/Frecuencia;	//10kHz / 4 = 2500
		Cte = Frecuencia * 8;		//9999/Ciclos_pwm = 5000/(2500/Frecuencia) = 8*Frecuencia
		
		Display_U = Tabla[Frecuencia % 10];
		F2 = Frecuencia / 10;
		Display_D = Tabla[F2 % 10];
		Display_C = Tabla[F2 / 10];
	end

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