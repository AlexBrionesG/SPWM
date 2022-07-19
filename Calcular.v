//------------------------------------------------------------------------------------------------------------------
//		Cálculo para PWM
//
//	Este módulo permite obetener dos valores necesarios para generar el PWM a partir del valor de la frecuencia
// que elige el usuario. 
//	Uno de estos valores es "ciclos_pwm" que nos va indicar la cantidad de ciclos de la señal
//	PWM de 5 KHz que van a poder entrar en el ciclo de la señal que pretendemos generar a la frecuencia seleccionada.
//	Esto se logra dividiendo la frecuencia del PWM entre 4 y posteriormente dividiendolo entre la frecuencia de la 
//	señal.
// El otro valor es simplemente una constante que va permitir que el aumento del ciclo del pwm aumente linealmente,
//	ya que divide los 10000 ciclos de reloj de 50MHz del FPGA entre los ciclos que van a entrar en la señal de 
//	frecuencia seleccionada.
//	
//------------------------------------------------------------------------------------------------------------------


module Calcular(Frec, Ciclos_pwm, Cte);
	
	input[7:0] Frec; 				//Frecuencia seleccionada por el usuario
	
	output [10:0] Ciclos_pwm;	//Cantidad de ciclos de 5 kHz que entraran en la señal de frecuencia seleccionada
	output [15:0] Cte;			//Constante para hacer incremententos lineales al ciclo de trabajo del PWM
		
	assign
		Ciclos_pwm = 1250/Frec,	//FÓRMULA: (5 kHz / 4) / Frecuencia = 1250 / Frecuencia
										//	Se divide entre 4 porque la señal PWM aumenta de 0 a 100% a la mitad de medio ciclo
		
		Cte = Frec >> 3;			//10000 / Ciclos_pwm = 10000/(1250/Frecuencia) = 8*Frecuencia

endmodule
