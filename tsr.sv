/*
Name 	: Nazim
Design 	: Tx Shift Register (PISO)
Date	: 3rd April, 2019
*/

`timescale 1ns/1ps

module tsr #(
	parameter WIDTH = 8
 ) (
	input 	[WIDTH-1:0] d_in,
	input 	reg ld_sh,
	input 	reg en,
	input 	reg clk,
	input 	reg rst_n,
	output 	d_out
);

	reg [WIDTH-1:0] d_in_reg;
	reg d_out_reg;


always @(posedge clk, negedge rst_n) begin
	if (!rst_n) begin
		d_in_reg <= 0;
	end
	else begin
		if (en) begin
			if (ld_sh) begin
				d_in_reg <= d_in;
			end
			else begin
			   d_out_reg <= d_in_reg[WIDTH-1];
		 	  	d_in_reg <= d_in_reg << 1;	
			   d_in_reg[0] <= 1'b0;
			end
		end
		else begin
			d_in_reg <= d_in_reg;	
		end
	end
end
	
assign d_out = d_out_reg;

endmodule
