// Verilog netlist created by TD v3.2.568
// Sat Dec 09 19:05:41 2017

`timescale 1ns / 1ps
module cpu_pll  // C:/Users/Administrator/Desktop/Verilog/m34/cpuPLL/cpu_pll.v(22)
  (
  refclk,
  reset,
  stdby,
  clk1_out,
  extlock
  );

  input refclk;  // C:/Users/Administrator/Desktop/Verilog/m34/cpuPLL/cpu_pll.v(28)
  input reset;  // C:/Users/Administrator/Desktop/Verilog/m34/cpuPLL/cpu_pll.v(29)
  input stdby;  // C:/Users/Administrator/Desktop/Verilog/m34/cpuPLL/cpu_pll.v(30)
  output clk1_out;  // C:/Users/Administrator/Desktop/Verilog/m34/cpuPLL/cpu_pll.v(32)
  output extlock;  // C:/Users/Administrator/Desktop/Verilog/m34/cpuPLL/cpu_pll.v(31)

  wire clk1_buf;  // C:/Users/Administrator/Desktop/Verilog/m34/cpuPLL/cpu_pll.v(34)

  EG_PHY_GCLK bufg_feedback (
    .clki(clk1_buf),
    .clko(clk1_out));  // C:/Users/Administrator/Desktop/Verilog/m34/cpuPLL/cpu_pll.v(36)
  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  EG_PHY_PLL #(
    .CLKC0_CPHASE(1),
    .CLKC0_DIV(1),
    .CLKC0_DIV2_ENABLE("DISABLE"),
    .CLKC0_ENABLE("DISABLE"),
    .CLKC0_FPHASE(0),
    .CLKC1_CPHASE(100),
    .CLKC1_DIV(100),
    .CLKC1_DIV2_ENABLE("DISABLE"),
    .CLKC1_ENABLE("ENABLE"),
    .CLKC1_FPHASE(0),
    .CLKC2_CPHASE(1),
    .CLKC2_DIV(1),
    .CLKC2_DIV2_ENABLE("DISABLE"),
    .CLKC2_ENABLE("DISABLE"),
    .CLKC2_FPHASE(0),
    .CLKC3_CPHASE(1),
    .CLKC3_DIV(1),
    .CLKC3_DIV2_ENABLE("DISABLE"),
    .CLKC3_ENABLE("DISABLE"),
    .CLKC3_FPHASE(0),
    .CLKC4_CPHASE(1),
    .CLKC4_DIV(1),
    .CLKC4_DIV2_ENABLE("DISABLE"),
    .CLKC4_ENABLE("DISABLE"),
    .CLKC4_FPHASE(0),
    .DERIVE_PLL_CLOCKS("DISABLE"),
    .DPHASE_SOURCE("DISABLE"),
    .DYNCFG("DISABLE"),
    .FBCLK_DIV(2),
    .FEEDBK_PATH("CLKC1_EXT"),
    .FIN("25.000"),
    .FREQ_LOCK_ACCURACY(2),
    .GEN_BASIC_CLOCK("DISABLE"),
    .GMC_GAIN(6),
    .GMC_TEST(14),
    .ICP_CURRENT(3),
    .IF_ESCLKSTSW("DISABLE"),
    .INTFB_WAKE("DISABLE"),
    .KVCO(6),
    .LPF_CAPACITOR(3),
    .LPF_RESISTOR(2),
    .NORESET("DISABLE"),
    .ODIV_MUXC0("DIV"),
    .ODIV_MUXC1("DIV"),
    .ODIV_MUXC2("DIV"),
    .ODIV_MUXC3("DIV"),
    .ODIV_MUXC4("DIV"),
    .PLLC2RST_ENA("DISABLE"),
    .PLLC34RST_ENA("DISABLE"),
    .PLLMRST_ENA("DISABLE"),
    .PLLRST_ENA("ENABLE"),
    .PLL_LOCK_MODE(0),
    .PREDIV_MUXC0("VCO"),
    .PREDIV_MUXC1("VCO"),
    .PREDIV_MUXC2("VCO"),
    .PREDIV_MUXC3("VCO"),
    .PREDIV_MUXC4("VCO"),
    .REFCLK_DIV(5),
    .REFCLK_SEL("INTERNAL"),
    .STDBY_ENABLE("ENABLE"),
    .STDBY_VCO_ENA("DISABLE"),
    .SYNC_ENABLE("ENABLE"),
    .VCO_NORESET("DISABLE"))
    pll_inst (
    .daddr(6'b000000),
    .dclk(1'b0),
    .dcs(1'b0),
    .di(8'b00000000),
    .dwe(1'b0),
    .fbclk(clk1_out),
    .psclk(1'b0),
    .psclksel(3'b000),
    .psdown(1'b0),
    .psstep(1'b0),
    .refclk(refclk),
    .reset(reset),
    .stdby(stdby),
    .clkc({open_n47,open_n48,open_n49,clk1_buf,open_n50}),
    .extlock(extlock));  // C:/Users/Administrator/Desktop/Verilog/m34/cpuPLL/cpu_pll.v(73)

endmodule 

