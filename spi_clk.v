/************************************************************\
 **  Copyright (c) 2011-2017 Anlogic, Inc.
 **  All Right Reserved.
\************************************************************/
/************************************************************\
 ** Log	:	This file is generated by Anlogic IP Generator.
 ** File	:	C:/Users/Administrator/Desktop/Verilog/m34/spi_PLL/spi_clk.v
 ** Date	:	2017 12 09
 ** TD version	:	3.2.568
\************************************************************/

///////////////////////////////////////////////////////////////////////////////
//	Input frequency:             25.000Mhz
//	Clock multiplication factor: 16
//	Clock division factor:       5
//	Clock information:
//		Clock name	| Frequency 	| Phase shift
//		C0        	| 80.000 MHZ	| 0  DEG     
///////////////////////////////////////////////////////////////////////////////
`timescale 1 ns / 100 fs

module spi_clk(refclk,
		reset,
		stdby,
		extlock,
		clk0_out);

	input refclk;
	input reset;
	input stdby;
	output extlock;
	output clk0_out;

	wire clk0_buf;

	EG_LOGIC_BUFG bufg_feedback( .i(clk0_buf), .o(clk0_out) );

	EG_PHY_PLL #(.DYNCFG("DISABLE"),
		.FIN("25.000"),
		.FEEDBK_PATH("CLKC0_EXT"),
		.STDBY_ENABLE("ENABLE"),
		.PLLRST_ENA("ENABLE"),
		.SYNC_ENABLE("ENABLE"),
		.DERIVE_PLL_CLOCKS("DISABLE"),
		.GEN_BASIC_CLOCK("DISABLE"),
		.GMC_GAIN(6),
		.ICP_CURRENT(3),
		.KVCO(6),
		.LPF_CAPACITOR(3),
		.LPF_RESISTOR(2),
		.REFCLK_DIV(5),
		.FBCLK_DIV(16),
		.CLKC0_ENABLE("ENABLE"),
		.CLKC0_DIV(12),
		.CLKC0_CPHASE(12),
		.CLKC0_FPHASE(0)	)
	pll_inst (.refclk(refclk),
		.reset(reset),
		.stdby(stdby),
		.extlock(extlock),
		.psclk(1'b0),
		.psdown(1'b0),
		.psstep(1'b0),
		.psclksel(3'b000),
		.psdone(open),
		.dclk(1'b0),
		.dcs(1'b0),
		.dwe(1'b0),
		.di(8'b00000000),
		.daddr(6'b000000),
		.do({open, open, open, open, open, open, open, open}),
		.fbclk(clk0_out),
		.clkc({open, open, open, open, clk0_buf}));

endmodule
