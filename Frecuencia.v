module Frecuencia(Aumenta, Disminuye, Fino, Restablecer, Rx, Selec, clock, Frec);

	input Aumenta, Disminuye, Fino, Restablecer, clock, Selec;
	input [7:0] Rx;

	output reg[7:0] Frec = 60;
	
	reg [7:0] FA, FD;
		

	always@(negedge Aumenta) begin
			FA = Frec + 1'b1 + (Fino * 4'b1001);
	end

	always@(negedge Disminuye) begin
			FD = Frec - 1'b1 - (Fino * 4'b1001);
	end
	
	//assign Frec = 60*(~Restablecer) + Restablecer*(Frec + Selec*Rx + FA*(~Aumenta) + FD*(~Disminuye));

	always @(posedge clock) begin
		
		if (~Restablecer)	Frec <= 60;
		else if (Selec)		Frec <= Rx;
		else if (~Aumenta)	Frec <= FA;
		else if (~Disminuye)	Frec <= FD;
		else			Frec <= Frec;
				
		//Ciclos_pwm = 1250/Frec;	//10kHz / 4 = 2500
		//Cte = Frec * 8;		//9999/Ciclos_pwm = 5000/(2500/Frecuencia) = 8*Frecuencia
	end
endmodule
