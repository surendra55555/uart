/*
Name	: Nazim
Design	: UART Transmitter
Date	: 9th Apr, 2019
*/

`timescale 1ns/1ps

`include "mux.v"
`include "parity_gen.v"
`include "tsr.sv"
`include "ufsm.v"


module transmitter #( 
	parameter WIDTH = 8
	) (
	input en, d_ready, clk, rstn, 
	input [WIDTH-1:0] d_in,
 	output tx_data,
	output tr_bz
);


	reg start_bit 	= 0;
	reg stop_bit	= 1;
	

	wire [1:0] sel_wire;
	wire p_wire;
	wire tsr_wire;
	wire data_load_wire;


	ufsm #(.WIDTH(WIDTH)) tfsm (
		.en(en),
		.d_ready(d_ready),
		.clk(clk),
		.rstn(rstn),
		.sel(sel_wire),
		.data_load(data_load_wire),
		.tr_bz(tr_bz)
	);

	parity_gen #(.WIDTH(WIDTH)) tparity_gen (
		.d_in(d_in),
		.p_out(p_wire)
	);

	tsr #(.WIDTH(WIDTH)) transmit_tsr (
		.d_in(d_in),
		.ld_sh(data_load_wire),
		.en(en),
		.clk(clk),
		.rst_n(rstn),
		.d_out(tsr_wire)
	);


	mux  tmux (
		.in_0(start_bit),
		.in_1(tsr_wire), 
		.in_2(p_wire), 
		.in_3(stop_bit),
		.sel(sel_wire),
		.en(en),
		.out(tx_data)
		);



endmodule
