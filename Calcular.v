module Calcular(Frec, Ciclos_pwm, Cte);
	
	input[7:0] Frec; 
	
	output [10:0] Ciclos_pwm;
	output [15:0] Cte;
		
	assign
		Ciclos_pwm = 1250/Frec,	//10kHz / 4 = 2500
		Cte = Frec * 8;		//9999/Ciclos_pwm = 5000/(2500/Frecuencia) = 8*Frecuencia

endmodule
