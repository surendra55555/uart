/*
Name 	: Nazim
Design 	: Parity Genarator
Date	: 3rd April, 2019
*/

`timescale 1ns/1ps

module parity_gen #(
	parameter WIDTH = 8
) (
  input [WIDTH-1:0] d_in,
  output reg p_out
);


  always @(d_in) begin
    p_out = ^d_in;
  end
  
endmodule

