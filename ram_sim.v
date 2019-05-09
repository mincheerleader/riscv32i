// Verilog netlist created by TD v3.2.568
// Mon Dec 11 16:34:24 2017

`timescale 1ns / 1ps
module ramm  // C:/Users/Administrator/Desktop/Verilog/m34/ram/ram.v(14)
  (
  di,
  raddr,
  waddr,
  wclk,
  we,
  do
  );

  input [31:0] di;  // C:/Users/Administrator/Desktop/Verilog/m34/ram/ram.v(23)
  input [3:0] raddr;  // C:/Users/Administrator/Desktop/Verilog/m34/ram/ram.v(25)
  input [3:0] waddr;  // C:/Users/Administrator/Desktop/Verilog/m34/ram/ram.v(24)
  input wclk;  // C:/Users/Administrator/Desktop/Verilog/m34/ram/ram.v(26)
  input we;  // C:/Users/Administrator/Desktop/Verilog/m34/ram/ram.v(26)
  output [31:0] do;  // C:/Users/Administrator/Desktop/Verilog/m34/ram/ram.v(28)

  parameter ADDR_WIDTH_R = 4;
  parameter ADDR_WIDTH_W = 4;
  parameter DATA_DEPTH_R = 12;
  parameter DATA_DEPTH_W = 12;
  parameter DATA_WIDTH_R = 32;
  parameter DATA_WIDTH_W = 32;

  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  AL_LOGIC_DRAM16X4 #(
    .INIT_D0(16'b0000000000000110),
    .INIT_D1(16'b0000000000000110),
    .INIT_D2(16'b0000000000000100),
    .INIT_D3(16'b0000000000000100))
    dram_c0 (
    .di(di[3:0]),
    .raddr(raddr),
    .waddr(waddr),
    .wclk(wclk),
    .we(we),
    .do(do[3:0]));
  AL_LOGIC_DRAM16X4 #(
    .INIT_D0(16'b0000000000000000),
    .INIT_D1(16'b0000000000000110),
    .INIT_D2(16'b0000000000000100),
    .INIT_D3(16'b0000000000000100))
    dram_c1 (
    .di(di[7:4]),
    .raddr(raddr),
    .waddr(waddr),
    .wclk(wclk),
    .we(we),
    .do(do[7:4]));
  AL_LOGIC_DRAM16X4 #(
    .INIT_D0(16'b0000000000000100),
    .INIT_D1(16'b0000000000000000),
    .INIT_D2(16'b0000000000000000),
    .INIT_D3(16'b0000000000000000))
    dram_c2 (
    .di(di[11:8]),
    .raddr(raddr),
    .waddr(waddr),
    .wclk(wclk),
    .we(we),
    .do(do[11:8]));
  AL_LOGIC_DRAM16X4 #(
    .INIT_D0(16'b0000000000000100),
    .INIT_D1(16'b0000000000000110),
    .INIT_D2(16'b0000000000000100),
    .INIT_D3(16'b0000000000000110))
    dram_c3 (
    .di(di[15:12]),
    .raddr(raddr),
    .waddr(waddr),
    .wclk(wclk),
    .we(we),
    .do(do[15:12]));
  AL_LOGIC_DRAM16X4 #(
    .INIT_D0(16'b0000000000000100),
    .INIT_D1(16'b0000000000000100),
    .INIT_D2(16'b0000000000000100),
    .INIT_D3(16'b0000000000000100))
    dram_c4 (
    .di(di[19:16]),
    .raddr(raddr),
    .waddr(waddr),
    .wclk(wclk),
    .we(we),
    .do(do[19:16]));
  AL_LOGIC_DRAM16X4 #(
    .INIT_D0(16'b0000000000000100),
    .INIT_D1(16'b0000000000000010),
    .INIT_D2(16'b0000000000000000),
    .INIT_D3(16'b0000000000000100))
    dram_c5 (
    .di(di[23:20]),
    .raddr(raddr),
    .waddr(waddr),
    .wclk(wclk),
    .we(we),
    .do(do[23:20]));
  AL_LOGIC_DRAM16X4 #(
    .INIT_D0(16'b0000000000000100),
    .INIT_D1(16'b0000000000000100),
    .INIT_D2(16'b0000000000000100),
    .INIT_D3(16'b0000000000000100))
    dram_c6 (
    .di(di[27:24]),
    .raddr(raddr),
    .waddr(waddr),
    .wclk(wclk),
    .we(we),
    .do(do[27:24]));
  AL_LOGIC_DRAM16X4 #(
    .INIT_D0(16'b0000000000000100),
    .INIT_D1(16'b0000000000000100),
    .INIT_D2(16'b0000000000000110),
    .INIT_D3(16'b0000000000000100))
    dram_c7 (
    .di(di[31:28]),
    .raddr(raddr),
    .waddr(waddr),
    .wclk(wclk),
    .we(we),
    .do(do[31:28]));

endmodule 

