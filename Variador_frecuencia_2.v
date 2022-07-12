module Variador_frecuencia_2(reset, clock, pwm_Pos, pwm_Neg, Selec, RxD, Rx_done, Aumenta, Disminuye, Fino, DU, DD, DC); // se agrego sel
	input reset, clock, Aumenta, Disminuye, Fino, Selec, RxD;
	output pwm_Pos, pwm_Neg, Rx_done;
	output [7:0] DU, DD, DC;
	
	wire rstUpDown, UpDowm, carryUp, carryDown, rdyP, rdyN; 
	//wire [4:0]cnt;
	
	wire rst_synP, rst_synN, ePWMs, eCount, UpDown;
	wire [15:0]pwm_in;
	
	wire [10:0] Ciclos_pwm; //
	wire [6:0] Cuenta_pwm; // se agrego
	wire [15:0] Cte_mul;
	
	wire [7:0] Rx, Frec;
	
	CounterUpDown #(11,0) CountUp_Down( //se quito el 21
	.reset(reset), 
	.clock(clock), 
	.rst_syn(rstUpDown), 
	.e(eCount), 
	.UpDown(UpDown), 
	.carryUp(carryUp), 
	.carryDown(carryDown), 
	.cuenta_pwm(Cuenta_pwm),
	.Ciclos_pwm(Ciclos_pwm));  //se agrego
	
	generadorpwm #(16, 10000) pwmPos(
	.reset(reset), 
	.clock(clock), 
	.rst_syn(rst_synP), 
	.e(ePWMs), 
	.pwm_in(pwm_in), 
	.pwm_out(pwm_Pos),
	.carry(rdyP));

	
	generadorpwm #(16, 10000) pwmNeg(
	.reset(reset), 
	.clock(clock), 
	.rst_syn(rst_synN), 
	.e(ePWMs), 
	.pwm_in(pwm_in), 
	.pwm_out(pwm_Neg),
	.carry(rdyN));
	
	assign  pwm_in = Cuenta_pwm * Cte_mul; //este es Cte
	
	fsm fsm(
	.rst(reset), 
	.clk(clock), 
	.CarryUp(carryUp), 
	.CarryDown(carryDown), 
	.rdyP(rdyP),
	.rdyN(rdyN),
	.ePWMs(ePWMs),
	.eCount(eCount),	
	.rst_synP(rst_synP), 
	.rst_synN(rst_synN), 
	.UpDown(UpDown), 
	.rstUpDown(rstUpDown));
	
	/*
	Frecuencia Frecuencia(
	.Aumenta(Aumenta), 
	.Disminuye(Disminuye), 
	.Fino(Fino), 
	.Restablecer(reset), 
	.Rx(Rx),
	.Selec(Selec),
	.clock(clock),
	.Ciclos_pwm(Ciclos_pwm), 
	.Cte(Cte_mul), 
	.Display_U(DU), 
	.Display_D(DD), 
	.Display_C(DC) );
	*/
	
	Recibe_UART Recibe_UART(
   .clk(clock),
   .RxD(RxD),
   .Rx_done(Rx_done),
	.RxD_data(Rx) );
	
	Calcular Calcular(
	.Frec(Frec), 
	.Ciclos_pwm(Ciclos_pwm), 
	.Cte(Cte_mul) );
	
	Display Display(
	.Frec(Frec), 
	.Display_U(DU), 
	.Display_D(DD), 
	.Display_C(DC) );
	
	Frecuencia Frecuencia(
	.Aumenta(Aumenta), 
	.Disminuye(Disminuye), 
	.Fino(Fino), 
	.Restablecer(reset), 
	.Rx(Rx),
	.Selec(Selec),
	.clock(clock), 
	.Frec(Frec) );

	
endmodule
