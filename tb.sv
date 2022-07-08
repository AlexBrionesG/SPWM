`timescale 1ns/1ns
module tb();
 bit clk, rst;
 logic pwm_P, pwm_N;
 
 spwm spwm(rst, clk, pwm_P, pwm_N);

 initial begin
  rst = 0;
  #40;
  rst = 1;
  #7000; 
 end
  
 always 
     #10 clk = ~clk;
  initial 
     clk = 0;
endmodule
