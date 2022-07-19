//------------------------------------------------------------------------------------------------------------------
//		Máquina de Estados Finitos
//
//	Este módulo es el corazón del generador del SPWM, pues ejecuta la secuencia que va coordinar todos los demás
//	módulos. Básicamente hace la siguiente secuencia: 
//		1. Generar SPWM ascendente hasta la mitad del ciclo positivo.
//		2. Generar SPWM descendente hasta el final del ciclo positivo.
//		3. Generar SPWM ascendente hasta la mitad del ciclo negativo.
//		4. Generar SPWM descendente hasta el final del ciclo negativo.
//	
//------------------------------------------------------------------------------------------------------------------

module fsm(rst, clk, CarryUp, CarryDown, rdyP, rdyN, ePWMs, eCount, rst_synP, rst_synN, UpDown, rstUpDown);
	input rst, clk, CarryUp, CarryDown, rdyP, rdyN;
	output ePWMs, eCount, rst_synP, rst_synN, UpDown, rstUpDown;
	
	reg [3:0] nxtSt;
	reg [3:0] currSt;
	
	always @* begin 
		nxtSt = currSt;   //This line is equivalent to the "else" condition and avoids to repeat code
		
		case(currSt)
			0:
				nxtSt = 1;
				
			1:	
			   if (~CarryUp)
					nxtSt = 2;
				else
					nxtSt = 3;
			2:
				if(rdyP)
					nxtSt = 1;
			3:	
				if (~CarryDown)
					nxtSt = 4;
				else
					nxtSt = 5;
			4:
				if (rdyP)
					nxtSt = 3;
			5:	
			   if (~CarryUp)
					nxtSt = 6;
				else
					nxtSt = 7;
			6:
				if(rdyN)
					nxtSt = 5;
			7:	
				if (~CarryDown)
					nxtSt = 8;
				else
					nxtSt = 0;
			8:
				if (rdyN)
					nxtSt = 7;
			
			default: nxtSt = 0;
			
		endcase   
	end
	/***************************************************/
	
	/*** FSM Sequential Always***/
	always @(negedge rst, posedge clk) begin
		if (~rst) begin
			currSt <= 0;
		end
		else begin
			currSt <= nxtSt;
		end
	
	end
	/***************************************************/
	
	/*** FSM Outputs ***/
	
	assign ePWMs = (currSt == 0) ? 1'b0 : 1'b1;
	assign eCount = (currSt == 1 || currSt == 3 || currSt == 5 || currSt == 7) ? 1'b1 : 1'b0;
	assign rst_synP = (currSt == 1 || currSt == 2 || currSt == 3 || currSt == 4) ? 1'b0 : 1'b1;
	assign rst_synN = (currSt == 5 || currSt == 6 || currSt == 7 || currSt == 8) ? 1'b0 : 1'b1;
	assign UpDown = (currSt == 3 || currSt == 4 || currSt == 7 || currSt == 8) ? 1'b0 : 1'b1;
	assign rstUpDown = (currSt == 0) ? 1'b1 : 1'b0;
	/***************************************************/
	
endmodule
