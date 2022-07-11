module detector_flanco(reset, clock, entrada, flanco);
	input reset, clock, entrada;
	output flanco;

	reg q1, q2;
		
	always @(negedge reset, posedge clock)
		if (~reset) begin
			q1 <= 1'b1;
			q2 <= 1'b1;
		end
		else begin
			q1 <= entrada;
			q2 <= q1;
		end
		
		assign flanco = ~q1 & q2;
		
endmodule