/*
Name : Nazim
Design : Parity Genarator Test bench
Date	: 3rd April, 2019
*/

`timescale 1ns/1ps

module parity_gen_tb #(
	parameter WIDTH = 8
) ();
  logic [WIDTH-1:0] d_in;
  logic p_out;
  logic err_data;
  
  parity_gen #(.WIDTH(WIDTH)) DUT_GEN (.d_in(d_in), .p_out(p_out) );
  parity_check #(.WIDTH(WIDTH)) DUT_CHECK (.d_in(d_in), .p_in(p_out), .err_data(err_data));
  
  initial begin
    d_in = 0;
    #100
    d_in = $random;
    #100
    d_in = d_in + 1'b1;
    #100
    d_in = $random;
    #100
    d_in = d_in - 1'b1;
    #100
    $finish;
  end
  
  
  initial begin
    $dumpfile("parity_genarate.vcd");
    $dumpvars;
  end
  
  
endmodule
