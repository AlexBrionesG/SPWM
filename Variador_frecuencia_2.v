//------------------------------------------------------------------------------------------------------------------
//		MÓDULO PRINCIPAL
//
//	Este módulo integra todos los módulos en uno sólo y se encarga de hacer las conexiones entre uno y otro. Además,
//	contiene la operación que va determinar el ancho de pulso para cada ciclo en particular del SPWM, ya que el
//	contador ascendente/descendente va llevar la cuenta del ciclo en el que va, y por el dato obtenido del cálculo
// se generará ese valor pwm_in que dicta el ancho de pulso.
//	
//------------------------------------------------------------------------------------------------------------------

module Variador_frecuencia_2(reset, clock, pwm_Pos, pwm_Neg, Selec, RxD, Rx_done, Aumenta, Disminuye, Fino, DU, DD, DC); // se agrego sel
	input reset, clock, Aumenta, Disminuye, Fino, Selec, RxD;	//3 Botones, 2 Interruptores, Bus serial, clock
	output pwm_Pos, pwm_Neg, Rx_done;									//Salidas del SPWM e indicador para bus serial
	output [7:0] DU, DD, DC;												//Displays
	
	wire rstUpDown, UpDowm, carryUp, carryDown, rdyP, rdyN; 
	
	wire rst_synP, rst_synN, ePWMs, eCount, UpDown;
	wire [15:0]pwm_in;
	
	wire [10:0] Ciclos_pwm;
	wire [6:0] Cuenta_pwm;
	wire [15:0] Cte_mul;
	
	wire [7:0] Rx, Frec;
	
	//--------------------------------------------
	CounterUpDown #(11,0) CountUp_Down(
		.reset(reset), 
		.clock(clock), 
		.rst_syn(rstUpDown), 
		.e(eCount), 
		.UpDown(UpDown), 
		.carryUp(carryUp), 
		.carryDown(carryDown), 
		.cuenta_pwm(Cuenta_pwm),
		.Ciclos_pwm(Ciclos_pwm));
	//--------------------------------------------
	
	//--------------------------------------------
	generadorpwm #(16, 10000) pwmPos(
		.reset(reset), 
		.clock(clock), 
		.rst_syn(rst_synP), 
		.e(ePWMs), 
		.pwm_in(pwm_in), 
		.pwm_out(pwm_Pos),
		.carry(rdyP));
	//--------------------------------------------

	//--------------------------------------------
	generadorpwm #(16, 10000) pwmNeg(
		.reset(reset), 
		.clock(clock), 
		.rst_syn(rst_synN), 
		.e(ePWMs), 
		.pwm_in(pwm_in), 
		.pwm_out(pwm_Neg),
		.carry(rdyN));
	//--------------------------------------------
	
	assign  pwm_in = Cuenta_pwm * Cte_mul;
	
	//--------------------------------------------
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
	//--------------------------------------------
	
	//--------------------------------------------
	Recibe_UART Recibe_UART(
		.clk(clock),
		.RxD(RxD),
		.Rx_done(Rx_done),
		.RxD_data(Rx) );
	//--------------------------------------------
	
	//--------------------------------------------
	Calcular Calcular(
		.Frec(Frec), 
		.Ciclos_pwm(Ciclos_pwm), 
		.Cte(Cte_mul) );
	//--------------------------------------------
	
	//--------------------------------------------
	Display Display(
		.Frec(Frec), 
		.Display_U(DU), 
		.Display_D(DD), 
		.Display_C(DC) );
	//--------------------------------------------
	
	//--------------------------------------------
	Frecuencia Frecuencia(
		.Aumenta(Aumenta), 
		.Disminuye(Disminuye), 
		.Fino(Fino), 
		.Restablecer(reset), 
		.Rx(Rx),
		.Selec(Selec),
		.clock(clock), 
		.Frec(Frec) );
	//--------------------------------------------
	
endmodule
