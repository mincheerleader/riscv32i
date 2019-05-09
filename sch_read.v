// Verilog netlist created by TD v4.3.815
// Fri Mar 22 13:53:30 2019

`timescale 1ns / 1ps
module __top  // __top.v(3)
  (
  clock,
  rst,
  led
  );

  input clock;  // __top.v(4)
  input rst;  // __top.v(3)
  output led;  // __top.v(5)

  wire [31:0] addr;  // __top.v(17)
  wire [31:0] i_data;  // __top.v(15)
  wire [3:0] n2;
  wire [3:0] n3;
  wire [31:0] o_data;  // __top.v(16)
  wire led_n;  // __top.v(23)
  wire memread;  // __top.v(13)
  wire memwrite_cs;  // __top.v(14)
  wire n0;
  wire n1;
  wire n4;
  wire n5;
  wire n6;
  wire n7;
  wire n8;

  eq_w1 eq0 (
    .i0(memwrite_cs),
    .i1(1'b1),
    .o(n5));  // __top.v(60)
  eq_w32 eq1 (
    .i0(addr),
    .i1(32'b00000000000000000000010000000010),
    .o(n6));  // __top.v(61)
  AL_DFF led_n_reg (
    .clk(clock),
    .d(n8),
    .reset(n4),
    .set(1'b0),
    .q(led_n));  // __top.v(63)
  lt_u32_u32 lt0 (
    .ci(1'b0),
    .i0(addr),
    .i1(32'b00000000000000000000000001100000),
    .o(n0));  // __top.v(51)
  ramm m (
    .di(o_data),
    .raddr(n3),
    .waddr(n2),
    .wclk(clock),
    .we(memwrite_cs),
    .do(i_data));  // __top.v(49)
  binary_mux_s1_w4 mux0 (
    .i0(4'b0000),
    .i1(addr[5:2]),
    .sel(n1),
    .o(n2));  // __top.v(51)
  binary_mux_s1_w4 mux1 (
    .i0(4'b0000),
    .i1(addr[5:2]),
    .sel(memread),
    .o(n3));  // __top.v(55)
  top2 t (
    .clock(clock),
    .i_iodat(i_data),
    .rst(rst),
    .memread(memread),
    .memwrite_cs(memwrite_cs),
    .o_ioaddr(addr),
    .o_iodat(o_data));  // __top.v(40)
  and u2 (n1, memwrite_cs, n0);  // __top.v(51)
  not u3 (n4, rst);  // __top.v(58)
  and u4 (n7, n5, n6);  // __top.v(61)
  AL_MUX u5 (
    .i0(led_n),
    .i1(o_data[0]),
    .sel(n7),
    .o(n8));  // __top.v(63)
  buf u6 (led, led_n);  // __top.v(65)

endmodule 

module eq_w1
  (
  i0,
  i1,
  o
  );

  input i0;
  input i1;
  output o;



endmodule 

module eq_w32
  (
  i0,
  i1,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  output o;



endmodule 

module lt_u32_u32
  (
  ci,
  i0,
  i1,
  o
  );

  input ci;
  input [31:0] i0;
  input [31:0] i1;
  output o;



endmodule 

module ramm  // ram/ram.v(14)
  (
  di,
  raddr,
  waddr,
  wclk,
  we,
  do
  );

  input [31:0] di;  // ram/ram.v(23)
  input [3:0] raddr;  // ram/ram.v(25)
  input [3:0] waddr;  // ram/ram.v(24)
  input wclk;  // ram/ram.v(26)
  input we;  // ram/ram.v(26)
  output [31:0] do;  // ram/ram.v(28)

  parameter ADDR_WIDTH_R = 4;
  parameter ADDR_WIDTH_W = 4;
  parameter DATA_DEPTH_R = 12;
  parameter DATA_DEPTH_W = 12;
  parameter DATA_WIDTH_R = 32;
  parameter DATA_WIDTH_W = 32;

  EG_LOGIC_DRAM #(
    .ADDR_WIDTH_R(4),
    .ADDR_WIDTH_W(4),
    .DATA_DEPTH_R(12),
    .DATA_DEPTH_W(12),
    .DATA_WIDTH_R(32),
    .DATA_WIDTH_W(32),
    .INIT_FILE("ram.MIF"))
    dram (
    .di(di),
    .raddr(raddr),
    .waddr(waddr),
    .wclk(wclk),
    .we(we),
    .do(do));  // ram/ram.v(40)

endmodule 

module binary_mux_s1_w4
  (
  i0,
  i1,
  sel,
  o
  );

  input [3:0] i0;
  input [3:0] i1;
  input sel;
  output [3:0] o;



endmodule 

module top2  // top2.v(1)
  (
  clock,
  i_iodat,
  rst,
  memread,
  memwrite_cs,
  o_ioaddr,
  o_iodat
  );

  input clock;  // top2.v(3)
  input [31:0] i_iodat;  // top2.v(4)
  input rst;  // top2.v(3)
  output memread;  // top2.v(7)
  output memwrite_cs;  // top2.v(8)
  output [31:0] o_ioaddr;  // top2.v(9)
  output [31:0] o_iodat;  // top2.v(5)

  wire [31:0] instruction;  // top2.v(19)
  wire [31:0] memaddress;  // top2.v(15)
  wire [31:0] memreaddat;  // top2.v(16)
  wire [31:0] memstraddress;  // top2.v(17)
  wire [31:0] writedat;  // top2.v(18)
  wire bus_block;  // top2.v(13)
  wire instr_read;  // top2.v(14)
  wire instrnop;  // top2.v(12)
  wire memread_cs;  // top2.v(10)

  cpu a (
    .clock(clock),
    .i_bus_block(bus_block),
    .i_instr(instruction),
    .i_memreaddat(memreaddat),
    .rst(rst),
    .o_instrnop(instrnop),
    .o_memaddr(memaddress),
    .o_memread_cs(memread_cs),
    .o_memstraddr(memstraddress),
    .o_memwrite_cs(memwrite_cs),
    .o_memwritedat(writedat));  // top2.v(38)
  io busarbitration (
    .clock(clock),
    .i_instrnop(instrnop),
    .i_iodat(i_iodat),
    .i_memaddress(memaddress),
    .i_memread_cs(memread_cs),
    .i_memstraddress(memstraddress),
    .i_memwrite_cs(memwrite_cs),
    .i_writedat(writedat),
    .rst(rst),
    .o_bus_block(bus_block),
    .o_instr_read(instr_read),
    .o_instruction(instruction),
    .o_ioaddr(o_ioaddr),
    .o_iodat(o_iodat),
    .o_memreaddat(memreaddat));  // top2.v(22)
  or u0 (memread, instr_read, memread_cs);  // top2.v(21)

endmodule 

module cpu  // cpu.v(2)
  (
  clock,
  i_bus_block,
  i_instr,
  i_memreaddat,
  rst,
  o_instrnop,
  o_memaddr,
  o_memread_cs,
  o_memstraddr,
  o_memwrite_cs,
  o_memwritedat
  );

  input clock;  // cpu.v(4)
  input i_bus_block;  // cpu.v(5)
  input [31:0] i_instr;  // cpu.v(19)
  input [31:0] i_memreaddat;  // cpu.v(66)
  input rst;  // cpu.v(4)
  output o_instrnop;  // cpu.v(8)
  output [31:0] o_memaddr;  // cpu.v(62)
  output o_memread_cs;  // cpu.v(63)
  output [31:0] o_memstraddr;  // cpu.v(6)
  output o_memwrite_cs;  // cpu.v(64)
  output [31:0] o_memwritedat;  // cpu.v(65)

  wire [31:0] EX_A;  // cpu.v(47)
  wire [31:0] EX_B;  // cpu.v(48)
  wire [2:0] EX_fun3;  // cpu.v(49)
  wire [6:0] EX_fun7;  // cpu.v(41)
  wire [31:0] EX_memstraddr;  // cpu.v(38)
  wire [6:0] EX_op;  // cpu.v(42)
  wire [3:0] EX_operation;  // cpu.v(46)
  wire [4:0] EX_rd;  // cpu.v(45)
  wire [31:0] EX_regdat1;  // cpu.v(39)
  wire [31:0] EX_regdat2;  // cpu.v(40)
  wire [4:0] EX_rs1;  // cpu.v(43)
  wire [4:0] EX_rs2;  // cpu.v(44)
  wire [2:0] ID_fun3;  // cpu.v(21)
  wire [6:0] ID_fun7;  // cpu.v(22)
  wire [31:0] ID_jump_addr;  // cpu.v(28)
  wire [31:0] ID_jump_regdat1;  // cpu.v(29)
  wire [31:0] ID_jump_regdat2;  // cpu.v(30)
  wire [31:0] ID_memstraddr;  // cpu.v(26)
  wire [6:0] ID_op;  // cpu.v(20)
  wire [4:0] ID_rd;  // cpu.v(23)
  wire [31:0] ID_read_dat1;  // cpu.v(36)
  wire [31:0] ID_read_dat2;  // cpu.v(37)
  wire [4:0] ID_rs1;  // cpu.v(24)
  wire [4:0] ID_rs2;  // cpu.v(25)
  wire [2:0] IF_fun3;  // cpu.v(11)
  wire [6:0] IF_fun7;  // cpu.v(12)
  wire [6:0] IF_op;  // cpu.v(10)
  wire [4:0] IF_rd;  // cpu.v(13)
  wire [4:0] IF_rs1;  // cpu.v(14)
  wire [4:0] IF_rs2;  // cpu.v(15)
  wire [31:0] IF_skip_addr;  // cpu.v(17)
  wire [31:0] MEM_aludat;  // cpu.v(54)
  wire [2:0] MEM_fun3;  // cpu.v(58)
  wire [6:0] MEM_op;  // cpu.v(55)
  wire [4:0] MEM_rd;  // cpu.v(56)
  wire [31:0] MEM_regdat2;  // cpu.v(57)
  wire [6:0] WB_op;  // cpu.v(71)
  wire [4:0] WB_rd;  // cpu.v(70)
  wire [1:0] alu_A_select;  // cpu.v(33)
  wire [1:0] alu_B_select;  // cpu.v(34)
  wire [31:0] aludat;  // cpu.v(52)
  wire [31:0] memreaddat;  // cpu.v(67)
  wire [31:0] n39;
  wire [31:0] n40;
  wire [31:0] reg_writedat;  // cpu.v(68)
  wire ID_LW_block;  // cpu.v(32)
  wire ID_jump_cs;  // cpu.v(27)
  wire ID_jump_risk_block;  // cpu.v(31)
  wire IF_skip_cs;  // cpu.v(16)
  wire WB_regwritecs;  // cpu.v(69)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n34;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n4;
  wire n5;
  wire n6;
  wire n7;
  wire n8;
  wire n9;
  wire zero;  // cpu.v(53)

  alu alu (
    .i_A(EX_A),
    .i_B(EX_B),
    .i_operation(EX_operation),
    .o_aluout(aludat),
    .o_zero(zero));  // cpu.v(228)
  aluinput aluin (
    .i_MEM_aludat(MEM_aludat),
    .i_alu_A_select(alu_A_select),
    .i_alu_B_select(alu_B_select),
    .i_fun3(EX_fun3),
    .i_fun7(EX_fun7),
    .i_memstraddr(EX_memstraddr),
    .i_op(EX_op),
    .i_rd(EX_rd),
    .i_reg_writedat(reg_writedat),
    .i_regdat1(EX_regdat1),
    .i_regdat2(EX_regdat2),
    .i_rs1(EX_rs1),
    .i_rs2(EX_rs2),
    .o_A(EX_A),
    .o_B(EX_B),
    .o_operation(EX_operation));  // cpu.v(211)
  jump condition (
    .i_ID_jump_risk_block(ID_jump_risk_block),
    .i_fun3(ID_fun3),
    .i_fun7(ID_fun7),
    .i_op(ID_op),
    .i_rd(ID_rd),
    .i_regdat1(ID_jump_regdat1),
    .i_regdat2(ID_jump_regdat2),
    .i_rs2(ID_rs2),
    .o_jump_addr(ID_jump_addr),
    .o_jump_cs(ID_jump_cs));  // cpu.v(151)
  eq_w7 eq0 (
    .i0(ID_op),
    .i1(7'b0000011),
    .o(n0));  // cpu.v(178)
  eq_w5 eq1 (
    .i0(ID_rd),
    .i1(IF_rs1),
    .o(n3));  // cpu.v(180)
  eq_w3 eq10 (
    .i0(MEM_fun3),
    .i1(3'b001),
    .o(n36));  // cpu.v(298)
  eq_w3 eq11 (
    .i0(MEM_fun3),
    .i1(3'b010),
    .o(n37));  // cpu.v(299)
  eq_w5 eq2 (
    .i0(ID_rd),
    .i1(IF_rs2),
    .o(n4));  // cpu.v(181)
  eq_w5 eq3 (
    .i0(MEM_rd),
    .i1(EX_rs1),
    .o(n9));  // cpu.v(239)
  eq_w5 eq4 (
    .i0(WB_rd),
    .i1(EX_rs1),
    .o(n20));  // cpu.v(246)
  eq_w5 eq5 (
    .i0(MEM_rd),
    .i1(EX_rs2),
    .o(n24));  // cpu.v(256)
  eq_w5 eq6 (
    .i0(WB_rd),
    .i1(EX_rs2),
    .o(n28));  // cpu.v(263)
  eq_w7 eq7 (
    .i0(MEM_op),
    .i1(7'b0000011),
    .o(o_memread_cs));  // cpu.v(287)
  eq_w7 eq8 (
    .i0(MEM_op),
    .i1(7'b0100011),
    .o(o_memwrite_cs));  // cpu.v(287)
  eq_w3 eq9 (
    .i0(MEM_fun3),
    .i1(3'b000),
    .o(n35));  // cpu.v(297)
  EX_MEM_reg ex_mem (
    .clock(clock),
    .i_aludat(aludat),
    .i_aluzero(zero),
    .i_fun3(EX_fun3),
    .i_op(EX_op),
    .i_rd(EX_rd),
    .i_regdat2(EX_regdat2),
    .rst(rst),
    .o_aludat(MEM_aludat),
    .o_fun3(MEM_fun3),
    .o_op(MEM_op),
    .o_rd(MEM_rd),
    .o_regdat2(MEM_regdat2));  // cpu.v(269)
  ID_EX_reg id_ex (
    .clock(clock),
    .i_fun3(ID_fun3),
    .i_fun7(ID_fun7),
    .i_memstraddr(ID_memstraddr),
    .i_op(ID_op),
    .i_rd(ID_rd),
    .i_regdat1(ID_read_dat1),
    .i_regdat2(ID_read_dat2),
    .i_rs1(ID_rs1),
    .i_rs2(ID_rs2),
    .rst(rst),
    .o_fun3(EX_fun3),
    .o_fun7(EX_fun7),
    .o_memstraddr(EX_memstraddr),
    .o_op(EX_op),
    .o_rd(EX_rd),
    .o_regdat1(EX_regdat1),
    .o_regdat2(EX_regdat2),
    .o_rs1(EX_rs1),
    .o_rs2(EX_rs2));  // cpu.v(187)
  IF_ID_reg if_id (
    .clock(clock),
    .i_LW_block(ID_LW_block),
    .i_bus_block(i_bus_block),
    .i_fun3(IF_fun3),
    .i_fun7(IF_fun7),
    .i_instraddr(o_memstraddr),
    .i_instrnop(o_instrnop),
    .i_jump_cs(ID_jump_cs),
    .i_jump_risk_block(ID_jump_risk_block),
    .i_op(IF_op),
    .i_rd(IF_rd),
    .i_rs1(IF_rs1),
    .i_rs2(IF_rs2),
    .rst(rst),
    .o_fun3(ID_fun3),
    .o_fun7(ID_fun7),
    .o_instraddr(ID_memstraddr),
    .o_op(ID_op),
    .o_rd(ID_rd),
    .o_rs1(ID_rs1),
    .o_rs2(ID_rs2));  // cpu.v(109)
  PC instr (
    .clock(clock),
    .i_LW_block(ID_LW_block),
    .i_bus_block(i_bus_block),
    .i_jump_addr(ID_jump_addr),
    .i_jump_cs(ID_jump_cs),
    .i_jump_risk_block(ID_jump_risk_block),
    .i_memdat(memreaddat),
    .i_memread(o_memread_cs),
    .i_nowjumpstraddr(ID_memstraddr),
    .i_skip_addr(IF_skip_addr),
    .i_skip_cs(IF_skip_cs),
    .rst(rst),
    .o_instraddr(o_memstraddr),
    .o_instrnop(o_instrnop));  // cpu.v(73)
  coding instrcoding (
    .i_i_instr(i_instr),
    .o_fun3(IF_fun3),
    .o_fun7(IF_fun7),
    .o_op(IF_op),
    .o_rd(IF_rd),
    .o_rs1(IF_rs1),
    .o_rs2(IF_rs2));  // cpu.v(89)
  MEM_WB_reg mem_wb (
    .clock(clock),
    .i_aludat(MEM_aludat),
    .i_memdat(memreaddat),
    .i_op(MEM_op),
    .i_rd(MEM_rd),
    .rst(rst),
    .o_op(WB_op),
    .o_rd(WB_rd),
    .o_reg_writedat(reg_writedat),
    .o_regwritecs(WB_regwritecs));  // cpu.v(328)
  binary_mux_s1_w2 mux0 (
    .i0({n23,1'b0}),
    .i1(2'b01),
    .sel(n14),
    .o(alu_A_select));  // cpu.v(249)
  binary_mux_s1_w2 mux1 (
    .i0({n31,1'b0}),
    .i1(2'b01),
    .sel(n27),
    .o(alu_B_select));  // cpu.v(266)
  binary_mux_s1_w32 mux2 (
    .i0(32'b00000000000000000000000000000000),
    .i1(MEM_aludat),
    .sel(n34),
    .o(o_memaddr));  // cpu.v(290)
  binary_mux_s1_w32 mux3 (
    .i0(32'b00000000000000000000000000000000),
    .i1(n39),
    .sel(o_memwrite_cs),
    .o(o_memwritedat));  // cpu.v(306)
  binary_mux_s3_w32 mux4 (
    .i0({i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7],i_memreaddat[7:0]}),
    .i1({i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15],i_memreaddat[15:0]}),
    .i2(i_memreaddat),
    .i3(32'b00000000000000000000000000000000),
    .i4({24'b000000000000000000000000,i_memreaddat[7:0]}),
    .i5({16'b0000000000000000,i_memreaddat[15:0]}),
    .i6(32'b00000000000000000000000000000000),
    .i7(32'b00000000000000000000000000000000),
    .sel(MEM_fun3),
    .o(n40));  // cpu.v(320)
  binary_mux_s1_w32 mux5 (
    .i0(32'b00000000000000000000000000000000),
    .i1(n40),
    .sel(o_memread_cs),
    .o(memreaddat));  // cpu.v(326)
  ne_w7 neq0 (
    .i0(IF_op),
    .i1(7'b1100011),
    .o(n1));  // cpu.v(179)
  ne_w7 neq1 (
    .i0(MEM_op),
    .i1(7'b0100011),
    .o(n6));  // cpu.v(237)
  ne_w7 neq2 (
    .i0(MEM_op),
    .i1(7'b1100011),
    .o(n7));  // cpu.v(238)
  ne_w32 neq3 (
    .i0({27'b000000000000000000000000000,MEM_rd}),
    .i1(32'b00000000000000000000000000000000),
    .o(n11));  // cpu.v(240)
  ne_w7 neq4 (
    .i0(MEM_op),
    .i1(7'b0000011),
    .o(n13));  // cpu.v(241)
  ne_w7 neq5 (
    .i0(WB_op),
    .i1(7'b0100011),
    .o(n15));  // cpu.v(243)
  ne_w7 neq6 (
    .i0(WB_op),
    .i1(7'b1100011),
    .o(n16));  // cpu.v(244)
  ne_w32 neq7 (
    .i0({27'b000000000000000000000000000,WB_rd}),
    .i1(32'b00000000000000000000000000000000),
    .o(n18));  // cpu.v(245)
  ne_w5 neq8 (
    .i0(MEM_rd),
    .i1(EX_rs1),
    .o(n22));  // cpu.v(247)
  ne_w5 neq9 (
    .i0(MEM_rd),
    .i1(EX_rs2),
    .o(n30));  // cpu.v(264)
  register regfile (
    .i_clock(clock),
    .i_rd(WB_rd),
    .i_rs1(ID_rs1),
    .i_rs2(ID_rs2),
    .i_rst(rst),
    .i_write_cs(WB_regwritecs),
    .regdat(reg_writedat),
    .o_read_dat1(ID_read_dat1),
    .o_read_dat2(ID_read_dat2));  // cpu.v(164)
  jump_input risk_jump (
    .i_EX_aludat(aludat),
    .i_EX_op(EX_op),
    .i_EX_rd(EX_rd),
    .i_ID_reg_readdat1(ID_read_dat1),
    .i_ID_reg_readdat2(ID_read_dat2),
    .i_MEM_aludat(MEM_aludat),
    .i_MEM_op(MEM_op),
    .i_MEM_rd(MEM_rd),
    .i_WB_op(WB_op),
    .i_WB_rd(WB_rd),
    .i_op(ID_op),
    .i_reg_writedat(reg_writedat),
    .i_rs1(ID_rs1),
    .i_rs2(ID_rs2),
    .o_jump_risk_block(ID_jump_risk_block),
    .o_regdat1(ID_jump_regdat1),
    .o_regdat2(ID_jump_regdat2));  // cpu.v(132)
  onehot_mux_s4_w32 sel0 (
    .i0(32'b00000000000000000000000000000000),
    .i1(MEM_regdat2),
    .i2({16'b0000000000000000,MEM_regdat2[15:0]}),
    .i3({24'b000000000000000000000000,MEM_regdat2[7:0]}),
    .sel({n35,n36,n37,n38}),
    .o(n39));  // cpu.v(301)
  and u10 (n19, n17, n18);  // cpu.v(245)
  and u11 (n21, n19, n20);  // cpu.v(246)
  and u12 (n23, n21, n22);  // cpu.v(247)
  and u13 (n25, n8, n24);  // cpu.v(256)
  and u14 (n26, n25, n11);  // cpu.v(257)
  and u15 (n27, n26, n13);  // cpu.v(258)
  not u16 (n38, n33);  // cpu.v(301)
  and u17 (n29, n19, n28);  // cpu.v(263)
  and u18 (n31, n29, n30);  // cpu.v(264)
  or u19 (n34, o_memread_cs, o_memwrite_cs);  // cpu.v(287)
  and u2 (n2, n0, n1);  // cpu.v(179)
  or u20 (n33, n37, n32);  // cpu.v(301)
  or u21 (n32, n36, n35);  // cpu.v(301)
  or u3 (n5, n3, n4);  // cpu.v(181)
  and u4 (ID_LW_block, n2, n5);  // cpu.v(181)
  and u5 (n8, n6, n7);  // cpu.v(238)
  and u6 (n10, n8, n9);  // cpu.v(239)
  and u7 (n12, n10, n11);  // cpu.v(240)
  and u8 (n14, n12, n13);  // cpu.v(241)
  and u9 (n17, n15, n16);  // cpu.v(244)
  skip unconditional (
    .i_i_instr(i_instr),
    .i_op(IF_op),
    .o_skip_addr(IF_skip_addr),
    .o_skip_cs(IF_skip_cs));  // cpu.v(99)

endmodule 

module io  // io.v(1)
  (
  clock,
  i_instrnop,
  i_iodat,
  i_memaddress,
  i_memread_cs,
  i_memstraddress,
  i_memwrite_cs,
  i_writedat,
  rst,
  o_bus_block,
  o_instr_read,
  o_instruction,
  o_ioaddr,
  o_iodat,
  o_memreaddat
  );

  input clock;  // io.v(17)
  input i_instrnop;  // io.v(24)
  input [31:0] i_iodat;  // io.v(19)
  input [31:0] i_memaddress;  // io.v(20)
  input i_memread_cs;  // io.v(21)
  input [31:0] i_memstraddress;  // io.v(23)
  input i_memwrite_cs;  // io.v(22)
  input [31:0] i_writedat;  // io.v(25)
  input rst;  // io.v(18)
  output o_bus_block;  // io.v(27)
  output o_instr_read;  // io.v(28)
  output [31:0] o_instruction;  // io.v(29)
  output [31:0] o_ioaddr;  // io.v(31)
  output [31:0] o_iodat;  // io.v(26)
  output [31:0] o_memreaddat;  // io.v(30)

  wire [31:0] instruction;  // io.v(35)
  wire [31:0] n4;
  wire [31:0] n7;
  wire [31:0] n8;
  wire instr_read;  // io.v(34)
  wire n0;
  wire n1;
  wire n2;
  wire n3;
  wire n5;
  wire n6;

  eq_w1 eq0 (
    .i0(i_memread_cs),
    .i1(1'b1),
    .o(n5));  // io.v(50)
  eq_w1 eq1 (
    .i0(i_memwrite_cs),
    .i1(1'b1),
    .o(n6));  // io.v(50)
  binary_mux_s1_w32 mux0 (
    .i0(instruction),
    .i1(i_iodat),
    .sel(n3),
    .o(n4));  // io.v(45)
  binary_mux_s1_w32 mux1 (
    .i0(32'b00000000000000000000000000000000),
    .i1(i_iodat),
    .sel(n5),
    .o(n7));  // io.v(62)
  binary_mux_s1_w32 mux2 (
    .i0(i_writedat),
    .i1(32'b00000000000000000000000000000000),
    .sel(n5),
    .o(n8));  // io.v(62)
  binary_mux_s1_w32 mux3 (
    .i0(i_iodat),
    .i1(instruction),
    .sel(o_bus_block),
    .o(o_instruction));  // io.v(72)
  binary_mux_s1_w32 mux4 (
    .i0(i_memstraddress),
    .i1(i_memaddress),
    .sel(o_bus_block),
    .o(o_ioaddr));  // io.v(72)
  binary_mux_s1_w32 mux5 (
    .i0(32'b00000000000000000000000000000000),
    .i1(n7),
    .sel(o_bus_block),
    .o(o_memreaddat));  // io.v(72)
  binary_mux_s1_w32 mux6 (
    .i0(32'b00000000000000000000000000000000),
    .i1(n8),
    .sel(o_bus_block),
    .o(o_iodat));  // io.v(72)
  ne_w32 neq0 (
    .i0({31'b0000000000000000000000000000000,i_memread_cs}),
    .i1(32'b00000000000000000000000000000001),
    .o(n1));  // io.v(45)
  ne_w32 neq1 (
    .i0({31'b0000000000000000000000000000000,i_memwrite_cs}),
    .i1(32'b00000000000000000000000000000001),
    .o(n2));  // io.v(45)
  reg_ar_as_w32 reg0 (
    .clk(clock),
    .d(n4),
    .reset({n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0}),
    .set(32'b00000000000000000000000000000000),
    .q(instruction));  // io.v(45)
  buf u2 (o_instr_read, instr_read);  // io.v(37)
  not u3 (n0, rst);  // io.v(44)
  and u4 (n3, n1, n2);  // io.v(45)
  or u5 (o_bus_block, n5, n6);  // io.v(50)
  not u6 (instr_read, o_bus_block);  // io.v(72)

endmodule 

module alu  // alu.v(108)
  (
  i_A,
  i_B,
  i_operation,
  o_aluout,
  o_zero
  );

  input [31:0] i_A;  // alu.v(108)
  input [31:0] i_B;  // alu.v(108)
  input [3:0] i_operation;  // alu.v(108)
  output [31:0] o_aluout;  // alu.v(109)
  output o_zero;  // alu.v(109)

  wire [31:0] n10;
  wire [31:0] n11;
  wire [31:0] n12;
  wire [31:0] n13;
  wire [31:0] n14;
  wire [31:0] n15;
  wire [31:0] n48;
  wire [31:0] n49;
  wire [31:0] n5;
  wire [31:0] n6;
  wire [31:0] n7;
  wire n0;
  wire n1;
  wire n100;
  wire n101;
  wire n102;
  wire n103;
  wire n104;
  wire n105;
  wire n106;
  wire n107;
  wire n108;
  wire n109;
  wire n110;
  wire n111;
  wire n112;
  wire n113;
  wire n114;
  wire n115;
  wire n116;
  wire n117;
  wire n118;
  wire n119;
  wire n120;
  wire n121;
  wire n122;
  wire n123;
  wire n124;
  wire n125;
  wire n126;
  wire n127;
  wire n128;
  wire n129;
  wire n130;
  wire n131;
  wire n132;
  wire n133;
  wire n134;
  wire n135;
  wire n136;
  wire n137;
  wire n138;
  wire n139;
  wire n140;
  wire n141;
  wire n142;
  wire n143;
  wire n144;
  wire n145;
  wire n146;
  wire n147;
  wire n148;
  wire n149;
  wire n150;
  wire n151;
  wire n152;
  wire n153;
  wire n154;
  wire n155;
  wire n156;
  wire n157;
  wire n158;
  wire n159;
  wire n16;
  wire n160;
  wire n161;
  wire n162;
  wire n163;
  wire n164;
  wire n165;
  wire n166;
  wire n167;
  wire n168;
  wire n169;
  wire n17;
  wire n170;
  wire n171;
  wire n172;
  wire n173;
  wire n174;
  wire n175;
  wire n176;
  wire n177;
  wire n178;
  wire n179;
  wire n18;
  wire n180;
  wire n181;
  wire n182;
  wire n183;
  wire n184;
  wire n185;
  wire n186;
  wire n187;
  wire n188;
  wire n189;
  wire n19;
  wire n190;
  wire n191;
  wire n192;
  wire n193;
  wire n194;
  wire n195;
  wire n196;
  wire n197;
  wire n198;
  wire n199;
  wire n2;
  wire n20;
  wire n200;
  wire n201;
  wire n202;
  wire n203;
  wire n204;
  wire n205;
  wire n206;
  wire n207;
  wire n208;
  wire n209;
  wire n21;
  wire n210;
  wire n211;
  wire n212;
  wire n213;
  wire n214;
  wire n215;
  wire n216;
  wire n217;
  wire n218;
  wire n219;
  wire n22;
  wire n220;
  wire n221;
  wire n222;
  wire n223;
  wire n224;
  wire n225;
  wire n226;
  wire n227;
  wire n228;
  wire n229;
  wire n23;
  wire n230;
  wire n231;
  wire n232;
  wire n233;
  wire n234;
  wire n235;
  wire n236;
  wire n237;
  wire n238;
  wire n239;
  wire n24;
  wire n240;
  wire n241;
  wire n242;
  wire n243;
  wire n244;
  wire n245;
  wire n246;
  wire n247;
  wire n248;
  wire n249;
  wire n25;
  wire n250;
  wire n251;
  wire n252;
  wire n253;
  wire n254;
  wire n255;
  wire n256;
  wire n257;
  wire n258;
  wire n259;
  wire n26;
  wire n260;
  wire n261;
  wire n262;
  wire n263;
  wire n264;
  wire n265;
  wire n266;
  wire n267;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n34;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n4;
  wire n40;
  wire n41;
  wire n42;
  wire n43;
  wire n44;
  wire n45;
  wire n46;
  wire n47;
  wire n50;
  wire n51;
  wire n52;
  wire n53;
  wire n54;
  wire n55;
  wire n56;
  wire n57;
  wire n58;
  wire n59;
  wire n60;
  wire n61;
  wire n62;
  wire n63;
  wire n64;
  wire n65;
  wire n66;
  wire n67;
  wire n68;
  wire n69;
  wire n70;
  wire n71;
  wire n72;
  wire n73;
  wire n74;
  wire n75;
  wire n76;
  wire n77;
  wire n78;
  wire n79;
  wire n8;
  wire n80;
  wire n81;
  wire n82;
  wire n83;
  wire n84;
  wire n85;
  wire n86;
  wire n87;
  wire n88;
  wire n89;
  wire n9;
  wire n90;
  wire n91;
  wire n92;
  wire n93;
  wire n94;
  wire n95;
  wire n96;
  wire n97;
  wire n98;
  wire n99;

  add_pu32_pu32_o32 add0 (
    .i0(i_A),
    .i1(i_B),
    .o(n5));  // alu.v(115)
  eq_w32 eq0 (
    .i0(o_aluout),
    .i1(32'b00000000000000000000000000000000),
    .o(o_zero));  // alu.v(111)
  lt_u32_u32 lt0 (
    .ci(1'b0),
    .i0(i_A),
    .i1(i_B),
    .o(n8));  // alu.v(118)
  binary_mux_s4_w32 mux0 (
    .i0(n5),
    .i1(n7),
    .i10(32'b00000000000000000000000000000000),
    .i11(32'b00000000000000000000000000000000),
    .i12(32'b00000000000000000000000000000000),
    .i13(n15),
    .i14(32'b00000000000000000000000000000000),
    .i15(32'b00000000000000000000000000000000),
    .i2({31'b0000000000000000000000000000000,n8}),
    .i3({31'b0000000000000000000000000000000,n8}),
    .i4(n14),
    .i5(n15),
    .i6(n48),
    .i7(n49),
    .i8(n6),
    .i9(32'b00000000000000000000000000000000),
    .sel(i_operation),
    .o(o_aluout));  // alu.v(126)
  add_pu32_mu32_o32 sub0 (
    .i0(i_A),
    .i1(i_B),
    .o(n6));  // alu.v(116)
  or u1 (n14[4], n11[4], n13[4]);  // alu.v(123)
  and u10 (n13[0], i_A[0], n12[0]);  // alu.v(120)
  and u100 (n49[29], i_A[29], i_B[29]);  // alu.v(124)
  and u101 (n49[30], i_A[30], i_B[30]);  // alu.v(124)
  and u102 (n49[31], i_A[31], i_B[31]);  // alu.v(124)
  AL_MUX u103 (
    .i0(i_A[1]),
    .i1(i_A[2]),
    .sel(i_B[0]),
    .o(n46));  // alu.v(121)
  AL_MUX u104 (
    .i0(i_A[2]),
    .i1(i_A[3]),
    .sel(i_B[0]),
    .o(n45));  // alu.v(121)
  AL_MUX u105 (
    .i0(i_A[3]),
    .i1(i_A[4]),
    .sel(i_B[0]),
    .o(n44));  // alu.v(121)
  AL_MUX u106 (
    .i0(i_A[4]),
    .i1(i_A[5]),
    .sel(i_B[0]),
    .o(n43));  // alu.v(121)
  AL_MUX u107 (
    .i0(i_A[5]),
    .i1(i_A[6]),
    .sel(i_B[0]),
    .o(n42));  // alu.v(121)
  AL_MUX u108 (
    .i0(i_A[6]),
    .i1(i_A[7]),
    .sel(i_B[0]),
    .o(n41));  // alu.v(121)
  AL_MUX u109 (
    .i0(i_A[7]),
    .i1(i_A[8]),
    .sel(i_B[0]),
    .o(n40));  // alu.v(121)
  or u11 (n14[0], n11[0], n13[0]);  // alu.v(123)
  AL_MUX u110 (
    .i0(i_A[8]),
    .i1(i_A[9]),
    .sel(i_B[0]),
    .o(n39));  // alu.v(121)
  AL_MUX u111 (
    .i0(i_A[9]),
    .i1(i_A[10]),
    .sel(i_B[0]),
    .o(n38));  // alu.v(121)
  AL_MUX u112 (
    .i0(i_A[10]),
    .i1(i_A[11]),
    .sel(i_B[0]),
    .o(n37));  // alu.v(121)
  AL_MUX u113 (
    .i0(i_A[11]),
    .i1(i_A[12]),
    .sel(i_B[0]),
    .o(n36));  // alu.v(121)
  AL_MUX u114 (
    .i0(i_A[12]),
    .i1(i_A[13]),
    .sel(i_B[0]),
    .o(n35));  // alu.v(121)
  AL_MUX u115 (
    .i0(i_A[13]),
    .i1(i_A[14]),
    .sel(i_B[0]),
    .o(n34));  // alu.v(121)
  AL_MUX u116 (
    .i0(i_A[14]),
    .i1(i_A[15]),
    .sel(i_B[0]),
    .o(n33));  // alu.v(121)
  AL_MUX u117 (
    .i0(i_A[15]),
    .i1(i_A[16]),
    .sel(i_B[0]),
    .o(n32));  // alu.v(121)
  AL_MUX u118 (
    .i0(i_A[16]),
    .i1(i_A[17]),
    .sel(i_B[0]),
    .o(n31));  // alu.v(121)
  AL_MUX u119 (
    .i0(i_A[17]),
    .i1(i_A[18]),
    .sel(i_B[0]),
    .o(n30));  // alu.v(121)
  or u12 (n14[5], n11[5], n13[5]);  // alu.v(123)
  AL_MUX u120 (
    .i0(i_A[18]),
    .i1(i_A[19]),
    .sel(i_B[0]),
    .o(n29));  // alu.v(121)
  AL_MUX u121 (
    .i0(i_A[19]),
    .i1(i_A[20]),
    .sel(i_B[0]),
    .o(n28));  // alu.v(121)
  AL_MUX u122 (
    .i0(i_A[20]),
    .i1(i_A[21]),
    .sel(i_B[0]),
    .o(n27));  // alu.v(121)
  AL_MUX u123 (
    .i0(i_A[21]),
    .i1(i_A[22]),
    .sel(i_B[0]),
    .o(n26));  // alu.v(121)
  AL_MUX u124 (
    .i0(i_A[22]),
    .i1(i_A[23]),
    .sel(i_B[0]),
    .o(n25));  // alu.v(121)
  AL_MUX u125 (
    .i0(i_A[23]),
    .i1(i_A[24]),
    .sel(i_B[0]),
    .o(n24));  // alu.v(121)
  AL_MUX u126 (
    .i0(i_A[24]),
    .i1(i_A[25]),
    .sel(i_B[0]),
    .o(n23));  // alu.v(121)
  AL_MUX u127 (
    .i0(i_A[25]),
    .i1(i_A[26]),
    .sel(i_B[0]),
    .o(n22));  // alu.v(121)
  AL_MUX u128 (
    .i0(i_A[26]),
    .i1(i_A[27]),
    .sel(i_B[0]),
    .o(n21));  // alu.v(121)
  AL_MUX u129 (
    .i0(i_A[27]),
    .i1(i_A[28]),
    .sel(i_B[0]),
    .o(n20));  // alu.v(121)
  AL_MUX u13 (
    .i0(i_A[0]),
    .i1(i_A[1]),
    .sel(i_B[0]),
    .o(n47));  // alu.v(121)
  AL_MUX u130 (
    .i0(i_A[28]),
    .i1(i_A[29]),
    .sel(i_B[0]),
    .o(n19));  // alu.v(121)
  AL_MUX u131 (
    .i0(i_A[29]),
    .i1(i_A[30]),
    .sel(i_B[0]),
    .o(n18));  // alu.v(121)
  AL_MUX u132 (
    .i0(i_A[30]),
    .i1(i_A[31]),
    .sel(i_B[0]),
    .o(n17));  // alu.v(121)
  AL_MUX u133 (
    .i0(i_A[31]),
    .i1(1'b0),
    .sel(i_B[0]),
    .o(n16));  // alu.v(121)
  AL_MUX u134 (
    .i0(n47),
    .i1(n45),
    .sel(i_B[1]),
    .o(n9));  // alu.v(121)
  AL_MUX u135 (
    .i0(n46),
    .i1(n44),
    .sel(i_B[1]),
    .o(n4));  // alu.v(121)
  AL_MUX u136 (
    .i0(n45),
    .i1(n43),
    .sel(i_B[1]),
    .o(n2));  // alu.v(121)
  AL_MUX u137 (
    .i0(n44),
    .i1(n42),
    .sel(i_B[1]),
    .o(n1));  // alu.v(121)
  AL_MUX u138 (
    .i0(n43),
    .i1(n41),
    .sel(i_B[1]),
    .o(n0));  // alu.v(121)
  AL_MUX u139 (
    .i0(n42),
    .i1(n40),
    .sel(i_B[1]),
    .o(n3));  // alu.v(121)
  and u14 (n49[0], i_A[0], i_B[0]);  // alu.v(124)
  AL_MUX u140 (
    .i0(n41),
    .i1(n39),
    .sel(i_B[1]),
    .o(n81));  // alu.v(121)
  AL_MUX u141 (
    .i0(n40),
    .i1(n38),
    .sel(i_B[1]),
    .o(n80));  // alu.v(121)
  AL_MUX u142 (
    .i0(n39),
    .i1(n37),
    .sel(i_B[1]),
    .o(n79));  // alu.v(121)
  AL_MUX u143 (
    .i0(n38),
    .i1(n36),
    .sel(i_B[1]),
    .o(n78));  // alu.v(121)
  AL_MUX u144 (
    .i0(n37),
    .i1(n35),
    .sel(i_B[1]),
    .o(n77));  // alu.v(121)
  AL_MUX u145 (
    .i0(n36),
    .i1(n34),
    .sel(i_B[1]),
    .o(n76));  // alu.v(121)
  AL_MUX u146 (
    .i0(n35),
    .i1(n33),
    .sel(i_B[1]),
    .o(n75));  // alu.v(121)
  AL_MUX u147 (
    .i0(n34),
    .i1(n32),
    .sel(i_B[1]),
    .o(n74));  // alu.v(121)
  AL_MUX u148 (
    .i0(n33),
    .i1(n31),
    .sel(i_B[1]),
    .o(n73));  // alu.v(121)
  AL_MUX u149 (
    .i0(n32),
    .i1(n30),
    .sel(i_B[1]),
    .o(n72));  // alu.v(121)
  or u15 (n14[7], n11[7], n13[7]);  // alu.v(123)
  AL_MUX u150 (
    .i0(n31),
    .i1(n29),
    .sel(i_B[1]),
    .o(n71));  // alu.v(121)
  AL_MUX u151 (
    .i0(n30),
    .i1(n28),
    .sel(i_B[1]),
    .o(n70));  // alu.v(121)
  AL_MUX u152 (
    .i0(n29),
    .i1(n27),
    .sel(i_B[1]),
    .o(n69));  // alu.v(121)
  AL_MUX u153 (
    .i0(n28),
    .i1(n26),
    .sel(i_B[1]),
    .o(n68));  // alu.v(121)
  AL_MUX u154 (
    .i0(n27),
    .i1(n25),
    .sel(i_B[1]),
    .o(n67));  // alu.v(121)
  AL_MUX u155 (
    .i0(n26),
    .i1(n24),
    .sel(i_B[1]),
    .o(n66));  // alu.v(121)
  AL_MUX u156 (
    .i0(n25),
    .i1(n23),
    .sel(i_B[1]),
    .o(n65));  // alu.v(121)
  AL_MUX u157 (
    .i0(n24),
    .i1(n22),
    .sel(i_B[1]),
    .o(n64));  // alu.v(121)
  AL_MUX u158 (
    .i0(n23),
    .i1(n21),
    .sel(i_B[1]),
    .o(n63));  // alu.v(121)
  AL_MUX u159 (
    .i0(n22),
    .i1(n20),
    .sel(i_B[1]),
    .o(n62));  // alu.v(121)
  or u16 (n14[8], n11[8], n13[8]);  // alu.v(123)
  AL_MUX u160 (
    .i0(n21),
    .i1(n19),
    .sel(i_B[1]),
    .o(n61));  // alu.v(121)
  AL_MUX u161 (
    .i0(n20),
    .i1(n18),
    .sel(i_B[1]),
    .o(n60));  // alu.v(121)
  AL_MUX u162 (
    .i0(n19),
    .i1(n17),
    .sel(i_B[1]),
    .o(n59));  // alu.v(121)
  AL_MUX u163 (
    .i0(n18),
    .i1(n16),
    .sel(i_B[1]),
    .o(n58));  // alu.v(121)
  AL_MUX u164 (
    .i0(n17),
    .i1(1'b0),
    .sel(i_B[1]),
    .o(n57));  // alu.v(121)
  AL_MUX u165 (
    .i0(n16),
    .i1(1'b0),
    .sel(i_B[1]),
    .o(n56));  // alu.v(121)
  AL_MUX u166 (
    .i0(n9),
    .i1(n0),
    .sel(i_B[2]),
    .o(n55));  // alu.v(121)
  AL_MUX u167 (
    .i0(n4),
    .i1(n3),
    .sel(i_B[2]),
    .o(n54));  // alu.v(121)
  AL_MUX u168 (
    .i0(n2),
    .i1(n81),
    .sel(i_B[2]),
    .o(n53));  // alu.v(121)
  AL_MUX u169 (
    .i0(n1),
    .i1(n80),
    .sel(i_B[2]),
    .o(n52));  // alu.v(121)
  or u17 (n14[9], n11[9], n13[9]);  // alu.v(123)
  AL_MUX u170 (
    .i0(n0),
    .i1(n79),
    .sel(i_B[2]),
    .o(n51));  // alu.v(121)
  AL_MUX u171 (
    .i0(n3),
    .i1(n78),
    .sel(i_B[2]),
    .o(n50));  // alu.v(121)
  AL_MUX u172 (
    .i0(n81),
    .i1(n77),
    .sel(i_B[2]),
    .o(n82));  // alu.v(121)
  AL_MUX u173 (
    .i0(n80),
    .i1(n76),
    .sel(i_B[2]),
    .o(n83));  // alu.v(121)
  AL_MUX u174 (
    .i0(n79),
    .i1(n75),
    .sel(i_B[2]),
    .o(n84));  // alu.v(121)
  AL_MUX u175 (
    .i0(n78),
    .i1(n74),
    .sel(i_B[2]),
    .o(n85));  // alu.v(121)
  AL_MUX u176 (
    .i0(n77),
    .i1(n73),
    .sel(i_B[2]),
    .o(n86));  // alu.v(121)
  AL_MUX u177 (
    .i0(n76),
    .i1(n72),
    .sel(i_B[2]),
    .o(n87));  // alu.v(121)
  AL_MUX u178 (
    .i0(n75),
    .i1(n71),
    .sel(i_B[2]),
    .o(n88));  // alu.v(121)
  AL_MUX u179 (
    .i0(n74),
    .i1(n70),
    .sel(i_B[2]),
    .o(n89));  // alu.v(121)
  or u18 (n14[10], n11[10], n13[10]);  // alu.v(123)
  AL_MUX u180 (
    .i0(n73),
    .i1(n69),
    .sel(i_B[2]),
    .o(n90));  // alu.v(121)
  AL_MUX u181 (
    .i0(n72),
    .i1(n68),
    .sel(i_B[2]),
    .o(n91));  // alu.v(121)
  AL_MUX u182 (
    .i0(n71),
    .i1(n67),
    .sel(i_B[2]),
    .o(n92));  // alu.v(121)
  AL_MUX u183 (
    .i0(n70),
    .i1(n66),
    .sel(i_B[2]),
    .o(n93));  // alu.v(121)
  AL_MUX u184 (
    .i0(n69),
    .i1(n65),
    .sel(i_B[2]),
    .o(n94));  // alu.v(121)
  AL_MUX u185 (
    .i0(n68),
    .i1(n64),
    .sel(i_B[2]),
    .o(n95));  // alu.v(121)
  AL_MUX u186 (
    .i0(n67),
    .i1(n63),
    .sel(i_B[2]),
    .o(n96));  // alu.v(121)
  AL_MUX u187 (
    .i0(n66),
    .i1(n62),
    .sel(i_B[2]),
    .o(n97));  // alu.v(121)
  AL_MUX u188 (
    .i0(n65),
    .i1(n61),
    .sel(i_B[2]),
    .o(n98));  // alu.v(121)
  AL_MUX u189 (
    .i0(n64),
    .i1(n60),
    .sel(i_B[2]),
    .o(n99));  // alu.v(121)
  or u19 (n14[11], n11[11], n13[11]);  // alu.v(123)
  AL_MUX u190 (
    .i0(n63),
    .i1(n59),
    .sel(i_B[2]),
    .o(n100));  // alu.v(121)
  AL_MUX u191 (
    .i0(n62),
    .i1(n58),
    .sel(i_B[2]),
    .o(n101));  // alu.v(121)
  AL_MUX u192 (
    .i0(n61),
    .i1(n57),
    .sel(i_B[2]),
    .o(n102));  // alu.v(121)
  AL_MUX u193 (
    .i0(n60),
    .i1(n56),
    .sel(i_B[2]),
    .o(n103));  // alu.v(121)
  AL_MUX u194 (
    .i0(n59),
    .i1(1'b0),
    .sel(i_B[2]),
    .o(n104));  // alu.v(121)
  AL_MUX u195 (
    .i0(n58),
    .i1(1'b0),
    .sel(i_B[2]),
    .o(n105));  // alu.v(121)
  AL_MUX u196 (
    .i0(n57),
    .i1(1'b0),
    .sel(i_B[2]),
    .o(n106));  // alu.v(121)
  AL_MUX u197 (
    .i0(n56),
    .i1(1'b0),
    .sel(i_B[2]),
    .o(n107));  // alu.v(121)
  AL_MUX u198 (
    .i0(n55),
    .i1(n84),
    .sel(i_B[3]),
    .o(n108));  // alu.v(121)
  AL_MUX u199 (
    .i0(n54),
    .i1(n85),
    .sel(i_B[3]),
    .o(n109));  // alu.v(121)
  or u2 (n14[3], n11[3], n13[3]);  // alu.v(123)
  or u20 (n14[12], n11[12], n13[12]);  // alu.v(123)
  AL_MUX u200 (
    .i0(n53),
    .i1(n86),
    .sel(i_B[3]),
    .o(n110));  // alu.v(121)
  AL_MUX u201 (
    .i0(n52),
    .i1(n87),
    .sel(i_B[3]),
    .o(n111));  // alu.v(121)
  AL_MUX u202 (
    .i0(n51),
    .i1(n88),
    .sel(i_B[3]),
    .o(n112));  // alu.v(121)
  AL_MUX u203 (
    .i0(n50),
    .i1(n89),
    .sel(i_B[3]),
    .o(n113));  // alu.v(121)
  AL_MUX u204 (
    .i0(n82),
    .i1(n90),
    .sel(i_B[3]),
    .o(n114));  // alu.v(121)
  AL_MUX u205 (
    .i0(n83),
    .i1(n91),
    .sel(i_B[3]),
    .o(n115));  // alu.v(121)
  AL_MUX u206 (
    .i0(n84),
    .i1(n92),
    .sel(i_B[3]),
    .o(n116));  // alu.v(121)
  AL_MUX u207 (
    .i0(n85),
    .i1(n93),
    .sel(i_B[3]),
    .o(n117));  // alu.v(121)
  AL_MUX u208 (
    .i0(n86),
    .i1(n94),
    .sel(i_B[3]),
    .o(n118));  // alu.v(121)
  AL_MUX u209 (
    .i0(n87),
    .i1(n95),
    .sel(i_B[3]),
    .o(n119));  // alu.v(121)
  or u21 (n14[13], n11[13], n13[13]);  // alu.v(123)
  AL_MUX u210 (
    .i0(n88),
    .i1(n96),
    .sel(i_B[3]),
    .o(n120));  // alu.v(121)
  AL_MUX u211 (
    .i0(n89),
    .i1(n97),
    .sel(i_B[3]),
    .o(n121));  // alu.v(121)
  AL_MUX u212 (
    .i0(n90),
    .i1(n98),
    .sel(i_B[3]),
    .o(n122));  // alu.v(121)
  AL_MUX u213 (
    .i0(n91),
    .i1(n99),
    .sel(i_B[3]),
    .o(n123));  // alu.v(121)
  AL_MUX u214 (
    .i0(n92),
    .i1(n100),
    .sel(i_B[3]),
    .o(n124));  // alu.v(121)
  AL_MUX u215 (
    .i0(n93),
    .i1(n101),
    .sel(i_B[3]),
    .o(n125));  // alu.v(121)
  AL_MUX u216 (
    .i0(n94),
    .i1(n102),
    .sel(i_B[3]),
    .o(n126));  // alu.v(121)
  AL_MUX u217 (
    .i0(n95),
    .i1(n103),
    .sel(i_B[3]),
    .o(n127));  // alu.v(121)
  AL_MUX u218 (
    .i0(n96),
    .i1(n104),
    .sel(i_B[3]),
    .o(n128));  // alu.v(121)
  AL_MUX u219 (
    .i0(n97),
    .i1(n105),
    .sel(i_B[3]),
    .o(n129));  // alu.v(121)
  or u22 (n14[14], n11[14], n13[14]);  // alu.v(123)
  AL_MUX u220 (
    .i0(n98),
    .i1(n106),
    .sel(i_B[3]),
    .o(n130));  // alu.v(121)
  AL_MUX u221 (
    .i0(n99),
    .i1(n107),
    .sel(i_B[3]),
    .o(n131));  // alu.v(121)
  AL_MUX u222 (
    .i0(n100),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n132));  // alu.v(121)
  AL_MUX u223 (
    .i0(n101),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n133));  // alu.v(121)
  AL_MUX u224 (
    .i0(n102),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n134));  // alu.v(121)
  AL_MUX u225 (
    .i0(n103),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n135));  // alu.v(121)
  AL_MUX u226 (
    .i0(n104),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n136));  // alu.v(121)
  AL_MUX u227 (
    .i0(n105),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n137));  // alu.v(121)
  AL_MUX u228 (
    .i0(n106),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n138));  // alu.v(121)
  AL_MUX u229 (
    .i0(n107),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n139));  // alu.v(121)
  or u23 (n14[15], n11[15], n13[15]);  // alu.v(123)
  AL_MUX u230 (
    .i0(n108),
    .i1(n124),
    .sel(i_B[4]),
    .o(n15[0]));  // alu.v(121)
  AL_MUX u231 (
    .i0(n109),
    .i1(n125),
    .sel(i_B[4]),
    .o(n15[1]));  // alu.v(121)
  AL_MUX u232 (
    .i0(n110),
    .i1(n126),
    .sel(i_B[4]),
    .o(n15[2]));  // alu.v(121)
  AL_MUX u233 (
    .i0(n111),
    .i1(n127),
    .sel(i_B[4]),
    .o(n15[3]));  // alu.v(121)
  AL_MUX u234 (
    .i0(n112),
    .i1(n128),
    .sel(i_B[4]),
    .o(n15[4]));  // alu.v(121)
  AL_MUX u235 (
    .i0(n113),
    .i1(n129),
    .sel(i_B[4]),
    .o(n15[5]));  // alu.v(121)
  AL_MUX u236 (
    .i0(n114),
    .i1(n130),
    .sel(i_B[4]),
    .o(n15[6]));  // alu.v(121)
  AL_MUX u237 (
    .i0(n115),
    .i1(n131),
    .sel(i_B[4]),
    .o(n15[7]));  // alu.v(121)
  AL_MUX u238 (
    .i0(n116),
    .i1(n132),
    .sel(i_B[4]),
    .o(n15[8]));  // alu.v(121)
  AL_MUX u239 (
    .i0(n117),
    .i1(n133),
    .sel(i_B[4]),
    .o(n15[9]));  // alu.v(121)
  or u24 (n14[16], n11[16], n13[16]);  // alu.v(123)
  AL_MUX u240 (
    .i0(n118),
    .i1(n134),
    .sel(i_B[4]),
    .o(n15[10]));  // alu.v(121)
  AL_MUX u241 (
    .i0(n119),
    .i1(n135),
    .sel(i_B[4]),
    .o(n15[11]));  // alu.v(121)
  AL_MUX u242 (
    .i0(n120),
    .i1(n136),
    .sel(i_B[4]),
    .o(n15[12]));  // alu.v(121)
  AL_MUX u243 (
    .i0(n121),
    .i1(n137),
    .sel(i_B[4]),
    .o(n15[13]));  // alu.v(121)
  AL_MUX u244 (
    .i0(n122),
    .i1(n138),
    .sel(i_B[4]),
    .o(n15[14]));  // alu.v(121)
  AL_MUX u245 (
    .i0(n123),
    .i1(n139),
    .sel(i_B[4]),
    .o(n15[15]));  // alu.v(121)
  AL_MUX u246 (
    .i0(n124),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[16]));  // alu.v(121)
  AL_MUX u247 (
    .i0(n125),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[17]));  // alu.v(121)
  AL_MUX u248 (
    .i0(n126),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[18]));  // alu.v(121)
  AL_MUX u249 (
    .i0(n127),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[19]));  // alu.v(121)
  or u25 (n14[17], n11[17], n13[17]);  // alu.v(123)
  AL_MUX u250 (
    .i0(n128),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[20]));  // alu.v(121)
  AL_MUX u251 (
    .i0(n129),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[21]));  // alu.v(121)
  AL_MUX u252 (
    .i0(n130),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[22]));  // alu.v(121)
  AL_MUX u253 (
    .i0(n131),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[23]));  // alu.v(121)
  AL_MUX u254 (
    .i0(n132),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[24]));  // alu.v(121)
  AL_MUX u255 (
    .i0(n133),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[25]));  // alu.v(121)
  AL_MUX u256 (
    .i0(n134),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[26]));  // alu.v(121)
  AL_MUX u257 (
    .i0(n135),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[27]));  // alu.v(121)
  AL_MUX u258 (
    .i0(n136),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[28]));  // alu.v(121)
  AL_MUX u259 (
    .i0(n137),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[29]));  // alu.v(121)
  or u26 (n14[18], n11[18], n13[18]);  // alu.v(123)
  AL_MUX u260 (
    .i0(n138),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[30]));  // alu.v(121)
  AL_MUX u261 (
    .i0(n139),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n15[31]));  // alu.v(121)
  and u262 (n13[1], i_A[1], n12[1]);  // alu.v(120)
  and u263 (n13[2], i_A[2], n12[2]);  // alu.v(120)
  and u264 (n13[3], i_A[3], n12[3]);  // alu.v(120)
  and u265 (n13[4], i_A[4], n12[4]);  // alu.v(120)
  and u266 (n13[5], i_A[5], n12[5]);  // alu.v(120)
  and u267 (n13[6], i_A[6], n12[6]);  // alu.v(120)
  and u268 (n13[7], i_A[7], n12[7]);  // alu.v(120)
  and u269 (n13[8], i_A[8], n12[8]);  // alu.v(120)
  or u27 (n14[19], n11[19], n13[19]);  // alu.v(123)
  and u270 (n13[9], i_A[9], n12[9]);  // alu.v(120)
  and u271 (n13[10], i_A[10], n12[10]);  // alu.v(120)
  and u272 (n13[11], i_A[11], n12[11]);  // alu.v(120)
  and u273 (n13[12], i_A[12], n12[12]);  // alu.v(120)
  and u274 (n13[13], i_A[13], n12[13]);  // alu.v(120)
  and u275 (n13[14], i_A[14], n12[14]);  // alu.v(120)
  and u276 (n13[15], i_A[15], n12[15]);  // alu.v(120)
  and u277 (n13[16], i_A[16], n12[16]);  // alu.v(120)
  and u278 (n13[17], i_A[17], n12[17]);  // alu.v(120)
  and u279 (n13[18], i_A[18], n12[18]);  // alu.v(120)
  or u28 (n14[20], n11[20], n13[20]);  // alu.v(123)
  and u280 (n13[19], i_A[19], n12[19]);  // alu.v(120)
  and u281 (n13[20], i_A[20], n12[20]);  // alu.v(120)
  and u282 (n13[21], i_A[21], n12[21]);  // alu.v(120)
  and u283 (n13[22], i_A[22], n12[22]);  // alu.v(120)
  and u284 (n13[23], i_A[23], n12[23]);  // alu.v(120)
  and u285 (n13[24], i_A[24], n12[24]);  // alu.v(120)
  and u286 (n13[25], i_A[25], n12[25]);  // alu.v(120)
  and u287 (n13[26], i_A[26], n12[26]);  // alu.v(120)
  and u288 (n13[27], i_A[27], n12[27]);  // alu.v(120)
  and u289 (n13[28], i_A[28], n12[28]);  // alu.v(120)
  or u29 (n14[21], n11[21], n13[21]);  // alu.v(123)
  and u290 (n13[29], i_A[29], n12[29]);  // alu.v(120)
  and u291 (n13[30], i_A[30], n12[30]);  // alu.v(120)
  and u292 (n13[31], i_A[31], n12[31]);  // alu.v(120)
  not u293 (n12[1], i_B[1]);  // alu.v(120)
  not u294 (n12[2], i_B[2]);  // alu.v(120)
  not u295 (n12[3], i_B[3]);  // alu.v(120)
  not u296 (n12[4], i_B[4]);  // alu.v(120)
  not u297 (n12[5], i_B[5]);  // alu.v(120)
  not u298 (n12[6], i_B[6]);  // alu.v(120)
  not u299 (n12[7], i_B[7]);  // alu.v(120)
  or u3 (n14[2], n11[2], n13[2]);  // alu.v(123)
  or u30 (n14[22], n11[22], n13[22]);  // alu.v(123)
  not u300 (n12[8], i_B[8]);  // alu.v(120)
  not u301 (n12[9], i_B[9]);  // alu.v(120)
  not u302 (n12[10], i_B[10]);  // alu.v(120)
  not u303 (n12[11], i_B[11]);  // alu.v(120)
  not u304 (n12[12], i_B[12]);  // alu.v(120)
  not u305 (n12[13], i_B[13]);  // alu.v(120)
  not u306 (n12[14], i_B[14]);  // alu.v(120)
  not u307 (n12[15], i_B[15]);  // alu.v(120)
  not u308 (n12[16], i_B[16]);  // alu.v(120)
  not u309 (n12[17], i_B[17]);  // alu.v(120)
  or u31 (n14[23], n11[23], n13[23]);  // alu.v(123)
  not u310 (n12[18], i_B[18]);  // alu.v(120)
  not u311 (n12[19], i_B[19]);  // alu.v(120)
  not u312 (n12[20], i_B[20]);  // alu.v(120)
  not u313 (n12[21], i_B[21]);  // alu.v(120)
  not u314 (n12[22], i_B[22]);  // alu.v(120)
  not u315 (n12[23], i_B[23]);  // alu.v(120)
  not u316 (n12[24], i_B[24]);  // alu.v(120)
  not u317 (n12[25], i_B[25]);  // alu.v(120)
  not u318 (n12[26], i_B[26]);  // alu.v(120)
  not u319 (n12[27], i_B[27]);  // alu.v(120)
  or u32 (n14[24], n11[24], n13[24]);  // alu.v(123)
  not u320 (n12[28], i_B[28]);  // alu.v(120)
  not u321 (n12[29], i_B[29]);  // alu.v(120)
  not u322 (n12[30], i_B[30]);  // alu.v(120)
  not u323 (n12[31], i_B[31]);  // alu.v(120)
  and u324 (n11[1], n10[1], i_B[1]);  // alu.v(120)
  and u325 (n11[2], n10[2], i_B[2]);  // alu.v(120)
  and u326 (n11[3], n10[3], i_B[3]);  // alu.v(120)
  and u327 (n11[4], n10[4], i_B[4]);  // alu.v(120)
  and u328 (n11[5], n10[5], i_B[5]);  // alu.v(120)
  and u329 (n11[6], n10[6], i_B[6]);  // alu.v(120)
  or u33 (n14[25], n11[25], n13[25]);  // alu.v(123)
  and u330 (n11[7], n10[7], i_B[7]);  // alu.v(120)
  and u331 (n11[8], n10[8], i_B[8]);  // alu.v(120)
  and u332 (n11[9], n10[9], i_B[9]);  // alu.v(120)
  and u333 (n11[10], n10[10], i_B[10]);  // alu.v(120)
  and u334 (n11[11], n10[11], i_B[11]);  // alu.v(120)
  and u335 (n11[12], n10[12], i_B[12]);  // alu.v(120)
  and u336 (n11[13], n10[13], i_B[13]);  // alu.v(120)
  and u337 (n11[14], n10[14], i_B[14]);  // alu.v(120)
  and u338 (n11[15], n10[15], i_B[15]);  // alu.v(120)
  and u339 (n11[16], n10[16], i_B[16]);  // alu.v(120)
  or u34 (n14[26], n11[26], n13[26]);  // alu.v(123)
  and u340 (n11[17], n10[17], i_B[17]);  // alu.v(120)
  and u341 (n11[18], n10[18], i_B[18]);  // alu.v(120)
  and u342 (n11[19], n10[19], i_B[19]);  // alu.v(120)
  and u343 (n11[20], n10[20], i_B[20]);  // alu.v(120)
  and u344 (n11[21], n10[21], i_B[21]);  // alu.v(120)
  and u345 (n11[22], n10[22], i_B[22]);  // alu.v(120)
  and u346 (n11[23], n10[23], i_B[23]);  // alu.v(120)
  and u347 (n11[24], n10[24], i_B[24]);  // alu.v(120)
  and u348 (n11[25], n10[25], i_B[25]);  // alu.v(120)
  and u349 (n11[26], n10[26], i_B[26]);  // alu.v(120)
  or u35 (n14[27], n11[27], n13[27]);  // alu.v(123)
  and u350 (n11[27], n10[27], i_B[27]);  // alu.v(120)
  and u351 (n11[28], n10[28], i_B[28]);  // alu.v(120)
  and u352 (n11[29], n10[29], i_B[29]);  // alu.v(120)
  and u353 (n11[30], n10[30], i_B[30]);  // alu.v(120)
  and u354 (n11[31], n10[31], i_B[31]);  // alu.v(120)
  not u355 (n10[1], i_A[1]);  // alu.v(120)
  not u356 (n10[2], i_A[2]);  // alu.v(120)
  not u357 (n10[3], i_A[3]);  // alu.v(120)
  not u358 (n10[4], i_A[4]);  // alu.v(120)
  not u359 (n10[5], i_A[5]);  // alu.v(120)
  or u36 (n14[28], n11[28], n13[28]);  // alu.v(123)
  not u360 (n10[6], i_A[6]);  // alu.v(120)
  not u361 (n10[7], i_A[7]);  // alu.v(120)
  not u362 (n10[8], i_A[8]);  // alu.v(120)
  not u363 (n10[9], i_A[9]);  // alu.v(120)
  not u364 (n10[10], i_A[10]);  // alu.v(120)
  not u365 (n10[11], i_A[11]);  // alu.v(120)
  not u366 (n10[12], i_A[12]);  // alu.v(120)
  not u367 (n10[13], i_A[13]);  // alu.v(120)
  not u368 (n10[14], i_A[14]);  // alu.v(120)
  not u369 (n10[15], i_A[15]);  // alu.v(120)
  or u37 (n14[29], n11[29], n13[29]);  // alu.v(123)
  not u370 (n10[16], i_A[16]);  // alu.v(120)
  not u371 (n10[17], i_A[17]);  // alu.v(120)
  not u372 (n10[18], i_A[18]);  // alu.v(120)
  not u373 (n10[19], i_A[19]);  // alu.v(120)
  not u374 (n10[20], i_A[20]);  // alu.v(120)
  not u375 (n10[21], i_A[21]);  // alu.v(120)
  not u376 (n10[22], i_A[22]);  // alu.v(120)
  not u377 (n10[23], i_A[23]);  // alu.v(120)
  not u378 (n10[24], i_A[24]);  // alu.v(120)
  not u379 (n10[25], i_A[25]);  // alu.v(120)
  or u38 (n14[30], n11[30], n13[30]);  // alu.v(123)
  not u380 (n10[26], i_A[26]);  // alu.v(120)
  not u381 (n10[27], i_A[27]);  // alu.v(120)
  not u382 (n10[28], i_A[28]);  // alu.v(120)
  not u383 (n10[29], i_A[29]);  // alu.v(120)
  not u384 (n10[30], i_A[30]);  // alu.v(120)
  not u385 (n10[31], i_A[31]);  // alu.v(120)
  AL_MUX u386 (
    .i0(i_A[30]),
    .i1(i_A[29]),
    .sel(i_B[0]),
    .o(n141));  // alu.v(117)
  AL_MUX u387 (
    .i0(i_A[29]),
    .i1(i_A[28]),
    .sel(i_B[0]),
    .o(n142));  // alu.v(117)
  AL_MUX u388 (
    .i0(i_A[28]),
    .i1(i_A[27]),
    .sel(i_B[0]),
    .o(n143));  // alu.v(117)
  AL_MUX u389 (
    .i0(i_A[27]),
    .i1(i_A[26]),
    .sel(i_B[0]),
    .o(n144));  // alu.v(117)
  or u39 (n14[31], n11[31], n13[31]);  // alu.v(123)
  AL_MUX u390 (
    .i0(i_A[26]),
    .i1(i_A[25]),
    .sel(i_B[0]),
    .o(n145));  // alu.v(117)
  AL_MUX u391 (
    .i0(i_A[25]),
    .i1(i_A[24]),
    .sel(i_B[0]),
    .o(n146));  // alu.v(117)
  AL_MUX u392 (
    .i0(i_A[24]),
    .i1(i_A[23]),
    .sel(i_B[0]),
    .o(n147));  // alu.v(117)
  AL_MUX u393 (
    .i0(i_A[23]),
    .i1(i_A[22]),
    .sel(i_B[0]),
    .o(n148));  // alu.v(117)
  AL_MUX u394 (
    .i0(i_A[22]),
    .i1(i_A[21]),
    .sel(i_B[0]),
    .o(n149));  // alu.v(117)
  AL_MUX u395 (
    .i0(i_A[21]),
    .i1(i_A[20]),
    .sel(i_B[0]),
    .o(n150));  // alu.v(117)
  AL_MUX u396 (
    .i0(i_A[20]),
    .i1(i_A[19]),
    .sel(i_B[0]),
    .o(n151));  // alu.v(117)
  AL_MUX u397 (
    .i0(i_A[19]),
    .i1(i_A[18]),
    .sel(i_B[0]),
    .o(n152));  // alu.v(117)
  AL_MUX u398 (
    .i0(i_A[18]),
    .i1(i_A[17]),
    .sel(i_B[0]),
    .o(n153));  // alu.v(117)
  AL_MUX u399 (
    .i0(i_A[17]),
    .i1(i_A[16]),
    .sel(i_B[0]),
    .o(n154));  // alu.v(117)
  or u4 (n14[1], n11[1], n13[1]);  // alu.v(123)
  or u40 (n48[0], i_A[0], i_B[0]);  // alu.v(123)
  AL_MUX u400 (
    .i0(i_A[16]),
    .i1(i_A[15]),
    .sel(i_B[0]),
    .o(n155));  // alu.v(117)
  AL_MUX u401 (
    .i0(i_A[15]),
    .i1(i_A[14]),
    .sel(i_B[0]),
    .o(n156));  // alu.v(117)
  AL_MUX u402 (
    .i0(i_A[14]),
    .i1(i_A[13]),
    .sel(i_B[0]),
    .o(n157));  // alu.v(117)
  AL_MUX u403 (
    .i0(i_A[13]),
    .i1(i_A[12]),
    .sel(i_B[0]),
    .o(n158));  // alu.v(117)
  AL_MUX u404 (
    .i0(i_A[12]),
    .i1(i_A[11]),
    .sel(i_B[0]),
    .o(n159));  // alu.v(117)
  AL_MUX u405 (
    .i0(i_A[11]),
    .i1(i_A[10]),
    .sel(i_B[0]),
    .o(n160));  // alu.v(117)
  AL_MUX u406 (
    .i0(i_A[10]),
    .i1(i_A[9]),
    .sel(i_B[0]),
    .o(n161));  // alu.v(117)
  AL_MUX u407 (
    .i0(i_A[9]),
    .i1(i_A[8]),
    .sel(i_B[0]),
    .o(n162));  // alu.v(117)
  AL_MUX u408 (
    .i0(i_A[8]),
    .i1(i_A[7]),
    .sel(i_B[0]),
    .o(n163));  // alu.v(117)
  AL_MUX u409 (
    .i0(i_A[7]),
    .i1(i_A[6]),
    .sel(i_B[0]),
    .o(n164));  // alu.v(117)
  or u41 (n48[1], i_A[1], i_B[1]);  // alu.v(123)
  AL_MUX u410 (
    .i0(i_A[6]),
    .i1(i_A[5]),
    .sel(i_B[0]),
    .o(n165));  // alu.v(117)
  AL_MUX u411 (
    .i0(i_A[5]),
    .i1(i_A[4]),
    .sel(i_B[0]),
    .o(n166));  // alu.v(117)
  AL_MUX u412 (
    .i0(i_A[4]),
    .i1(i_A[3]),
    .sel(i_B[0]),
    .o(n167));  // alu.v(117)
  AL_MUX u413 (
    .i0(i_A[3]),
    .i1(i_A[2]),
    .sel(i_B[0]),
    .o(n168));  // alu.v(117)
  AL_MUX u414 (
    .i0(i_A[2]),
    .i1(i_A[1]),
    .sel(i_B[0]),
    .o(n169));  // alu.v(117)
  AL_MUX u415 (
    .i0(i_A[1]),
    .i1(i_A[0]),
    .sel(i_B[0]),
    .o(n170));  // alu.v(117)
  AL_MUX u416 (
    .i0(i_A[0]),
    .i1(1'b0),
    .sel(i_B[0]),
    .o(n171));  // alu.v(117)
  AL_MUX u417 (
    .i0(n140),
    .i1(n142),
    .sel(i_B[1]),
    .o(n172));  // alu.v(117)
  AL_MUX u418 (
    .i0(n141),
    .i1(n143),
    .sel(i_B[1]),
    .o(n173));  // alu.v(117)
  AL_MUX u419 (
    .i0(n142),
    .i1(n144),
    .sel(i_B[1]),
    .o(n174));  // alu.v(117)
  or u42 (n48[2], i_A[2], i_B[2]);  // alu.v(123)
  AL_MUX u420 (
    .i0(n143),
    .i1(n145),
    .sel(i_B[1]),
    .o(n175));  // alu.v(117)
  AL_MUX u421 (
    .i0(n144),
    .i1(n146),
    .sel(i_B[1]),
    .o(n176));  // alu.v(117)
  AL_MUX u422 (
    .i0(n145),
    .i1(n147),
    .sel(i_B[1]),
    .o(n177));  // alu.v(117)
  AL_MUX u423 (
    .i0(n146),
    .i1(n148),
    .sel(i_B[1]),
    .o(n178));  // alu.v(117)
  AL_MUX u424 (
    .i0(n147),
    .i1(n149),
    .sel(i_B[1]),
    .o(n179));  // alu.v(117)
  AL_MUX u425 (
    .i0(n148),
    .i1(n150),
    .sel(i_B[1]),
    .o(n180));  // alu.v(117)
  AL_MUX u426 (
    .i0(n149),
    .i1(n151),
    .sel(i_B[1]),
    .o(n181));  // alu.v(117)
  AL_MUX u427 (
    .i0(n150),
    .i1(n152),
    .sel(i_B[1]),
    .o(n182));  // alu.v(117)
  AL_MUX u428 (
    .i0(n151),
    .i1(n153),
    .sel(i_B[1]),
    .o(n183));  // alu.v(117)
  AL_MUX u429 (
    .i0(n152),
    .i1(n154),
    .sel(i_B[1]),
    .o(n184));  // alu.v(117)
  or u43 (n48[3], i_A[3], i_B[3]);  // alu.v(123)
  AL_MUX u430 (
    .i0(n153),
    .i1(n155),
    .sel(i_B[1]),
    .o(n185));  // alu.v(117)
  AL_MUX u431 (
    .i0(n154),
    .i1(n156),
    .sel(i_B[1]),
    .o(n186));  // alu.v(117)
  AL_MUX u432 (
    .i0(n155),
    .i1(n157),
    .sel(i_B[1]),
    .o(n187));  // alu.v(117)
  AL_MUX u433 (
    .i0(n156),
    .i1(n158),
    .sel(i_B[1]),
    .o(n188));  // alu.v(117)
  AL_MUX u434 (
    .i0(n157),
    .i1(n159),
    .sel(i_B[1]),
    .o(n189));  // alu.v(117)
  AL_MUX u435 (
    .i0(n158),
    .i1(n160),
    .sel(i_B[1]),
    .o(n190));  // alu.v(117)
  AL_MUX u436 (
    .i0(n159),
    .i1(n161),
    .sel(i_B[1]),
    .o(n191));  // alu.v(117)
  AL_MUX u437 (
    .i0(n160),
    .i1(n162),
    .sel(i_B[1]),
    .o(n192));  // alu.v(117)
  AL_MUX u438 (
    .i0(n161),
    .i1(n163),
    .sel(i_B[1]),
    .o(n193));  // alu.v(117)
  AL_MUX u439 (
    .i0(n162),
    .i1(n164),
    .sel(i_B[1]),
    .o(n194));  // alu.v(117)
  or u44 (n48[4], i_A[4], i_B[4]);  // alu.v(123)
  AL_MUX u440 (
    .i0(n163),
    .i1(n165),
    .sel(i_B[1]),
    .o(n195));  // alu.v(117)
  AL_MUX u441 (
    .i0(n164),
    .i1(n166),
    .sel(i_B[1]),
    .o(n196));  // alu.v(117)
  AL_MUX u442 (
    .i0(n165),
    .i1(n167),
    .sel(i_B[1]),
    .o(n197));  // alu.v(117)
  AL_MUX u443 (
    .i0(n166),
    .i1(n168),
    .sel(i_B[1]),
    .o(n198));  // alu.v(117)
  AL_MUX u444 (
    .i0(n167),
    .i1(n169),
    .sel(i_B[1]),
    .o(n199));  // alu.v(117)
  AL_MUX u445 (
    .i0(n168),
    .i1(n170),
    .sel(i_B[1]),
    .o(n200));  // alu.v(117)
  AL_MUX u446 (
    .i0(n169),
    .i1(n171),
    .sel(i_B[1]),
    .o(n201));  // alu.v(117)
  AL_MUX u447 (
    .i0(n170),
    .i1(1'b0),
    .sel(i_B[1]),
    .o(n202));  // alu.v(117)
  AL_MUX u448 (
    .i0(n171),
    .i1(1'b0),
    .sel(i_B[1]),
    .o(n203));  // alu.v(117)
  AL_MUX u449 (
    .i0(n172),
    .i1(n176),
    .sel(i_B[2]),
    .o(n204));  // alu.v(117)
  or u45 (n48[5], i_A[5], i_B[5]);  // alu.v(123)
  AL_MUX u450 (
    .i0(n173),
    .i1(n177),
    .sel(i_B[2]),
    .o(n205));  // alu.v(117)
  AL_MUX u451 (
    .i0(n174),
    .i1(n178),
    .sel(i_B[2]),
    .o(n206));  // alu.v(117)
  AL_MUX u452 (
    .i0(n175),
    .i1(n179),
    .sel(i_B[2]),
    .o(n207));  // alu.v(117)
  AL_MUX u453 (
    .i0(n176),
    .i1(n180),
    .sel(i_B[2]),
    .o(n208));  // alu.v(117)
  AL_MUX u454 (
    .i0(n177),
    .i1(n181),
    .sel(i_B[2]),
    .o(n209));  // alu.v(117)
  AL_MUX u455 (
    .i0(n178),
    .i1(n182),
    .sel(i_B[2]),
    .o(n210));  // alu.v(117)
  AL_MUX u456 (
    .i0(n179),
    .i1(n183),
    .sel(i_B[2]),
    .o(n211));  // alu.v(117)
  AL_MUX u457 (
    .i0(n180),
    .i1(n184),
    .sel(i_B[2]),
    .o(n212));  // alu.v(117)
  AL_MUX u458 (
    .i0(n181),
    .i1(n185),
    .sel(i_B[2]),
    .o(n213));  // alu.v(117)
  AL_MUX u459 (
    .i0(n182),
    .i1(n186),
    .sel(i_B[2]),
    .o(n214));  // alu.v(117)
  or u46 (n48[6], i_A[6], i_B[6]);  // alu.v(123)
  AL_MUX u460 (
    .i0(n183),
    .i1(n187),
    .sel(i_B[2]),
    .o(n215));  // alu.v(117)
  AL_MUX u461 (
    .i0(n184),
    .i1(n188),
    .sel(i_B[2]),
    .o(n216));  // alu.v(117)
  AL_MUX u462 (
    .i0(n185),
    .i1(n189),
    .sel(i_B[2]),
    .o(n217));  // alu.v(117)
  AL_MUX u463 (
    .i0(n186),
    .i1(n190),
    .sel(i_B[2]),
    .o(n218));  // alu.v(117)
  AL_MUX u464 (
    .i0(n187),
    .i1(n191),
    .sel(i_B[2]),
    .o(n219));  // alu.v(117)
  AL_MUX u465 (
    .i0(n188),
    .i1(n192),
    .sel(i_B[2]),
    .o(n220));  // alu.v(117)
  AL_MUX u466 (
    .i0(n189),
    .i1(n193),
    .sel(i_B[2]),
    .o(n221));  // alu.v(117)
  AL_MUX u467 (
    .i0(n190),
    .i1(n194),
    .sel(i_B[2]),
    .o(n222));  // alu.v(117)
  AL_MUX u468 (
    .i0(n191),
    .i1(n195),
    .sel(i_B[2]),
    .o(n223));  // alu.v(117)
  AL_MUX u469 (
    .i0(n192),
    .i1(n196),
    .sel(i_B[2]),
    .o(n224));  // alu.v(117)
  or u47 (n48[7], i_A[7], i_B[7]);  // alu.v(123)
  AL_MUX u470 (
    .i0(n193),
    .i1(n197),
    .sel(i_B[2]),
    .o(n225));  // alu.v(117)
  AL_MUX u471 (
    .i0(n194),
    .i1(n198),
    .sel(i_B[2]),
    .o(n226));  // alu.v(117)
  AL_MUX u472 (
    .i0(n195),
    .i1(n199),
    .sel(i_B[2]),
    .o(n227));  // alu.v(117)
  AL_MUX u473 (
    .i0(n196),
    .i1(n200),
    .sel(i_B[2]),
    .o(n228));  // alu.v(117)
  AL_MUX u474 (
    .i0(n197),
    .i1(n201),
    .sel(i_B[2]),
    .o(n229));  // alu.v(117)
  AL_MUX u475 (
    .i0(n198),
    .i1(n202),
    .sel(i_B[2]),
    .o(n230));  // alu.v(117)
  AL_MUX u476 (
    .i0(n199),
    .i1(n203),
    .sel(i_B[2]),
    .o(n231));  // alu.v(117)
  AL_MUX u477 (
    .i0(n200),
    .i1(1'b0),
    .sel(i_B[2]),
    .o(n232));  // alu.v(117)
  AL_MUX u478 (
    .i0(n201),
    .i1(1'b0),
    .sel(i_B[2]),
    .o(n233));  // alu.v(117)
  AL_MUX u479 (
    .i0(n202),
    .i1(1'b0),
    .sel(i_B[2]),
    .o(n234));  // alu.v(117)
  or u48 (n48[8], i_A[8], i_B[8]);  // alu.v(123)
  AL_MUX u480 (
    .i0(n203),
    .i1(1'b0),
    .sel(i_B[2]),
    .o(n235));  // alu.v(117)
  AL_MUX u481 (
    .i0(n204),
    .i1(n212),
    .sel(i_B[3]),
    .o(n236));  // alu.v(117)
  AL_MUX u482 (
    .i0(n205),
    .i1(n213),
    .sel(i_B[3]),
    .o(n237));  // alu.v(117)
  AL_MUX u483 (
    .i0(n206),
    .i1(n214),
    .sel(i_B[3]),
    .o(n238));  // alu.v(117)
  AL_MUX u484 (
    .i0(n207),
    .i1(n215),
    .sel(i_B[3]),
    .o(n239));  // alu.v(117)
  AL_MUX u485 (
    .i0(n208),
    .i1(n216),
    .sel(i_B[3]),
    .o(n240));  // alu.v(117)
  AL_MUX u486 (
    .i0(n209),
    .i1(n217),
    .sel(i_B[3]),
    .o(n241));  // alu.v(117)
  AL_MUX u487 (
    .i0(n210),
    .i1(n218),
    .sel(i_B[3]),
    .o(n242));  // alu.v(117)
  AL_MUX u488 (
    .i0(n211),
    .i1(n219),
    .sel(i_B[3]),
    .o(n243));  // alu.v(117)
  AL_MUX u489 (
    .i0(n212),
    .i1(n220),
    .sel(i_B[3]),
    .o(n244));  // alu.v(117)
  or u49 (n48[9], i_A[9], i_B[9]);  // alu.v(123)
  AL_MUX u490 (
    .i0(n213),
    .i1(n221),
    .sel(i_B[3]),
    .o(n245));  // alu.v(117)
  AL_MUX u491 (
    .i0(n214),
    .i1(n222),
    .sel(i_B[3]),
    .o(n246));  // alu.v(117)
  AL_MUX u492 (
    .i0(n215),
    .i1(n223),
    .sel(i_B[3]),
    .o(n247));  // alu.v(117)
  AL_MUX u493 (
    .i0(n216),
    .i1(n224),
    .sel(i_B[3]),
    .o(n248));  // alu.v(117)
  AL_MUX u494 (
    .i0(n217),
    .i1(n225),
    .sel(i_B[3]),
    .o(n249));  // alu.v(117)
  AL_MUX u495 (
    .i0(n218),
    .i1(n226),
    .sel(i_B[3]),
    .o(n250));  // alu.v(117)
  AL_MUX u496 (
    .i0(n219),
    .i1(n227),
    .sel(i_B[3]),
    .o(n251));  // alu.v(117)
  AL_MUX u497 (
    .i0(n220),
    .i1(n228),
    .sel(i_B[3]),
    .o(n252));  // alu.v(117)
  AL_MUX u498 (
    .i0(n221),
    .i1(n229),
    .sel(i_B[3]),
    .o(n253));  // alu.v(117)
  AL_MUX u499 (
    .i0(n222),
    .i1(n230),
    .sel(i_B[3]),
    .o(n254));  // alu.v(117)
  AL_MUX u5 (
    .i0(i_A[31]),
    .i1(i_A[30]),
    .sel(i_B[0]),
    .o(n140));  // alu.v(117)
  or u50 (n48[10], i_A[10], i_B[10]);  // alu.v(123)
  AL_MUX u500 (
    .i0(n223),
    .i1(n231),
    .sel(i_B[3]),
    .o(n255));  // alu.v(117)
  AL_MUX u501 (
    .i0(n224),
    .i1(n232),
    .sel(i_B[3]),
    .o(n256));  // alu.v(117)
  AL_MUX u502 (
    .i0(n225),
    .i1(n233),
    .sel(i_B[3]),
    .o(n257));  // alu.v(117)
  AL_MUX u503 (
    .i0(n226),
    .i1(n234),
    .sel(i_B[3]),
    .o(n258));  // alu.v(117)
  AL_MUX u504 (
    .i0(n227),
    .i1(n235),
    .sel(i_B[3]),
    .o(n259));  // alu.v(117)
  AL_MUX u505 (
    .i0(n228),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n260));  // alu.v(117)
  AL_MUX u506 (
    .i0(n229),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n261));  // alu.v(117)
  AL_MUX u507 (
    .i0(n230),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n262));  // alu.v(117)
  AL_MUX u508 (
    .i0(n231),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n263));  // alu.v(117)
  AL_MUX u509 (
    .i0(n232),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n264));  // alu.v(117)
  or u51 (n48[11], i_A[11], i_B[11]);  // alu.v(123)
  AL_MUX u510 (
    .i0(n233),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n265));  // alu.v(117)
  AL_MUX u511 (
    .i0(n234),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n266));  // alu.v(117)
  AL_MUX u512 (
    .i0(n235),
    .i1(1'b0),
    .sel(i_B[3]),
    .o(n267));  // alu.v(117)
  AL_MUX u513 (
    .i0(n236),
    .i1(n252),
    .sel(i_B[4]),
    .o(n7[31]));  // alu.v(117)
  AL_MUX u514 (
    .i0(n237),
    .i1(n253),
    .sel(i_B[4]),
    .o(n7[30]));  // alu.v(117)
  AL_MUX u515 (
    .i0(n238),
    .i1(n254),
    .sel(i_B[4]),
    .o(n7[29]));  // alu.v(117)
  AL_MUX u516 (
    .i0(n239),
    .i1(n255),
    .sel(i_B[4]),
    .o(n7[28]));  // alu.v(117)
  AL_MUX u517 (
    .i0(n240),
    .i1(n256),
    .sel(i_B[4]),
    .o(n7[27]));  // alu.v(117)
  AL_MUX u518 (
    .i0(n241),
    .i1(n257),
    .sel(i_B[4]),
    .o(n7[26]));  // alu.v(117)
  AL_MUX u519 (
    .i0(n242),
    .i1(n258),
    .sel(i_B[4]),
    .o(n7[25]));  // alu.v(117)
  or u52 (n48[12], i_A[12], i_B[12]);  // alu.v(123)
  AL_MUX u520 (
    .i0(n243),
    .i1(n259),
    .sel(i_B[4]),
    .o(n7[24]));  // alu.v(117)
  AL_MUX u521 (
    .i0(n244),
    .i1(n260),
    .sel(i_B[4]),
    .o(n7[23]));  // alu.v(117)
  AL_MUX u522 (
    .i0(n245),
    .i1(n261),
    .sel(i_B[4]),
    .o(n7[22]));  // alu.v(117)
  AL_MUX u523 (
    .i0(n246),
    .i1(n262),
    .sel(i_B[4]),
    .o(n7[21]));  // alu.v(117)
  AL_MUX u524 (
    .i0(n247),
    .i1(n263),
    .sel(i_B[4]),
    .o(n7[20]));  // alu.v(117)
  AL_MUX u525 (
    .i0(n248),
    .i1(n264),
    .sel(i_B[4]),
    .o(n7[19]));  // alu.v(117)
  AL_MUX u526 (
    .i0(n249),
    .i1(n265),
    .sel(i_B[4]),
    .o(n7[18]));  // alu.v(117)
  AL_MUX u527 (
    .i0(n250),
    .i1(n266),
    .sel(i_B[4]),
    .o(n7[17]));  // alu.v(117)
  AL_MUX u528 (
    .i0(n251),
    .i1(n267),
    .sel(i_B[4]),
    .o(n7[16]));  // alu.v(117)
  AL_MUX u529 (
    .i0(n252),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[15]));  // alu.v(117)
  or u53 (n48[13], i_A[13], i_B[13]);  // alu.v(123)
  AL_MUX u530 (
    .i0(n253),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[14]));  // alu.v(117)
  AL_MUX u531 (
    .i0(n254),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[13]));  // alu.v(117)
  AL_MUX u532 (
    .i0(n255),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[12]));  // alu.v(117)
  AL_MUX u533 (
    .i0(n256),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[11]));  // alu.v(117)
  AL_MUX u534 (
    .i0(n257),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[10]));  // alu.v(117)
  AL_MUX u535 (
    .i0(n258),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[9]));  // alu.v(117)
  AL_MUX u536 (
    .i0(n259),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[8]));  // alu.v(117)
  AL_MUX u537 (
    .i0(n260),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[7]));  // alu.v(117)
  AL_MUX u538 (
    .i0(n261),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[6]));  // alu.v(117)
  AL_MUX u539 (
    .i0(n262),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[5]));  // alu.v(117)
  or u54 (n48[14], i_A[14], i_B[14]);  // alu.v(123)
  AL_MUX u540 (
    .i0(n263),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[4]));  // alu.v(117)
  AL_MUX u541 (
    .i0(n264),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[3]));  // alu.v(117)
  AL_MUX u542 (
    .i0(n265),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[2]));  // alu.v(117)
  AL_MUX u543 (
    .i0(n266),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[1]));  // alu.v(117)
  AL_MUX u544 (
    .i0(n267),
    .i1(1'b0),
    .sel(i_B[4]),
    .o(n7[0]));  // alu.v(117)
  or u55 (n48[15], i_A[15], i_B[15]);  // alu.v(123)
  or u56 (n48[16], i_A[16], i_B[16]);  // alu.v(123)
  or u57 (n48[17], i_A[17], i_B[17]);  // alu.v(123)
  or u58 (n48[18], i_A[18], i_B[18]);  // alu.v(123)
  or u59 (n48[19], i_A[19], i_B[19]);  // alu.v(123)
  not u6 (n10[0], i_A[0]);  // alu.v(120)
  or u60 (n48[20], i_A[20], i_B[20]);  // alu.v(123)
  or u61 (n48[21], i_A[21], i_B[21]);  // alu.v(123)
  or u62 (n48[22], i_A[22], i_B[22]);  // alu.v(123)
  or u63 (n48[23], i_A[23], i_B[23]);  // alu.v(123)
  or u64 (n48[24], i_A[24], i_B[24]);  // alu.v(123)
  or u65 (n48[25], i_A[25], i_B[25]);  // alu.v(123)
  or u66 (n48[26], i_A[26], i_B[26]);  // alu.v(123)
  or u67 (n48[27], i_A[27], i_B[27]);  // alu.v(123)
  or u68 (n48[28], i_A[28], i_B[28]);  // alu.v(123)
  or u69 (n48[29], i_A[29], i_B[29]);  // alu.v(123)
  and u7 (n11[0], n10[0], i_B[0]);  // alu.v(120)
  or u70 (n48[30], i_A[30], i_B[30]);  // alu.v(123)
  or u71 (n48[31], i_A[31], i_B[31]);  // alu.v(123)
  and u72 (n49[1], i_A[1], i_B[1]);  // alu.v(124)
  and u73 (n49[2], i_A[2], i_B[2]);  // alu.v(124)
  and u74 (n49[3], i_A[3], i_B[3]);  // alu.v(124)
  and u75 (n49[4], i_A[4], i_B[4]);  // alu.v(124)
  and u76 (n49[5], i_A[5], i_B[5]);  // alu.v(124)
  and u77 (n49[6], i_A[6], i_B[6]);  // alu.v(124)
  and u78 (n49[7], i_A[7], i_B[7]);  // alu.v(124)
  and u79 (n49[8], i_A[8], i_B[8]);  // alu.v(124)
  not u8 (n12[0], i_B[0]);  // alu.v(120)
  and u80 (n49[9], i_A[9], i_B[9]);  // alu.v(124)
  and u81 (n49[10], i_A[10], i_B[10]);  // alu.v(124)
  and u82 (n49[11], i_A[11], i_B[11]);  // alu.v(124)
  and u83 (n49[12], i_A[12], i_B[12]);  // alu.v(124)
  and u84 (n49[13], i_A[13], i_B[13]);  // alu.v(124)
  and u85 (n49[14], i_A[14], i_B[14]);  // alu.v(124)
  and u86 (n49[15], i_A[15], i_B[15]);  // alu.v(124)
  and u87 (n49[16], i_A[16], i_B[16]);  // alu.v(124)
  and u88 (n49[17], i_A[17], i_B[17]);  // alu.v(124)
  and u89 (n49[18], i_A[18], i_B[18]);  // alu.v(124)
  or u9 (n14[6], n11[6], n13[6]);  // alu.v(123)
  and u90 (n49[19], i_A[19], i_B[19]);  // alu.v(124)
  and u91 (n49[20], i_A[20], i_B[20]);  // alu.v(124)
  and u92 (n49[21], i_A[21], i_B[21]);  // alu.v(124)
  and u93 (n49[22], i_A[22], i_B[22]);  // alu.v(124)
  and u94 (n49[23], i_A[23], i_B[23]);  // alu.v(124)
  and u95 (n49[24], i_A[24], i_B[24]);  // alu.v(124)
  and u96 (n49[25], i_A[25], i_B[25]);  // alu.v(124)
  and u97 (n49[26], i_A[26], i_B[26]);  // alu.v(124)
  and u98 (n49[27], i_A[27], i_B[27]);  // alu.v(124)
  and u99 (n49[28], i_A[28], i_B[28]);  // alu.v(124)

endmodule 

module aluinput  // alu.v(4)
  (
  i_MEM_aludat,
  i_alu_A_select,
  i_alu_B_select,
  i_fun3,
  i_fun7,
  i_memstraddr,
  i_op,
  i_rd,
  i_reg_writedat,
  i_regdat1,
  i_regdat2,
  i_rs1,
  i_rs2,
  o_A,
  o_B,
  o_operation
  );

  input [31:0] i_MEM_aludat;  // alu.v(15)
  input [1:0] i_alu_A_select;  // alu.v(13)
  input [1:0] i_alu_B_select;  // alu.v(14)
  input [2:0] i_fun3;  // alu.v(5)
  input [6:0] i_fun7;  // alu.v(12)
  input [31:0] i_memstraddr;  // alu.v(17)
  input [6:0] i_op;  // alu.v(6)
  input [4:0] i_rd;  // alu.v(11)
  input [31:0] i_reg_writedat;  // alu.v(16)
  input [31:0] i_regdat1;  // alu.v(7)
  input [31:0] i_regdat2;  // alu.v(8)
  input [4:0] i_rs1;  // alu.v(9)
  input [4:0] i_rs2;  // alu.v(10)
  output [31:0] o_A;  // alu.v(19)
  output [31:0] o_B;  // alu.v(20)
  output [3:0] o_operation;  // alu.v(18)

  wire [3:0] n40;
  wire [3:0] n41;
  wire [6:0] n9;
  wire [31:0] o_A1;  // alu.v(25)
  wire [31:0] o_B1;  // alu.v(24)
  wire [3:0] operation_R;  // alu.v(22)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n34;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n4;
  wire n5;
  wire n6;
  wire n7;
  wire n8;

  eq_w7 eq0 (
    .i0(i_op),
    .i1(7'b0110111),
    .o(n1));  // alu.v(49)
  eq_w7 eq1 (
    .i0(i_op),
    .i1(7'b1101111),
    .o(n2));  // alu.v(50)
  eq_w7 eq10 (
    .i0(i_op),
    .i1(7'b0000000),
    .o(n18));  // alu.v(71)
  eq_w3 eq11 (
    .i0(i_fun3),
    .i1(3'b000),
    .o(n32));  // alu.v(94)
  eq_w7 eq12 (
    .i0(i_fun7),
    .i1(7'b0100000),
    .o(n35));  // alu.v(94)
  eq_w7 eq2 (
    .i0(i_op),
    .i1(7'b1100111),
    .o(n3));  // alu.v(51)
  eq_w7 eq3 (
    .i0(i_op),
    .i1(7'b0010111),
    .o(n4));  // alu.v(52)
  eq_w3 eq4 (
    .i0(i_fun3),
    .i1(3'b001),
    .o(n6));  // alu.v(64)
  eq_w3 eq5 (
    .i0(i_fun3),
    .i1(3'b101),
    .o(n7));  // alu.v(64)
  eq_w7 eq6 (
    .i0(i_op),
    .i1(7'b0110011),
    .o(n10));  // alu.v(60)
  eq_w7 eq7 (
    .i0(i_op),
    .i1(7'b0000011),
    .o(n11));  // alu.v(61)
  eq_w7 eq8 (
    .i0(i_op),
    .i1(7'b0100011),
    .o(n12));  // alu.v(62)
  eq_w7 eq9 (
    .i0(i_op),
    .i1(7'b0010011),
    .o(n13));  // alu.v(63)
  binary_mux_s2_w32 mux0 (
    .i0(i_regdat1),
    .i1(i_MEM_aludat),
    .i2(i_reg_writedat),
    .i3(i_regdat1),
    .sel(i_alu_A_select),
    .o(o_A1));  // alu.v(34)
  binary_mux_s2_w32 mux1 (
    .i0(i_regdat2),
    .i1(i_MEM_aludat),
    .i2(i_reg_writedat),
    .i3(i_regdat2),
    .sel(i_alu_B_select),
    .o(o_B1));  // alu.v(42)
  binary_mux_s1_w4 mux2 (
    .i0({1'b0,i_fun3}),
    .i1(4'b1101),
    .sel(n39),
    .o(n40));  // alu.v(98)
  binary_mux_s1_w4 mux3 (
    .i0(n40),
    .i1(4'b1000),
    .sel(n36),
    .o(n41));  // alu.v(98)
  binary_mux_s1_w4 mux4 (
    .i0({1'b0,i_fun3}),
    .i1(n41),
    .sel(n31),
    .o(operation_R));  // alu.v(100)
  binary_mux_s1_w7 mux5 (
    .i0(i_fun7),
    .i1(7'b0000000),
    .sel(n8),
    .o(n9));  // alu.v(65)
  onehot_mux_s5_w32 sel0 (
    .i0(o_A1),
    .i1(i_memstraddr),
    .i2(i_memstraddr),
    .i3(i_memstraddr),
    .i4(32'b00000000000000000000000000000000),
    .sel({n1,n2,n3,n4,n5}),
    .o(o_A));  // alu.v(54)
  onehot_mux_s10_w32 sel1 (
    .i0(32'b00000000000000000000000000000000),
    .i1(32'b00000000000000000000000000000000),
    .i2({i_fun7,i_rs2,i_rs1,i_fun3,12'b000000000000}),
    .i3({i_fun7,i_rs2,i_rs1,i_fun3,12'b000000000000}),
    .i4(32'b00000000000000000000000000000100),
    .i5(32'b00000000000000000000000000000100),
    .i6({20'b00000000000000000000,n9,i_rs2}),
    .i7({i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7,i_rd}),
    .i8({i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7,i_rs2}),
    .i9(o_B1),
    .sel({n10,n11,n12,n13,n2,n3,n1,n4,n18,n19}),
    .o(o_B));  // alu.v(73)
  onehot_mux_s9_w4 sel2 (
    .i0(4'b0000),
    .i1(4'b0000),
    .i2(4'b0000),
    .i3(4'b0000),
    .i4(4'b0000),
    .i5(4'b0000),
    .i6(4'b0000),
    .i7(operation_R),
    .i8(operation_R),
    .sel({n10,n13,n11,n12,n2,n3,n1,n4,n28}),
    .o(o_operation));  // alu.v(89)
  or u10 (n20, n12, n21);  // alu.v(73)
  or u11 (n21, n11, n10);  // alu.v(73)
  or u12 (n22, n2, n13);  // alu.v(73)
  or u13 (n23, n25, n24);  // alu.v(73)
  or u14 (n24, n1, n3);  // alu.v(73)
  not u15 (n28, n26);  // alu.v(89)
  or u16 (n26, n33, n27);  // alu.v(89)
  or u17 (n27, n30, n29);  // alu.v(89)
  or u18 (n25, n18, n4);  // alu.v(73)
  or u19 (n29, n13, n10);  // alu.v(89)
  not u2 (n5, n0);  // alu.v(54)
  or u20 (n30, n12, n11);  // alu.v(89)
  or u21 (n31, n13, n10);  // alu.v(93)
  or u22 (n33, n38, n37);  // alu.v(89)
  and u23 (n34, n32, n10);  // alu.v(94)
  and u24 (n36, n34, n35);  // alu.v(94)
  or u25 (n37, n3, n2);  // alu.v(89)
  or u26 (n38, n4, n1);  // alu.v(89)
  and u27 (n39, n7, n35);  // alu.v(96)
  or u3 (n0, n15, n14);  // alu.v(54)
  or u4 (n8, n6, n7);  // alu.v(64)
  or u5 (n14, n2, n1);  // alu.v(54)
  not u6 (n19, n16);  // alu.v(73)
  or u7 (n16, n23, n17);  // alu.v(73)
  or u8 (n17, n22, n20);  // alu.v(73)
  or u9 (n15, n4, n3);  // alu.v(54)

endmodule 

module jump  // PC.v(245)
  (
  i_ID_jump_risk_block,
  i_fun3,
  i_fun7,
  i_op,
  i_rd,
  i_regdat1,
  i_regdat2,
  i_rs2,
  o_jump_addr,
  o_jump_cs
  );

  input i_ID_jump_risk_block;  // PC.v(253)
  input [2:0] i_fun3;  // PC.v(249)
  input [6:0] i_fun7;  // PC.v(250)
  input [6:0] i_op;  // PC.v(247)
  input [4:0] i_rd;  // PC.v(246)
  input [31:0] i_regdat1;  // PC.v(251)
  input [31:0] i_regdat2;  // PC.v(252)
  input [4:0] i_rs2;  // PC.v(248)
  output [31:0] o_jump_addr;  // PC.v(254)
  output o_jump_cs;  // PC.v(255)

  wire [31:0] JALR_jump_addr;  // PC.v(257)
  wire [31:0] SB_jump_addr;  // PC.v(260)
  wire [31:0] n3;
  wire [31:0] n5;
  wire JALR_jump_cs;  // PC.v(258)
  wire SB_jump_cs;  // PC.v(261)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n2;
  wire n4;
  wire n6;
  wire n7;
  wire n8;
  wire n9;

  add_pu32_pu32_o32 add0 (
    .i0({i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7,i_rs2}),
    .i1(i_regdat1),
    .o({n5[31:1],open_n0}));  // PC.v(291)
  eq_w1 eq0 (
    .i0(i_ID_jump_risk_block),
    .i1(1'b1),
    .o(n0));  // PC.v(266)
  eq_w7 eq1 (
    .i0(i_op),
    .i1(7'b1100111),
    .o(JALR_jump_cs));  // PC.v(272)
  eq_w7 eq2 (
    .i0(i_op),
    .i1(7'b1100011),
    .o(n1));  // PC.v(276)
  eq_w32 eq3 (
    .i0(i_regdat1),
    .i1(i_regdat2),
    .o(n7));  // PC.v(312)
  lt_u32_u32 lt0 (
    .ci(1'b0),
    .i0(i_regdat1),
    .i1(i_regdat2),
    .o(n9));  // PC.v(314)
  lt_u31_u31 lt1 (
    .ci(1'b0),
    .i0(i_regdat1[30:0]),
    .i1(i_regdat2[30:0]),
    .o(n10));  // PC.v(315)
  binary_mux_s1_w32 mux0 (
    .i0(n3),
    .i1(32'b00000000000000000000000000000000),
    .sel(n0),
    .o(o_jump_addr));  // PC.v(285)
  binary_mux_s1_w32 mux1 (
    .i0(32'b00000000000000000000000000000000),
    .i1({n5[31:1],1'b0}),
    .sel(JALR_jump_cs),
    .o(JALR_jump_addr));  // PC.v(297)
  binary_mux_s1_w32 mux2 (
    .i0(32'b00000000000000000000000000000000),
    .i1({i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_fun7[6],i_rd[0],i_fun7[5:0],i_rd[4:1],1'b0}),
    .sel(n1),
    .o(SB_jump_addr));  // PC.v(306)
  binary_mux_s3_w1 mux3 (
    .i0(n7),
    .i1(n8),
    .i2(1'b0),
    .i3(1'b0),
    .i4(n9),
    .i5(n11),
    .i6(n10),
    .i7(n12),
    .sel(i_fun3),
    .o(n13));  // PC.v(319)
  ne_w32 neq0 (
    .i0(i_regdat1),
    .i1(i_regdat2),
    .o(n8));  // PC.v(313)
  onehot_mux_s3_w32 sel0 (
    .i0(32'b00000000000000000000000000000000),
    .i1(SB_jump_addr),
    .i2(JALR_jump_addr),
    .sel({JALR_jump_cs,n1,n2}),
    .o(n3));  // PC.v(284)
  onehot_mux_s3_w1 sel1 (
    .i0(1'b0),
    .i1(SB_jump_cs),
    .i2(JALR_jump_cs),
    .sel({JALR_jump_cs,n1,n2}),
    .o(n4));  // PC.v(284)
  AL_MUX u2 (
    .i0(n4),
    .i1(1'b0),
    .sel(n0),
    .o(o_jump_cs));  // PC.v(285)
  not u3 (n2, n6);  // PC.v(284)
  or u4 (n6, n1, JALR_jump_cs);  // PC.v(284)
  not u5 (n11, n9);  // PC.v(316)
  not u6 (n12, n10);  // PC.v(317)
  AL_MUX u7 (
    .i0(1'b0),
    .i1(n13),
    .sel(n1),
    .o(SB_jump_cs));  // PC.v(320)

endmodule 

module eq_w7
  (
  i0,
  i1,
  o
  );

  input [6:0] i0;
  input [6:0] i1;
  output o;



endmodule 

module eq_w5
  (
  i0,
  i1,
  o
  );

  input [4:0] i0;
  input [4:0] i1;
  output o;



endmodule 

module eq_w3
  (
  i0,
  i1,
  o
  );

  input [2:0] i0;
  input [2:0] i1;
  output o;



endmodule 

module EX_MEM_reg  // flow_line_reg.v(146)
  (
  clock,
  i_aludat,
  i_aluzero,
  i_fun3,
  i_op,
  i_rd,
  i_regdat2,
  rst,
  o_aludat,
  o_aluzero,
  o_fun3,
  o_op,
  o_rd,
  o_regdat2
  );

  input clock;  // flow_line_reg.v(146)
  input [31:0] i_aludat;  // flow_line_reg.v(147)
  input i_aluzero;  // flow_line_reg.v(148)
  input [2:0] i_fun3;  // flow_line_reg.v(152)
  input [6:0] i_op;  // flow_line_reg.v(151)
  input [4:0] i_rd;  // flow_line_reg.v(149)
  input [31:0] i_regdat2;  // flow_line_reg.v(150)
  input rst;  // flow_line_reg.v(146)
  output [31:0] o_aludat;  // flow_line_reg.v(155)
  output o_aluzero;  // flow_line_reg.v(156)
  output [2:0] o_fun3;  // flow_line_reg.v(153)
  output [6:0] o_op;  // flow_line_reg.v(154)
  output [4:0] o_rd;  // flow_line_reg.v(157)
  output [31:0] o_regdat2;  // flow_line_reg.v(158)

  wire [31:0] aludat;  // flow_line_reg.v(161)
  wire [2:0] fun3;  // flow_line_reg.v(166)
  wire [6:0] op;  // flow_line_reg.v(165)
  wire [4:0] rd;  // flow_line_reg.v(163)
  wire [31:0] regdat2;  // flow_line_reg.v(164)
  wire n0;
  wire zero;  // flow_line_reg.v(162)

  reg_ar_as_w5 reg0 (
    .clk(clock),
    .d(i_rd),
    .reset({n0,n0,n0,n0,n0}),
    .set(5'b00000),
    .q(rd));  // flow_line_reg.v(191)
  reg_ar_as_w32 reg1 (
    .clk(clock),
    .d(i_regdat2),
    .reset({n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0}),
    .set(32'b00000000000000000000000000000000),
    .q(regdat2));  // flow_line_reg.v(191)
  reg_ar_as_w7 reg2 (
    .clk(clock),
    .d(i_op),
    .reset({n0,n0,n0,n0,n0,n0,n0}),
    .set(7'b0000000),
    .q(op));  // flow_line_reg.v(191)
  reg_ar_as_w3 reg3 (
    .clk(clock),
    .d(i_fun3),
    .reset({n0,n0,n0}),
    .set(3'b000),
    .q(fun3));  // flow_line_reg.v(191)
  reg_ar_as_w32 reg4 (
    .clk(clock),
    .d(i_aludat),
    .reset({n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0}),
    .set(32'b00000000000000000000000000000000),
    .q(aludat));  // flow_line_reg.v(191)
  buf u1 (o_regdat2[3], regdat2[3]);  // flow_line_reg.v(173)
  not u10 (n0, rst);  // flow_line_reg.v(176)
  buf u11 (o_regdat2[4], regdat2[4]);  // flow_line_reg.v(173)
  buf u12 (o_regdat2[5], regdat2[5]);  // flow_line_reg.v(173)
  buf u13 (o_regdat2[6], regdat2[6]);  // flow_line_reg.v(173)
  buf u14 (o_regdat2[7], regdat2[7]);  // flow_line_reg.v(173)
  buf u15 (o_regdat2[8], regdat2[8]);  // flow_line_reg.v(173)
  buf u16 (o_regdat2[9], regdat2[9]);  // flow_line_reg.v(173)
  buf u17 (o_regdat2[10], regdat2[10]);  // flow_line_reg.v(173)
  buf u18 (o_regdat2[11], regdat2[11]);  // flow_line_reg.v(173)
  buf u19 (o_regdat2[12], regdat2[12]);  // flow_line_reg.v(173)
  buf u2 (o_regdat2[2], regdat2[2]);  // flow_line_reg.v(173)
  buf u20 (o_regdat2[13], regdat2[13]);  // flow_line_reg.v(173)
  buf u21 (o_regdat2[14], regdat2[14]);  // flow_line_reg.v(173)
  buf u22 (o_regdat2[15], regdat2[15]);  // flow_line_reg.v(173)
  buf u23 (o_regdat2[16], regdat2[16]);  // flow_line_reg.v(173)
  buf u24 (o_regdat2[17], regdat2[17]);  // flow_line_reg.v(173)
  buf u25 (o_regdat2[18], regdat2[18]);  // flow_line_reg.v(173)
  buf u26 (o_regdat2[19], regdat2[19]);  // flow_line_reg.v(173)
  buf u27 (o_regdat2[20], regdat2[20]);  // flow_line_reg.v(173)
  buf u28 (o_regdat2[21], regdat2[21]);  // flow_line_reg.v(173)
  buf u29 (o_regdat2[22], regdat2[22]);  // flow_line_reg.v(173)
  buf u3 (o_regdat2[1], regdat2[1]);  // flow_line_reg.v(173)
  buf u30 (o_regdat2[23], regdat2[23]);  // flow_line_reg.v(173)
  buf u31 (o_regdat2[24], regdat2[24]);  // flow_line_reg.v(173)
  buf u32 (o_regdat2[25], regdat2[25]);  // flow_line_reg.v(173)
  buf u33 (o_regdat2[26], regdat2[26]);  // flow_line_reg.v(173)
  buf u34 (o_regdat2[27], regdat2[27]);  // flow_line_reg.v(173)
  buf u35 (o_regdat2[28], regdat2[28]);  // flow_line_reg.v(173)
  buf u36 (o_regdat2[29], regdat2[29]);  // flow_line_reg.v(173)
  buf u37 (o_regdat2[30], regdat2[30]);  // flow_line_reg.v(173)
  buf u38 (o_regdat2[31], regdat2[31]);  // flow_line_reg.v(173)
  buf u39 (o_rd[1], rd[1]);  // flow_line_reg.v(172)
  buf u4 (o_fun3[0], fun3[0]);  // flow_line_reg.v(168)
  buf u40 (o_rd[2], rd[2]);  // flow_line_reg.v(172)
  buf u41 (o_rd[3], rd[3]);  // flow_line_reg.v(172)
  buf u42 (o_rd[4], rd[4]);  // flow_line_reg.v(172)
  buf u43 (o_aludat[1], aludat[1]);  // flow_line_reg.v(170)
  buf u44 (o_aludat[2], aludat[2]);  // flow_line_reg.v(170)
  buf u45 (o_aludat[3], aludat[3]);  // flow_line_reg.v(170)
  buf u46 (o_aludat[4], aludat[4]);  // flow_line_reg.v(170)
  buf u47 (o_aludat[5], aludat[5]);  // flow_line_reg.v(170)
  buf u48 (o_aludat[6], aludat[6]);  // flow_line_reg.v(170)
  buf u49 (o_aludat[7], aludat[7]);  // flow_line_reg.v(170)
  buf u5 (o_op[0], op[0]);  // flow_line_reg.v(169)
  buf u50 (o_aludat[8], aludat[8]);  // flow_line_reg.v(170)
  buf u51 (o_aludat[9], aludat[9]);  // flow_line_reg.v(170)
  buf u52 (o_aludat[10], aludat[10]);  // flow_line_reg.v(170)
  buf u53 (o_aludat[11], aludat[11]);  // flow_line_reg.v(170)
  buf u54 (o_aludat[12], aludat[12]);  // flow_line_reg.v(170)
  buf u55 (o_aludat[13], aludat[13]);  // flow_line_reg.v(170)
  buf u56 (o_aludat[14], aludat[14]);  // flow_line_reg.v(170)
  buf u57 (o_aludat[15], aludat[15]);  // flow_line_reg.v(170)
  buf u58 (o_aludat[16], aludat[16]);  // flow_line_reg.v(170)
  buf u59 (o_aludat[17], aludat[17]);  // flow_line_reg.v(170)
  buf u6 (o_aluzero, zero);  // flow_line_reg.v(171)
  buf u60 (o_aludat[18], aludat[18]);  // flow_line_reg.v(170)
  buf u61 (o_aludat[19], aludat[19]);  // flow_line_reg.v(170)
  buf u62 (o_aludat[20], aludat[20]);  // flow_line_reg.v(170)
  buf u63 (o_aludat[21], aludat[21]);  // flow_line_reg.v(170)
  buf u64 (o_aludat[22], aludat[22]);  // flow_line_reg.v(170)
  buf u65 (o_aludat[23], aludat[23]);  // flow_line_reg.v(170)
  buf u66 (o_aludat[24], aludat[24]);  // flow_line_reg.v(170)
  buf u67 (o_aludat[25], aludat[25]);  // flow_line_reg.v(170)
  buf u68 (o_aludat[26], aludat[26]);  // flow_line_reg.v(170)
  buf u69 (o_aludat[27], aludat[27]);  // flow_line_reg.v(170)
  buf u7 (o_aludat[0], aludat[0]);  // flow_line_reg.v(170)
  buf u70 (o_aludat[28], aludat[28]);  // flow_line_reg.v(170)
  buf u71 (o_aludat[29], aludat[29]);  // flow_line_reg.v(170)
  buf u72 (o_aludat[30], aludat[30]);  // flow_line_reg.v(170)
  buf u73 (o_aludat[31], aludat[31]);  // flow_line_reg.v(170)
  buf u74 (o_op[1], op[1]);  // flow_line_reg.v(169)
  buf u75 (o_op[2], op[2]);  // flow_line_reg.v(169)
  buf u76 (o_op[3], op[3]);  // flow_line_reg.v(169)
  buf u77 (o_op[4], op[4]);  // flow_line_reg.v(169)
  buf u78 (o_op[5], op[5]);  // flow_line_reg.v(169)
  buf u79 (o_op[6], op[6]);  // flow_line_reg.v(169)
  buf u8 (o_rd[0], rd[0]);  // flow_line_reg.v(172)
  buf u80 (o_fun3[1], fun3[1]);  // flow_line_reg.v(168)
  buf u81 (o_fun3[2], fun3[2]);  // flow_line_reg.v(168)
  buf u9 (o_regdat2[0], regdat2[0]);  // flow_line_reg.v(173)
  AL_DFF zero_reg (
    .clk(clock),
    .d(i_aluzero),
    .reset(n0),
    .set(1'b0),
    .q(zero));  // flow_line_reg.v(191)

endmodule 

module ID_EX_reg  // flow_line_reg.v(76)
  (
  clock,
  i_fun3,
  i_fun7,
  i_memstraddr,
  i_op,
  i_rd,
  i_regdat1,
  i_regdat2,
  i_rs1,
  i_rs2,
  rst,
  o_fun3,
  o_fun7,
  o_memstraddr,
  o_op,
  o_rd,
  o_regdat1,
  o_regdat2,
  o_rs1,
  o_rs2
  );

  input clock;  // flow_line_reg.v(76)
  input [2:0] i_fun3;  // flow_line_reg.v(79)
  input [6:0] i_fun7;  // flow_line_reg.v(80)
  input [31:0] i_memstraddr;  // flow_line_reg.v(84)
  input [6:0] i_op;  // flow_line_reg.v(85)
  input [4:0] i_rd;  // flow_line_reg.v(83)
  input [31:0] i_regdat1;  // flow_line_reg.v(77)
  input [31:0] i_regdat2;  // flow_line_reg.v(78)
  input [4:0] i_rs1;  // flow_line_reg.v(81)
  input [4:0] i_rs2;  // flow_line_reg.v(82)
  input rst;  // flow_line_reg.v(76)
  output [2:0] o_fun3;  // flow_line_reg.v(94)
  output [6:0] o_fun7;  // flow_line_reg.v(86)
  output [31:0] o_memstraddr;  // flow_line_reg.v(92)
  output [6:0] o_op;  // flow_line_reg.v(93)
  output [4:0] o_rd;  // flow_line_reg.v(91)
  output [31:0] o_regdat1;  // flow_line_reg.v(89)
  output [31:0] o_regdat2;  // flow_line_reg.v(90)
  output [4:0] o_rs1;  // flow_line_reg.v(87)
  output [4:0] o_rs2;  // flow_line_reg.v(88)

  wire [2:0] fun3;  // flow_line_reg.v(98)
  wire [6:0] fun7;  // flow_line_reg.v(99)
  wire [31:0] memstraddr;  // flow_line_reg.v(103)
  wire [6:0] op;  // flow_line_reg.v(104)
  wire [4:0] rd;  // flow_line_reg.v(102)
  wire [31:0] regdat1;  // flow_line_reg.v(96)
  wire [31:0] regdat2;  // flow_line_reg.v(97)
  wire [4:0] rs1;  // flow_line_reg.v(101)
  wire [4:0] rs2;  // flow_line_reg.v(100)
  wire n0;

  reg_ar_as_w32 reg0 (
    .clk(clock),
    .d(i_regdat2),
    .reset({n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0}),
    .set(32'b00000000000000000000000000000000),
    .q(regdat2));  // flow_line_reg.v(139)
  reg_ar_as_w3 reg1 (
    .clk(clock),
    .d(i_fun3),
    .reset({n0,n0,n0}),
    .set(3'b000),
    .q(fun3));  // flow_line_reg.v(139)
  reg_ar_as_w7 reg2 (
    .clk(clock),
    .d(i_fun7),
    .reset({n0,n0,n0,n0,n0,n0,n0}),
    .set(7'b0000000),
    .q(fun7));  // flow_line_reg.v(139)
  reg_ar_as_w5 reg3 (
    .clk(clock),
    .d(i_rs2),
    .reset({n0,n0,n0,n0,n0}),
    .set(5'b00000),
    .q(rs2));  // flow_line_reg.v(139)
  reg_ar_as_w5 reg4 (
    .clk(clock),
    .d(i_rs1),
    .reset({n0,n0,n0,n0,n0}),
    .set(5'b00000),
    .q(rs1));  // flow_line_reg.v(139)
  reg_ar_as_w5 reg5 (
    .clk(clock),
    .d(i_rd),
    .reset({n0,n0,n0,n0,n0}),
    .set(5'b00000),
    .q(rd));  // flow_line_reg.v(139)
  reg_ar_as_w7 reg6 (
    .clk(clock),
    .d(i_op),
    .reset({n0,n0,n0,n0,n0,n0,n0}),
    .set(7'b0000000),
    .q(op));  // flow_line_reg.v(139)
  reg_ar_as_w32 reg7 (
    .clk(clock),
    .d(i_memstraddr),
    .reset({n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0}),
    .set(32'b00000000000000000000000000000000),
    .q(memstraddr));  // flow_line_reg.v(139)
  reg_ar_as_w32 reg8 (
    .clk(clock),
    .d(i_regdat1),
    .reset({n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0}),
    .set(32'b00000000000000000000000000000000),
    .q(regdat1));  // flow_line_reg.v(139)
  buf u1 (o_rd[3], rd[3]);  // flow_line_reg.v(114)
  buf u10 (o_rs1[0], rs1[0]);  // flow_line_reg.v(112)
  buf u100 (o_memstraddr[4], memstraddr[4]);  // flow_line_reg.v(107)
  buf u101 (o_memstraddr[5], memstraddr[5]);  // flow_line_reg.v(107)
  buf u102 (o_memstraddr[6], memstraddr[6]);  // flow_line_reg.v(107)
  buf u103 (o_memstraddr[7], memstraddr[7]);  // flow_line_reg.v(107)
  buf u104 (o_memstraddr[8], memstraddr[8]);  // flow_line_reg.v(107)
  buf u105 (o_memstraddr[9], memstraddr[9]);  // flow_line_reg.v(107)
  buf u106 (o_memstraddr[10], memstraddr[10]);  // flow_line_reg.v(107)
  buf u107 (o_memstraddr[11], memstraddr[11]);  // flow_line_reg.v(107)
  buf u108 (o_memstraddr[12], memstraddr[12]);  // flow_line_reg.v(107)
  buf u109 (o_memstraddr[13], memstraddr[13]);  // flow_line_reg.v(107)
  buf u11 (o_fun7[0], fun7[0]);  // flow_line_reg.v(113)
  buf u110 (o_memstraddr[14], memstraddr[14]);  // flow_line_reg.v(107)
  buf u111 (o_memstraddr[15], memstraddr[15]);  // flow_line_reg.v(107)
  buf u112 (o_memstraddr[16], memstraddr[16]);  // flow_line_reg.v(107)
  buf u113 (o_memstraddr[17], memstraddr[17]);  // flow_line_reg.v(107)
  buf u114 (o_memstraddr[18], memstraddr[18]);  // flow_line_reg.v(107)
  buf u115 (o_memstraddr[19], memstraddr[19]);  // flow_line_reg.v(107)
  buf u116 (o_memstraddr[20], memstraddr[20]);  // flow_line_reg.v(107)
  buf u117 (o_memstraddr[21], memstraddr[21]);  // flow_line_reg.v(107)
  buf u118 (o_memstraddr[22], memstraddr[22]);  // flow_line_reg.v(107)
  buf u119 (o_memstraddr[23], memstraddr[23]);  // flow_line_reg.v(107)
  buf u12 (o_rd[0], rd[0]);  // flow_line_reg.v(114)
  buf u120 (o_memstraddr[24], memstraddr[24]);  // flow_line_reg.v(107)
  buf u121 (o_memstraddr[25], memstraddr[25]);  // flow_line_reg.v(107)
  buf u122 (o_memstraddr[26], memstraddr[26]);  // flow_line_reg.v(107)
  buf u123 (o_memstraddr[27], memstraddr[27]);  // flow_line_reg.v(107)
  buf u124 (o_memstraddr[28], memstraddr[28]);  // flow_line_reg.v(107)
  buf u125 (o_memstraddr[29], memstraddr[29]);  // flow_line_reg.v(107)
  buf u126 (o_memstraddr[30], memstraddr[30]);  // flow_line_reg.v(107)
  buf u127 (o_memstraddr[31], memstraddr[31]);  // flow_line_reg.v(107)
  buf u128 (o_fun3[1], fun3[1]);  // flow_line_reg.v(106)
  buf u129 (o_fun3[2], fun3[2]);  // flow_line_reg.v(106)
  not u13 (n0, rst);  // flow_line_reg.v(117)
  buf u14 (o_rd[4], rd[4]);  // flow_line_reg.v(114)
  buf u15 (o_fun7[1], fun7[1]);  // flow_line_reg.v(113)
  buf u16 (o_fun7[2], fun7[2]);  // flow_line_reg.v(113)
  buf u17 (o_fun7[3], fun7[3]);  // flow_line_reg.v(113)
  buf u18 (o_fun7[4], fun7[4]);  // flow_line_reg.v(113)
  buf u19 (o_fun7[5], fun7[5]);  // flow_line_reg.v(113)
  buf u2 (o_rd[2], rd[2]);  // flow_line_reg.v(114)
  buf u20 (o_fun7[6], fun7[6]);  // flow_line_reg.v(113)
  buf u21 (o_rs1[1], rs1[1]);  // flow_line_reg.v(112)
  buf u22 (o_rs1[2], rs1[2]);  // flow_line_reg.v(112)
  buf u23 (o_rs1[3], rs1[3]);  // flow_line_reg.v(112)
  buf u24 (o_rs1[4], rs1[4]);  // flow_line_reg.v(112)
  buf u25 (o_rs2[1], rs2[1]);  // flow_line_reg.v(111)
  buf u26 (o_rs2[2], rs2[2]);  // flow_line_reg.v(111)
  buf u27 (o_rs2[3], rs2[3]);  // flow_line_reg.v(111)
  buf u28 (o_rs2[4], rs2[4]);  // flow_line_reg.v(111)
  buf u29 (o_regdat2[1], regdat2[1]);  // flow_line_reg.v(110)
  buf u3 (o_rd[1], rd[1]);  // flow_line_reg.v(114)
  buf u30 (o_regdat2[2], regdat2[2]);  // flow_line_reg.v(110)
  buf u31 (o_regdat2[3], regdat2[3]);  // flow_line_reg.v(110)
  buf u32 (o_regdat2[4], regdat2[4]);  // flow_line_reg.v(110)
  buf u33 (o_regdat2[5], regdat2[5]);  // flow_line_reg.v(110)
  buf u34 (o_regdat2[6], regdat2[6]);  // flow_line_reg.v(110)
  buf u35 (o_regdat2[7], regdat2[7]);  // flow_line_reg.v(110)
  buf u36 (o_regdat2[8], regdat2[8]);  // flow_line_reg.v(110)
  buf u37 (o_regdat2[9], regdat2[9]);  // flow_line_reg.v(110)
  buf u38 (o_regdat2[10], regdat2[10]);  // flow_line_reg.v(110)
  buf u39 (o_regdat2[11], regdat2[11]);  // flow_line_reg.v(110)
  buf u4 (o_fun3[0], fun3[0]);  // flow_line_reg.v(106)
  buf u40 (o_regdat2[12], regdat2[12]);  // flow_line_reg.v(110)
  buf u41 (o_regdat2[13], regdat2[13]);  // flow_line_reg.v(110)
  buf u42 (o_regdat2[14], regdat2[14]);  // flow_line_reg.v(110)
  buf u43 (o_regdat2[15], regdat2[15]);  // flow_line_reg.v(110)
  buf u44 (o_regdat2[16], regdat2[16]);  // flow_line_reg.v(110)
  buf u45 (o_regdat2[17], regdat2[17]);  // flow_line_reg.v(110)
  buf u46 (o_regdat2[18], regdat2[18]);  // flow_line_reg.v(110)
  buf u47 (o_regdat2[19], regdat2[19]);  // flow_line_reg.v(110)
  buf u48 (o_regdat2[20], regdat2[20]);  // flow_line_reg.v(110)
  buf u49 (o_regdat2[21], regdat2[21]);  // flow_line_reg.v(110)
  buf u5 (o_memstraddr[0], memstraddr[0]);  // flow_line_reg.v(107)
  buf u50 (o_regdat2[22], regdat2[22]);  // flow_line_reg.v(110)
  buf u51 (o_regdat2[23], regdat2[23]);  // flow_line_reg.v(110)
  buf u52 (o_regdat2[24], regdat2[24]);  // flow_line_reg.v(110)
  buf u53 (o_regdat2[25], regdat2[25]);  // flow_line_reg.v(110)
  buf u54 (o_regdat2[26], regdat2[26]);  // flow_line_reg.v(110)
  buf u55 (o_regdat2[27], regdat2[27]);  // flow_line_reg.v(110)
  buf u56 (o_regdat2[28], regdat2[28]);  // flow_line_reg.v(110)
  buf u57 (o_regdat2[29], regdat2[29]);  // flow_line_reg.v(110)
  buf u58 (o_regdat2[30], regdat2[30]);  // flow_line_reg.v(110)
  buf u59 (o_regdat2[31], regdat2[31]);  // flow_line_reg.v(110)
  buf u6 (o_op[0], op[0]);  // flow_line_reg.v(108)
  buf u60 (o_regdat1[1], regdat1[1]);  // flow_line_reg.v(109)
  buf u61 (o_regdat1[2], regdat1[2]);  // flow_line_reg.v(109)
  buf u62 (o_regdat1[3], regdat1[3]);  // flow_line_reg.v(109)
  buf u63 (o_regdat1[4], regdat1[4]);  // flow_line_reg.v(109)
  buf u64 (o_regdat1[5], regdat1[5]);  // flow_line_reg.v(109)
  buf u65 (o_regdat1[6], regdat1[6]);  // flow_line_reg.v(109)
  buf u66 (o_regdat1[7], regdat1[7]);  // flow_line_reg.v(109)
  buf u67 (o_regdat1[8], regdat1[8]);  // flow_line_reg.v(109)
  buf u68 (o_regdat1[9], regdat1[9]);  // flow_line_reg.v(109)
  buf u69 (o_regdat1[10], regdat1[10]);  // flow_line_reg.v(109)
  buf u7 (o_regdat1[0], regdat1[0]);  // flow_line_reg.v(109)
  buf u70 (o_regdat1[11], regdat1[11]);  // flow_line_reg.v(109)
  buf u71 (o_regdat1[12], regdat1[12]);  // flow_line_reg.v(109)
  buf u72 (o_regdat1[13], regdat1[13]);  // flow_line_reg.v(109)
  buf u73 (o_regdat1[14], regdat1[14]);  // flow_line_reg.v(109)
  buf u74 (o_regdat1[15], regdat1[15]);  // flow_line_reg.v(109)
  buf u75 (o_regdat1[16], regdat1[16]);  // flow_line_reg.v(109)
  buf u76 (o_regdat1[17], regdat1[17]);  // flow_line_reg.v(109)
  buf u77 (o_regdat1[18], regdat1[18]);  // flow_line_reg.v(109)
  buf u78 (o_regdat1[19], regdat1[19]);  // flow_line_reg.v(109)
  buf u79 (o_regdat1[20], regdat1[20]);  // flow_line_reg.v(109)
  buf u8 (o_regdat2[0], regdat2[0]);  // flow_line_reg.v(110)
  buf u80 (o_regdat1[21], regdat1[21]);  // flow_line_reg.v(109)
  buf u81 (o_regdat1[22], regdat1[22]);  // flow_line_reg.v(109)
  buf u82 (o_regdat1[23], regdat1[23]);  // flow_line_reg.v(109)
  buf u83 (o_regdat1[24], regdat1[24]);  // flow_line_reg.v(109)
  buf u84 (o_regdat1[25], regdat1[25]);  // flow_line_reg.v(109)
  buf u85 (o_regdat1[26], regdat1[26]);  // flow_line_reg.v(109)
  buf u86 (o_regdat1[27], regdat1[27]);  // flow_line_reg.v(109)
  buf u87 (o_regdat1[28], regdat1[28]);  // flow_line_reg.v(109)
  buf u88 (o_regdat1[29], regdat1[29]);  // flow_line_reg.v(109)
  buf u89 (o_regdat1[30], regdat1[30]);  // flow_line_reg.v(109)
  buf u9 (o_rs2[0], rs2[0]);  // flow_line_reg.v(111)
  buf u90 (o_regdat1[31], regdat1[31]);  // flow_line_reg.v(109)
  buf u91 (o_op[1], op[1]);  // flow_line_reg.v(108)
  buf u92 (o_op[2], op[2]);  // flow_line_reg.v(108)
  buf u93 (o_op[3], op[3]);  // flow_line_reg.v(108)
  buf u94 (o_op[4], op[4]);  // flow_line_reg.v(108)
  buf u95 (o_op[5], op[5]);  // flow_line_reg.v(108)
  buf u96 (o_op[6], op[6]);  // flow_line_reg.v(108)
  buf u97 (o_memstraddr[1], memstraddr[1]);  // flow_line_reg.v(107)
  buf u98 (o_memstraddr[2], memstraddr[2]);  // flow_line_reg.v(107)
  buf u99 (o_memstraddr[3], memstraddr[3]);  // flow_line_reg.v(107)

endmodule 

module IF_ID_reg  // flow_line_reg.v(3)
  (
  clock,
  i_LW_block,
  i_bus_block,
  i_fun3,
  i_fun7,
  i_instraddr,
  i_instrnop,
  i_jump_cs,
  i_jump_risk_block,
  i_op,
  i_rd,
  i_rs1,
  i_rs2,
  rst,
  o_fun3,
  o_fun7,
  o_instraddr,
  o_op,
  o_rd,
  o_rs1,
  o_rs2
  );

  input clock;  // flow_line_reg.v(3)
  input i_LW_block;  // flow_line_reg.v(13)
  input i_bus_block;  // flow_line_reg.v(12)
  input [2:0] i_fun3;  // flow_line_reg.v(6)
  input [6:0] i_fun7;  // flow_line_reg.v(7)
  input [31:0] i_instraddr;  // flow_line_reg.v(5)
  input i_instrnop;  // flow_line_reg.v(11)
  input i_jump_cs;  // flow_line_reg.v(14)
  input i_jump_risk_block;  // flow_line_reg.v(15)
  input [6:0] i_op;  // flow_line_reg.v(4)
  input [4:0] i_rd;  // flow_line_reg.v(8)
  input [4:0] i_rs1;  // flow_line_reg.v(9)
  input [4:0] i_rs2;  // flow_line_reg.v(10)
  input rst;  // flow_line_reg.v(3)
  output [2:0] o_fun3;  // flow_line_reg.v(17)
  output [6:0] o_fun7;  // flow_line_reg.v(18)
  output [31:0] o_instraddr;  // flow_line_reg.v(21)
  output [6:0] o_op;  // flow_line_reg.v(16)
  output [4:0] o_rd;  // flow_line_reg.v(19)
  output [4:0] o_rs1;  // flow_line_reg.v(20)
  output [4:0] o_rs2;  // flow_line_reg.v(22)

  wire [2:0] fun3;  // flow_line_reg.v(25)
  wire [6:0] fun7;  // flow_line_reg.v(26)
  wire [31:0] instraddr;  // flow_line_reg.v(23)
  wire [6:0] n10;
  wire [2:0] n11;
  wire [6:0] n12;
  wire [4:0] n13;
  wire [4:0] n14;
  wire [4:0] n15;
  wire [31:0] n16;
  wire [6:0] op;  // flow_line_reg.v(24)
  wire [4:0] rd;  // flow_line_reg.v(27)
  wire [4:0] rs1;  // flow_line_reg.v(28)
  wire [4:0] rs2;  // flow_line_reg.v(29)
  wire n0;
  wire n1;
  wire n2;
  wire n3;
  wire n4;
  wire n5;
  wire n6;
  wire n7;
  wire n8;
  wire n9;

  eq_w1 eq0 (
    .i0(i_instrnop),
    .i1(1'b1),
    .o(n1));  // flow_line_reg.v(51)
  eq_w1 eq1 (
    .i0(i_bus_block),
    .i1(1'b1),
    .o(n2));  // flow_line_reg.v(52)
  eq_w1 eq2 (
    .i0(i_LW_block),
    .i1(1'b1),
    .o(n4));  // flow_line_reg.v(53)
  eq_w1 eq3 (
    .i0(i_jump_cs),
    .i1(1'b1),
    .o(n6));  // flow_line_reg.v(54)
  eq_w1 eq4 (
    .i0(i_jump_risk_block),
    .i1(1'b1),
    .o(n8));  // flow_line_reg.v(55)
  binary_mux_s1_w7 mux0 (
    .i0(i_op),
    .i1(7'b0000000),
    .sel(n9),
    .o(n10));  // flow_line_reg.v(71)
  binary_mux_s1_w3 mux1 (
    .i0(i_fun3),
    .i1(3'b000),
    .sel(n9),
    .o(n11));  // flow_line_reg.v(71)
  binary_mux_s1_w7 mux2 (
    .i0(i_fun7),
    .i1(7'b0000000),
    .sel(n9),
    .o(n12));  // flow_line_reg.v(71)
  binary_mux_s1_w5 mux3 (
    .i0(i_rd),
    .i1(5'b00000),
    .sel(n9),
    .o(n13));  // flow_line_reg.v(71)
  binary_mux_s1_w5 mux4 (
    .i0(i_rs1),
    .i1(5'b00000),
    .sel(n9),
    .o(n14));  // flow_line_reg.v(71)
  binary_mux_s1_w5 mux5 (
    .i0(i_rs2),
    .i1(5'b00000),
    .sel(n9),
    .o(n15));  // flow_line_reg.v(71)
  binary_mux_s1_w32 mux6 (
    .i0(i_instraddr),
    .i1(instraddr),
    .sel(n9),
    .o(n16));  // flow_line_reg.v(71)
  reg_ar_as_w3 reg0 (
    .clk(clock),
    .d(n11),
    .reset({n0,n0,n0}),
    .set(3'b000),
    .q(fun3));  // flow_line_reg.v(71)
  reg_ar_as_w7 reg1 (
    .clk(clock),
    .d(n12),
    .reset({n0,n0,n0,n0,n0,n0,n0}),
    .set(7'b0000000),
    .q(fun7));  // flow_line_reg.v(71)
  reg_ar_as_w5 reg2 (
    .clk(clock),
    .d(n13),
    .reset({n0,n0,n0,n0,n0}),
    .set(5'b00000),
    .q(rd));  // flow_line_reg.v(71)
  reg_ar_as_w5 reg3 (
    .clk(clock),
    .d(n14),
    .reset({n0,n0,n0,n0,n0}),
    .set(5'b00000),
    .q(rs1));  // flow_line_reg.v(71)
  reg_ar_as_w5 reg4 (
    .clk(clock),
    .d(n15),
    .reset({n0,n0,n0,n0,n0}),
    .set(5'b00000),
    .q(rs2));  // flow_line_reg.v(71)
  reg_ar_as_w32 reg5 (
    .clk(clock),
    .d(n16),
    .reset({n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0}),
    .set(32'b00000000000000000000000000000000),
    .q(instraddr));  // flow_line_reg.v(71)
  reg_ar_as_w7 reg6 (
    .clk(clock),
    .d(n10),
    .reset({n0,n0,n0,n0,n0,n0,n0}),
    .set(7'b0000000),
    .q(op));  // flow_line_reg.v(71)
  buf u10 (o_rs2[0], rs2[0]);  // flow_line_reg.v(37)
  not u11 (n0, rst);  // flow_line_reg.v(42)
  or u12 (n3, n1, n2);  // flow_line_reg.v(52)
  or u13 (n5, n3, n4);  // flow_line_reg.v(53)
  or u14 (n7, n5, n6);  // flow_line_reg.v(54)
  or u15 (n9, n7, n8);  // flow_line_reg.v(55)
  buf u16 (o_rs2[3], rs2[3]);  // flow_line_reg.v(37)
  buf u17 (o_rs2[4], rs2[4]);  // flow_line_reg.v(37)
  buf u18 (o_rs1[1], rs1[1]);  // flow_line_reg.v(36)
  buf u19 (o_rs1[2], rs1[2]);  // flow_line_reg.v(36)
  buf u2 (o_rs2[2], rs2[2]);  // flow_line_reg.v(37)
  buf u20 (o_rs1[3], rs1[3]);  // flow_line_reg.v(36)
  buf u21 (o_rs1[4], rs1[4]);  // flow_line_reg.v(36)
  buf u22 (o_rd[1], rd[1]);  // flow_line_reg.v(35)
  buf u23 (o_rd[2], rd[2]);  // flow_line_reg.v(35)
  buf u24 (o_rd[3], rd[3]);  // flow_line_reg.v(35)
  buf u25 (o_rd[4], rd[4]);  // flow_line_reg.v(35)
  buf u26 (o_fun7[1], fun7[1]);  // flow_line_reg.v(34)
  buf u27 (o_fun7[2], fun7[2]);  // flow_line_reg.v(34)
  buf u28 (o_fun7[3], fun7[3]);  // flow_line_reg.v(34)
  buf u29 (o_fun7[4], fun7[4]);  // flow_line_reg.v(34)
  buf u3 (o_rs2[1], rs2[1]);  // flow_line_reg.v(37)
  buf u30 (o_fun7[5], fun7[5]);  // flow_line_reg.v(34)
  buf u31 (o_fun7[6], fun7[6]);  // flow_line_reg.v(34)
  buf u32 (o_fun3[1], fun3[1]);  // flow_line_reg.v(33)
  buf u33 (o_fun3[2], fun3[2]);  // flow_line_reg.v(33)
  buf u34 (o_op[1], op[1]);  // flow_line_reg.v(32)
  buf u35 (o_op[2], op[2]);  // flow_line_reg.v(32)
  buf u36 (o_op[3], op[3]);  // flow_line_reg.v(32)
  buf u37 (o_op[4], op[4]);  // flow_line_reg.v(32)
  buf u38 (o_op[5], op[5]);  // flow_line_reg.v(32)
  buf u39 (o_op[6], op[6]);  // flow_line_reg.v(32)
  buf u4 (o_instraddr[0], instraddr[0]);  // flow_line_reg.v(31)
  buf u40 (o_instraddr[1], instraddr[1]);  // flow_line_reg.v(31)
  buf u41 (o_instraddr[2], instraddr[2]);  // flow_line_reg.v(31)
  buf u42 (o_instraddr[3], instraddr[3]);  // flow_line_reg.v(31)
  buf u43 (o_instraddr[4], instraddr[4]);  // flow_line_reg.v(31)
  buf u44 (o_instraddr[5], instraddr[5]);  // flow_line_reg.v(31)
  buf u45 (o_instraddr[6], instraddr[6]);  // flow_line_reg.v(31)
  buf u46 (o_instraddr[7], instraddr[7]);  // flow_line_reg.v(31)
  buf u47 (o_instraddr[8], instraddr[8]);  // flow_line_reg.v(31)
  buf u48 (o_instraddr[9], instraddr[9]);  // flow_line_reg.v(31)
  buf u49 (o_instraddr[10], instraddr[10]);  // flow_line_reg.v(31)
  buf u5 (o_op[0], op[0]);  // flow_line_reg.v(32)
  buf u50 (o_instraddr[11], instraddr[11]);  // flow_line_reg.v(31)
  buf u51 (o_instraddr[12], instraddr[12]);  // flow_line_reg.v(31)
  buf u52 (o_instraddr[13], instraddr[13]);  // flow_line_reg.v(31)
  buf u53 (o_instraddr[14], instraddr[14]);  // flow_line_reg.v(31)
  buf u54 (o_instraddr[15], instraddr[15]);  // flow_line_reg.v(31)
  buf u55 (o_instraddr[16], instraddr[16]);  // flow_line_reg.v(31)
  buf u56 (o_instraddr[17], instraddr[17]);  // flow_line_reg.v(31)
  buf u57 (o_instraddr[18], instraddr[18]);  // flow_line_reg.v(31)
  buf u58 (o_instraddr[19], instraddr[19]);  // flow_line_reg.v(31)
  buf u59 (o_instraddr[20], instraddr[20]);  // flow_line_reg.v(31)
  buf u6 (o_fun3[0], fun3[0]);  // flow_line_reg.v(33)
  buf u60 (o_instraddr[21], instraddr[21]);  // flow_line_reg.v(31)
  buf u61 (o_instraddr[22], instraddr[22]);  // flow_line_reg.v(31)
  buf u62 (o_instraddr[23], instraddr[23]);  // flow_line_reg.v(31)
  buf u63 (o_instraddr[24], instraddr[24]);  // flow_line_reg.v(31)
  buf u64 (o_instraddr[25], instraddr[25]);  // flow_line_reg.v(31)
  buf u65 (o_instraddr[26], instraddr[26]);  // flow_line_reg.v(31)
  buf u66 (o_instraddr[27], instraddr[27]);  // flow_line_reg.v(31)
  buf u67 (o_instraddr[28], instraddr[28]);  // flow_line_reg.v(31)
  buf u68 (o_instraddr[29], instraddr[29]);  // flow_line_reg.v(31)
  buf u69 (o_instraddr[30], instraddr[30]);  // flow_line_reg.v(31)
  buf u7 (o_fun7[0], fun7[0]);  // flow_line_reg.v(34)
  buf u70 (o_instraddr[31], instraddr[31]);  // flow_line_reg.v(31)
  buf u8 (o_rd[0], rd[0]);  // flow_line_reg.v(35)
  buf u9 (o_rs1[0], rs1[0]);  // flow_line_reg.v(36)

endmodule 

module PC  // PC.v(2)
  (
  clock,
  i_LW_block,
  i_bus_block,
  i_jump_addr,
  i_jump_cs,
  i_jump_risk_block,
  i_memdat,
  i_memread,
  i_nowjumpstraddr,
  i_skip_addr,
  i_skip_cs,
  rst,
  o_instraddr,
  o_instrnop
  );

  input clock;  // PC.v(2)
  input i_LW_block;  // PC.v(5)
  input i_bus_block;  // PC.v(4)
  input [31:0] i_jump_addr;  // PC.v(8)
  input i_jump_cs;  // PC.v(7)
  input i_jump_risk_block;  // PC.v(12)
  input [31:0] i_memdat;  // PC.v(10)
  input i_memread;  // PC.v(3)
  input [31:0] i_nowjumpstraddr;  // PC.v(11)
  input [31:0] i_skip_addr;  // PC.v(9)
  input i_skip_cs;  // PC.v(6)
  input rst;  // PC.v(2)
  output [31:0] o_instraddr;  // PC.v(13)
  output o_instrnop;  // PC.v(14)

  wire [31:0] instraddr;  // PC.v(16)
  wire [31:0] n10;
  wire [31:0] n12;
  wire [31:0] n14;
  wire [31:0] n15;
  wire [29:0] n16;
  wire [31:0] n17;
  wire [31:0] n18;
  wire [31:0] n19;
  wire instr_nop;  // PC.v(17)
  wire n0;
  wire n1;
  wire n11;
  wire n13;
  wire n2;
  wire n20;
  wire n3;
  wire n4;
  wire n5;
  wire n6;
  wire n7;
  wire n8;
  wire n9;

  add_pu32_pu32_o32 add0 (
    .i0(instraddr),
    .i1(i_skip_addr),
    .o(n12));  // PC.v(50)
  add_pu32_pu32_o32 add1 (
    .i0(instraddr),
    .i1(i_jump_addr),
    .o(n14));  // PC.v(54)
  add_pu30_pu30_o30 add2 (
    .i0(instraddr[31:2]),
    .i1(30'b000000000000000000000000000001),
    .o(n16));  // PC.v(58)
  eq_w1 eq0 (
    .i0(i_memread),
    .i1(1'b1),
    .o(n1));  // PC.v(35)
  eq_w32 eq1 (
    .i0(i_memdat),
    .i1(32'b00000000000000000000000000000000),
    .o(n2));  // PC.v(35)
  eq_w1 eq2 (
    .i0(i_LW_block),
    .i1(1'b1),
    .o(n4));  // PC.v(36)
  eq_w1 eq3 (
    .i0(i_bus_block),
    .i1(1'b1),
    .o(n6));  // PC.v(37)
  eq_w1 eq4 (
    .i0(i_jump_risk_block),
    .i1(1'b1),
    .o(n8));  // PC.v(38)
  eq_w1 eq5 (
    .i0(i_skip_cs),
    .i1(1'b1),
    .o(n11));  // PC.v(49)
  eq_w1 eq6 (
    .i0(i_jump_cs),
    .i1(1'b1),
    .o(n13));  // PC.v(53)
  AL_DFF instr_nop_reg (
    .clk(clock),
    .d(n20),
    .reset(n0),
    .set(1'b0),
    .q(instr_nop));  // PC.v(60)
  binary_mux_s1_w32 mux0 (
    .i0(instraddr),
    .i1(i_nowjumpstraddr),
    .sel(n8),
    .o(n10));  // PC.v(42)
  binary_mux_s1_w32 mux1 (
    .i0({n16,instraddr[1:0]}),
    .i1(n15),
    .sel(n13),
    .o(n17));  // PC.v(60)
  binary_mux_s1_w32 mux2 (
    .i0(n17),
    .i1(n12),
    .sel(n11),
    .o(n18));  // PC.v(60)
  binary_mux_s1_w32 mux3 (
    .i0(n18),
    .i1(n10),
    .sel(n9),
    .o(n19));  // PC.v(60)
  reg_ar_as_w32 reg0 (
    .clk(clock),
    .d(n19),
    .reset({n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,n0,1'b0,n0,n0}),
    .set({29'b00000000000000000000000000000,n0,2'b00}),
    .q(instraddr));  // PC.v(60)
  add_pu32_mu32_o32 sub0 (
    .i0(n14),
    .i1(32'b00000000000000000000000000000100),
    .o(n15));  // PC.v(54)
  and u10 (n3, n1, n2);  // PC.v(35)
  or u11 (n5, n3, n4);  // PC.v(36)
  or u12 (n7, n5, n6);  // PC.v(37)
  or u13 (n9, n7, n8);  // PC.v(38)
  buf u14 (o_instraddr[3], instraddr[3]);  // PC.v(22)
  buf u15 (o_instraddr[2], instraddr[2]);  // PC.v(22)
  buf u16 (o_instraddr[1], instraddr[1]);  // PC.v(22)
  buf u17 (o_instraddr[0], instraddr[0]);  // PC.v(22)
  AL_MUX u18 (
    .i0(1'b0),
    .i1(n3),
    .sel(n9),
    .o(n20));  // PC.v(60)
  buf u19 (o_instraddr[11], instraddr[11]);  // PC.v(22)
  buf u2 (o_instraddr[10], instraddr[10]);  // PC.v(22)
  buf u20 (o_instraddr[5], instraddr[5]);  // PC.v(22)
  buf u21 (o_instraddr[12], instraddr[12]);  // PC.v(22)
  buf u22 (o_instraddr[13], instraddr[13]);  // PC.v(22)
  buf u23 (o_instraddr[14], instraddr[14]);  // PC.v(22)
  buf u24 (o_instraddr[15], instraddr[15]);  // PC.v(22)
  buf u25 (o_instraddr[16], instraddr[16]);  // PC.v(22)
  buf u26 (o_instraddr[17], instraddr[17]);  // PC.v(22)
  buf u27 (o_instraddr[18], instraddr[18]);  // PC.v(22)
  buf u28 (o_instraddr[19], instraddr[19]);  // PC.v(22)
  buf u29 (o_instraddr[20], instraddr[20]);  // PC.v(22)
  buf u3 (o_instraddr[9], instraddr[9]);  // PC.v(22)
  buf u30 (o_instraddr[21], instraddr[21]);  // PC.v(22)
  buf u31 (o_instraddr[22], instraddr[22]);  // PC.v(22)
  buf u32 (o_instraddr[23], instraddr[23]);  // PC.v(22)
  buf u33 (o_instraddr[24], instraddr[24]);  // PC.v(22)
  buf u34 (o_instraddr[25], instraddr[25]);  // PC.v(22)
  buf u35 (o_instraddr[26], instraddr[26]);  // PC.v(22)
  buf u36 (o_instraddr[27], instraddr[27]);  // PC.v(22)
  buf u37 (o_instraddr[28], instraddr[28]);  // PC.v(22)
  buf u38 (o_instraddr[29], instraddr[29]);  // PC.v(22)
  buf u39 (o_instraddr[30], instraddr[30]);  // PC.v(22)
  buf u4 (o_instrnop, instr_nop);  // PC.v(21)
  buf u40 (o_instraddr[31], instraddr[31]);  // PC.v(22)
  buf u5 (o_instraddr[8], instraddr[8]);  // PC.v(22)
  buf u6 (o_instraddr[7], instraddr[7]);  // PC.v(22)
  buf u7 (o_instraddr[4], instraddr[4]);  // PC.v(22)
  buf u8 (o_instraddr[6], instraddr[6]);  // PC.v(22)
  not u9 (n0, rst);  // PC.v(31)

endmodule 

module coding  // PC.v(65)
  (
  i_i_instr,
  o_fun3,
  o_fun7,
  o_op,
  o_rd,
  o_rs1,
  o_rs2
  );

  input [31:0] i_i_instr;  // PC.v(66)
  output [2:0] o_fun3;  // PC.v(68)
  output [6:0] o_fun7;  // PC.v(69)
  output [6:0] o_op;  // PC.v(67)
  output [4:0] o_rd;  // PC.v(70)
  output [4:0] o_rs1;  // PC.v(71)
  output [4:0] o_rs2;  // PC.v(72)


  buf u0 (o_rs2[3], i_i_instr[23]);  // PC.v(85)
  buf u1 (o_rs2[2], i_i_instr[22]);  // PC.v(85)
  buf u10 (o_rs1[1], i_i_instr[16]);  // PC.v(85)
  buf u11 (o_rs1[2], i_i_instr[17]);  // PC.v(85)
  buf u12 (o_rs1[3], i_i_instr[18]);  // PC.v(85)
  buf u13 (o_rs1[4], i_i_instr[19]);  // PC.v(85)
  buf u14 (o_rd[1], i_i_instr[8]);  // PC.v(85)
  buf u15 (o_rd[2], i_i_instr[9]);  // PC.v(85)
  buf u16 (o_rd[3], i_i_instr[10]);  // PC.v(85)
  buf u17 (o_rd[4], i_i_instr[11]);  // PC.v(85)
  buf u18 (o_fun7[1], i_i_instr[26]);  // PC.v(85)
  buf u19 (o_fun7[2], i_i_instr[27]);  // PC.v(85)
  buf u2 (o_rs2[1], i_i_instr[21]);  // PC.v(85)
  buf u20 (o_fun7[3], i_i_instr[28]);  // PC.v(85)
  buf u21 (o_fun7[4], i_i_instr[29]);  // PC.v(85)
  buf u22 (o_fun7[5], i_i_instr[30]);  // PC.v(85)
  buf u23 (o_fun7[6], i_i_instr[31]);  // PC.v(85)
  buf u24 (o_fun3[1], i_i_instr[13]);  // PC.v(85)
  buf u25 (o_fun3[2], i_i_instr[14]);  // PC.v(85)
  buf u26 (o_op[1], i_i_instr[1]);  // PC.v(85)
  buf u27 (o_op[2], i_i_instr[2]);  // PC.v(85)
  buf u28 (o_op[3], i_i_instr[3]);  // PC.v(85)
  buf u29 (o_op[4], i_i_instr[4]);  // PC.v(85)
  buf u3 (o_rs2[0], i_i_instr[20]);  // PC.v(85)
  buf u30 (o_op[5], i_i_instr[5]);  // PC.v(85)
  buf u31 (o_op[6], i_i_instr[6]);  // PC.v(85)
  buf u4 (o_op[0], i_i_instr[0]);  // PC.v(85)
  buf u5 (o_fun3[0], i_i_instr[12]);  // PC.v(85)
  buf u6 (o_fun7[0], i_i_instr[25]);  // PC.v(85)
  buf u7 (o_rd[0], i_i_instr[7]);  // PC.v(85)
  buf u8 (o_rs1[0], i_i_instr[15]);  // PC.v(85)
  buf u9 (o_rs2[4], i_i_instr[24]);  // PC.v(85)

endmodule 

module MEM_WB_reg  // flow_line_reg.v(197)
  (
  clock,
  i_aludat,
  i_memdat,
  i_op,
  i_rd,
  rst,
  o_op,
  o_rd,
  o_reg_writedat,
  o_regwritecs
  );

  input clock;  // flow_line_reg.v(197)
  input [31:0] i_aludat;  // flow_line_reg.v(198)
  input [31:0] i_memdat;  // flow_line_reg.v(199)
  input [6:0] i_op;  // flow_line_reg.v(201)
  input [4:0] i_rd;  // flow_line_reg.v(200)
  input rst;  // flow_line_reg.v(197)
  output [6:0] o_op;  // flow_line_reg.v(205)
  output [4:0] o_rd;  // flow_line_reg.v(204)
  output [31:0] o_reg_writedat;  // flow_line_reg.v(203)
  output o_regwritecs;  // flow_line_reg.v(202)

  wire [6:0] n15;
  wire [31:0] n5;
  wire [6:0] op;  // flow_line_reg.v(210)
  wire [4:0] rd;  // flow_line_reg.v(207)
  wire [31:0] reg_writedat;  // flow_line_reg.v(208)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n2;
  wire n3;
  wire n4;
  wire n6;
  wire n7;
  wire n8;
  wire n9;
  wire regwritecs;  // flow_line_reg.v(209)

  eq_w7 eq0 (
    .i0(i_op),
    .i1(7'b0000011),
    .o(n4));  // flow_line_reg.v(227)
  eq_w7 eq1 (
    .i0(i_op),
    .i1(7'b0100011),
    .o(n6));  // flow_line_reg.v(228)
  eq_w7 eq2 (
    .i0(i_op),
    .i1(7'b1100011),
    .o(n7));  // flow_line_reg.v(229)
  eq_w7 eq3 (
    .i0(i_op),
    .i1(7'b0000000),
    .o(n9));  // flow_line_reg.v(230)
  binary_mux_s1_w32 mux0 (
    .i0(i_aludat),
    .i1(i_memdat),
    .sel(n4),
    .o(n5));  // flow_line_reg.v(227)
  binary_mux_s1_w7 mux1 (
    .i0(i_op),
    .i1(op),
    .sel(n3),
    .o(n15));  // flow_line_reg.v(234)
  reg_ar_as_w32 reg0 (
    .clk(clock),
    .d(n5),
    .reset({n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3,n3}),
    .set(32'b00000000000000000000000000000000),
    .q(reg_writedat));  // flow_line_reg.v(234)
  reg_ar_as_w7 reg1 (
    .clk(clock),
    .d(n15),
    .reset(7'b0000000),
    .set(7'b0000000),
    .q(op));  // flow_line_reg.v(234)
  reg_ar_as_w5 reg2 (
    .clk(clock),
    .d(i_rd),
    .reset({n3,n3,n3,n3,n3}),
    .set(5'b00000),
    .q(rd));  // flow_line_reg.v(234)
  AL_DFF regwritecs_reg (
    .clk(clock),
    .d(n12),
    .reset(n3),
    .set(1'b0),
    .q(regwritecs));  // flow_line_reg.v(234)
  or u10 (n10, n8, n9);  // flow_line_reg.v(230)
  buf u11 (o_rd[0], rd[0]);  // flow_line_reg.v(215)
  AL_MUX u12 (
    .i0(n11),
    .i1(1'b0),
    .sel(n10),
    .o(n12));  // flow_line_reg.v(233)
  or u13 (n14, i_op[5], i_op[6]);  // flow_line_reg.v(232)
  or u14 (n13, n0, n14);  // flow_line_reg.v(232)
  or u15 (n11, n1, n13);  // flow_line_reg.v(232)
  buf u16 (o_rd[1], rd[1]);  // flow_line_reg.v(215)
  buf u17 (o_rd[2], rd[2]);  // flow_line_reg.v(215)
  buf u18 (o_rd[3], rd[3]);  // flow_line_reg.v(215)
  buf u19 (o_rd[4], rd[4]);  // flow_line_reg.v(215)
  or u2 (n0, i_op[3], i_op[4]);  // flow_line_reg.v(232)
  buf u20 (o_reg_writedat[1], reg_writedat[1]);  // flow_line_reg.v(213)
  buf u21 (o_reg_writedat[2], reg_writedat[2]);  // flow_line_reg.v(213)
  buf u22 (o_reg_writedat[3], reg_writedat[3]);  // flow_line_reg.v(213)
  buf u23 (o_reg_writedat[4], reg_writedat[4]);  // flow_line_reg.v(213)
  buf u24 (o_reg_writedat[5], reg_writedat[5]);  // flow_line_reg.v(213)
  buf u25 (o_reg_writedat[6], reg_writedat[6]);  // flow_line_reg.v(213)
  buf u26 (o_reg_writedat[7], reg_writedat[7]);  // flow_line_reg.v(213)
  buf u27 (o_reg_writedat[8], reg_writedat[8]);  // flow_line_reg.v(213)
  buf u28 (o_reg_writedat[9], reg_writedat[9]);  // flow_line_reg.v(213)
  buf u29 (o_reg_writedat[10], reg_writedat[10]);  // flow_line_reg.v(213)
  or u3 (n1, i_op[0], n2);  // flow_line_reg.v(232)
  buf u30 (o_reg_writedat[11], reg_writedat[11]);  // flow_line_reg.v(213)
  buf u31 (o_reg_writedat[12], reg_writedat[12]);  // flow_line_reg.v(213)
  buf u32 (o_reg_writedat[13], reg_writedat[13]);  // flow_line_reg.v(213)
  buf u33 (o_reg_writedat[14], reg_writedat[14]);  // flow_line_reg.v(213)
  buf u34 (o_reg_writedat[15], reg_writedat[15]);  // flow_line_reg.v(213)
  buf u35 (o_reg_writedat[16], reg_writedat[16]);  // flow_line_reg.v(213)
  buf u36 (o_reg_writedat[17], reg_writedat[17]);  // flow_line_reg.v(213)
  buf u37 (o_reg_writedat[18], reg_writedat[18]);  // flow_line_reg.v(213)
  buf u38 (o_reg_writedat[19], reg_writedat[19]);  // flow_line_reg.v(213)
  buf u39 (o_reg_writedat[20], reg_writedat[20]);  // flow_line_reg.v(213)
  buf u4 (o_op[0], op[0]);  // flow_line_reg.v(212)
  buf u40 (o_reg_writedat[21], reg_writedat[21]);  // flow_line_reg.v(213)
  buf u41 (o_reg_writedat[22], reg_writedat[22]);  // flow_line_reg.v(213)
  buf u42 (o_reg_writedat[23], reg_writedat[23]);  // flow_line_reg.v(213)
  buf u43 (o_reg_writedat[24], reg_writedat[24]);  // flow_line_reg.v(213)
  buf u44 (o_reg_writedat[25], reg_writedat[25]);  // flow_line_reg.v(213)
  buf u45 (o_reg_writedat[26], reg_writedat[26]);  // flow_line_reg.v(213)
  buf u46 (o_reg_writedat[27], reg_writedat[27]);  // flow_line_reg.v(213)
  buf u47 (o_reg_writedat[28], reg_writedat[28]);  // flow_line_reg.v(213)
  buf u48 (o_reg_writedat[29], reg_writedat[29]);  // flow_line_reg.v(213)
  buf u49 (o_reg_writedat[30], reg_writedat[30]);  // flow_line_reg.v(213)
  buf u5 (o_regwritecs, regwritecs);  // flow_line_reg.v(214)
  buf u50 (o_reg_writedat[31], reg_writedat[31]);  // flow_line_reg.v(213)
  buf u51 (o_op[1], op[1]);  // flow_line_reg.v(212)
  buf u52 (o_op[2], op[2]);  // flow_line_reg.v(212)
  buf u53 (o_op[3], op[3]);  // flow_line_reg.v(212)
  buf u54 (o_op[4], op[4]);  // flow_line_reg.v(212)
  buf u55 (o_op[5], op[5]);  // flow_line_reg.v(212)
  buf u56 (o_op[6], op[6]);  // flow_line_reg.v(212)
  buf u6 (o_reg_writedat[0], reg_writedat[0]);  // flow_line_reg.v(213)
  or u7 (n2, i_op[1], i_op[2]);  // flow_line_reg.v(232)
  not u8 (n3, rst);  // flow_line_reg.v(219)
  or u9 (n8, n6, n7);  // flow_line_reg.v(229)

endmodule 

module binary_mux_s1_w2
  (
  i0,
  i1,
  sel,
  o
  );

  input [1:0] i0;
  input [1:0] i1;
  input sel;
  output [1:0] o;



endmodule 

module binary_mux_s1_w32
  (
  i0,
  i1,
  sel,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  input sel;
  output [31:0] o;



endmodule 

module binary_mux_s3_w32
  (
  i0,
  i1,
  i2,
  i3,
  i4,
  i5,
  i6,
  i7,
  sel,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  input [31:0] i2;
  input [31:0] i3;
  input [31:0] i4;
  input [31:0] i5;
  input [31:0] i6;
  input [31:0] i7;
  input [2:0] sel;
  output [31:0] o;



endmodule 

module ne_w7
  (
  i0,
  i1,
  o
  );

  input [6:0] i0;
  input [6:0] i1;
  output o;



endmodule 

module ne_w32
  (
  i0,
  i1,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  output o;



endmodule 

module ne_w5
  (
  i0,
  i1,
  o
  );

  input [4:0] i0;
  input [4:0] i1;
  output o;



endmodule 

module register  // register.v(1)
  (
  i_clock,
  i_rd,
  i_rs1,
  i_rs2,
  i_rst,
  i_write_cs,
  regdat,
  o_read_dat1,
  o_read_dat2
  );

  input i_clock;  // register.v(1)
  input [4:0] i_rd;  // register.v(3)
  input [4:0] i_rs1;  // register.v(1)
  input [4:0] i_rs2;  // register.v(1)
  input i_rst;  // register.v(1)
  input i_write_cs;  // register.v(3)
  input [31:0] regdat;  // register.v(3)
  output [31:0] o_read_dat1;  // register.v(2)
  output [31:0] o_read_dat2;  // register.v(2)

  wire [31:0] n41;
  wire [31:0] n42;
  wire [31:0] n43;
  wire [31:0] n44;
  wire [31:0] n46;
  wire [31:0] n47;
  wire [31:0] n48;
  wire [31:0] n49;
  wire [31:0] n5;
  wire [31:0] n50;
  wire [31:0] n51;
  wire [31:0] n52;
  wire [31:0] n53;
  wire [31:0] n54;
  wire [31:0] n55;
  wire [31:0] n56;
  wire [31:0] n57;
  wire [31:0] n58;
  wire [31:0] n59;
  wire [31:0] n60;
  wire [31:0] n61;
  wire [31:0] n62;
  wire [31:0] n63;
  wire [31:0] n64;
  wire [31:0] n65;
  wire [31:0] n66;
  wire [31:0] n67;
  wire [31:0] n68;
  wire [31:0] n69;
  wire [31:0] n7;
  wire [31:0] n70;
  wire [31:0] n71;
  wire [31:0] n72;
  wire [31:0] n73;
  wire [31:0] n74;
  wire [31:0] n75;
  wire [31:0] n76;
  wire [31:0] n77;
  wire [31:0] n78;
  wire [1023:0] n79;
  wire [31:0] n8;
  wire [31:0] regfile$0$;  // register.v(5)
  wire [31:0] regfile$1$;  // register.v(5)
  wire [31:0] regfile$10$;  // register.v(5)
  wire [31:0] regfile$11$;  // register.v(5)
  wire [31:0] regfile$12$;  // register.v(5)
  wire [31:0] regfile$13$;  // register.v(5)
  wire [31:0] regfile$14$;  // register.v(5)
  wire [31:0] regfile$15$;  // register.v(5)
  wire [31:0] regfile$16$;  // register.v(5)
  wire [31:0] regfile$17$;  // register.v(5)
  wire [31:0] regfile$18$;  // register.v(5)
  wire [31:0] regfile$19$;  // register.v(5)
  wire [31:0] regfile$2$;  // register.v(5)
  wire [31:0] regfile$20$;  // register.v(5)
  wire [31:0] regfile$21$;  // register.v(5)
  wire [31:0] regfile$22$;  // register.v(5)
  wire [31:0] regfile$23$;  // register.v(5)
  wire [31:0] regfile$24$;  // register.v(5)
  wire [31:0] regfile$25$;  // register.v(5)
  wire [31:0] regfile$26$;  // register.v(5)
  wire [31:0] regfile$27$;  // register.v(5)
  wire [31:0] regfile$28$;  // register.v(5)
  wire [31:0] regfile$29$;  // register.v(5)
  wire [31:0] regfile$3$;  // register.v(5)
  wire [31:0] regfile$30$;  // register.v(5)
  wire [31:0] regfile$31$;  // register.v(5)
  wire [31:0] regfile$4$;  // register.v(5)
  wire [31:0] regfile$5$;  // register.v(5)
  wire [31:0] regfile$6$;  // register.v(5)
  wire [31:0] regfile$7$;  // register.v(5)
  wire [31:0] regfile$8$;  // register.v(5)
  wire [31:0] regfile$9$;  // register.v(5)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n34;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n4;
  wire n40;
  wire n45;
  wire n6;
  wire n80;
  wire n9;

  eq_w1 eq0 (
    .i0(i_write_cs),
    .i1(1'b1),
    .o(n0));  // register.v(10)
  eq_w5 eq1 (
    .i0(i_rd),
    .i1(i_rs1),
    .o(n1));  // register.v(10)
  eq_w5 eq2 (
    .i0(i_rd),
    .i1(i_rs2),
    .o(n3));  // register.v(10)
  binary_mux_s5_w32 mux0 (
    .i0(regfile$0$),
    .i1(regfile$1$),
    .i10(regfile$10$),
    .i11(regfile$11$),
    .i12(regfile$12$),
    .i13(regfile$13$),
    .i14(regfile$14$),
    .i15(regfile$15$),
    .i16(regfile$16$),
    .i17(regfile$17$),
    .i18(regfile$18$),
    .i19(regfile$19$),
    .i2(regfile$2$),
    .i20(regfile$20$),
    .i21(regfile$21$),
    .i22(regfile$22$),
    .i23(regfile$23$),
    .i24(regfile$24$),
    .i25(regfile$25$),
    .i26(regfile$26$),
    .i27(regfile$27$),
    .i28(regfile$28$),
    .i29(regfile$29$),
    .i3(regfile$3$),
    .i30(regfile$30$),
    .i31(regfile$31$),
    .i4(regfile$4$),
    .i5(regfile$5$),
    .i6(regfile$6$),
    .i7(regfile$7$),
    .i8(regfile$8$),
    .i9(regfile$9$),
    .sel(i_rs2),
    .o(n5));  // register.v(16)
  binary_mux_s1_w32 mux1 (
    .i0(n5),
    .i1(regdat),
    .sel(n6),
    .o(n41));  // register.v(25)
  binary_mux_s1_w32 mux10 (
    .i0(regfile$28$),
    .i1(regdat),
    .sel(n46[28]),
    .o(n50));  // register.v(63)
  binary_mux_s1_w32 mux11 (
    .i0(regfile$27$),
    .i1(regdat),
    .sel(n46[27]),
    .o(n51));  // register.v(63)
  binary_mux_s1_w32 mux12 (
    .i0(regfile$26$),
    .i1(regdat),
    .sel(n46[26]),
    .o(n52));  // register.v(63)
  binary_mux_s1_w32 mux13 (
    .i0(regfile$25$),
    .i1(regdat),
    .sel(n46[25]),
    .o(n53));  // register.v(63)
  binary_mux_s1_w32 mux14 (
    .i0(regfile$24$),
    .i1(regdat),
    .sel(n46[24]),
    .o(n54));  // register.v(63)
  binary_mux_s1_w32 mux15 (
    .i0(regfile$23$),
    .i1(regdat),
    .sel(n46[23]),
    .o(n55));  // register.v(63)
  binary_mux_s1_w32 mux16 (
    .i0(regfile$22$),
    .i1(regdat),
    .sel(n46[22]),
    .o(n56));  // register.v(63)
  binary_mux_s1_w32 mux17 (
    .i0(regfile$21$),
    .i1(regdat),
    .sel(n46[21]),
    .o(n57));  // register.v(63)
  binary_mux_s1_w32 mux18 (
    .i0(regfile$20$),
    .i1(regdat),
    .sel(n46[20]),
    .o(n58));  // register.v(63)
  binary_mux_s1_w32 mux19 (
    .i0(regfile$19$),
    .i1(regdat),
    .sel(n46[19]),
    .o(n59));  // register.v(63)
  binary_mux_s1_w32 mux2 (
    .i0(n8),
    .i1(n7),
    .sel(n6),
    .o(n42));  // register.v(25)
  binary_mux_s1_w32 mux20 (
    .i0(regfile$18$),
    .i1(regdat),
    .sel(n46[18]),
    .o(n60));  // register.v(63)
  binary_mux_s1_w32 mux21 (
    .i0(regfile$17$),
    .i1(regdat),
    .sel(n46[17]),
    .o(n61));  // register.v(63)
  binary_mux_s1_w32 mux22 (
    .i0(regfile$16$),
    .i1(regdat),
    .sel(n46[16]),
    .o(n62));  // register.v(63)
  binary_mux_s1_w32 mux23 (
    .i0(regfile$15$),
    .i1(regdat),
    .sel(n46[15]),
    .o(n63));  // register.v(63)
  binary_mux_s1_w32 mux24 (
    .i0(regfile$14$),
    .i1(regdat),
    .sel(n46[14]),
    .o(n64));  // register.v(63)
  binary_mux_s1_w32 mux25 (
    .i0(regfile$13$),
    .i1(regdat),
    .sel(n46[13]),
    .o(n65));  // register.v(63)
  binary_mux_s1_w32 mux26 (
    .i0(regfile$12$),
    .i1(regdat),
    .sel(n46[12]),
    .o(n66));  // register.v(63)
  binary_mux_s1_w32 mux27 (
    .i0(regfile$11$),
    .i1(regdat),
    .sel(n46[11]),
    .o(n67));  // register.v(63)
  binary_mux_s1_w32 mux28 (
    .i0(regfile$10$),
    .i1(regdat),
    .sel(n46[10]),
    .o(n68));  // register.v(63)
  binary_mux_s1_w32 mux29 (
    .i0(regfile$9$),
    .i1(regdat),
    .sel(n46[9]),
    .o(n69));  // register.v(63)
  binary_mux_s1_w32 mux3 (
    .i0(n42),
    .i1(regdat),
    .sel(n2),
    .o(n43));  // register.v(25)
  binary_mux_s1_w32 mux30 (
    .i0(regfile$8$),
    .i1(regdat),
    .sel(n46[8]),
    .o(n70));  // register.v(63)
  binary_mux_s1_w32 mux31 (
    .i0(regfile$7$),
    .i1(regdat),
    .sel(n46[7]),
    .o(n71));  // register.v(63)
  binary_mux_s1_w32 mux32 (
    .i0(regfile$6$),
    .i1(regdat),
    .sel(n46[6]),
    .o(n72));  // register.v(63)
  binary_mux_s1_w32 mux33 (
    .i0(regfile$5$),
    .i1(regdat),
    .sel(n46[5]),
    .o(n73));  // register.v(63)
  binary_mux_s1_w32 mux34 (
    .i0(regfile$4$),
    .i1(regdat),
    .sel(n46[4]),
    .o(n74));  // register.v(63)
  binary_mux_s1_w32 mux35 (
    .i0(regfile$3$),
    .i1(regdat),
    .sel(n46[3]),
    .o(n75));  // register.v(63)
  binary_mux_s1_w32 mux36 (
    .i0(regfile$2$),
    .i1(regdat),
    .sel(n46[2]),
    .o(n76));  // register.v(63)
  binary_mux_s1_w32 mux37 (
    .i0(regfile$1$),
    .i1(regdat),
    .sel(n46[1]),
    .o(n77));  // register.v(63)
  binary_mux_s1_w32 mux38 (
    .i0(regfile$0$),
    .i1(regdat),
    .sel(n46[0]),
    .o(n78));  // register.v(63)
  binary_mux_s1_w1024 mux39 (
    .i0({regfile$31$,regfile$30$,regfile$29$,regfile$28$,regfile$27$,regfile$26$,regfile$25$,regfile$24$,regfile$23$,regfile$22$,regfile$21$,regfile$20$,regfile$19$,regfile$18$,regfile$17$,regfile$16$,regfile$15$,regfile$14$,regfile$13$,regfile$12$,regfile$11$,regfile$10$,regfile$9$,regfile$8$,regfile$7$,regfile$6$,regfile$5$,regfile$4$,regfile$3$,regfile$2$,regfile$1$,regfile$0$}),
    .i1({n47,n48,n49,n50,n51,n52,n53,n54,n55,n56,n57,n58,n59,n60,n61,n62,n63,n64,n65,n66,n67,n68,n69,n70,n71,n72,n73,n74,n75,n76,n77,n78}),
    .sel(i_write_cs),
    .o(n79));  // register.v(63)
  binary_mux_s1_w32 mux4 (
    .i0(n41),
    .i1(n5),
    .sel(n2),
    .o(n44));  // register.v(25)
  binary_mux_s5_w64 mux40 (
    .i0({regfile$0$,regfile$0$}),
    .i1({regfile$1$,regfile$1$}),
    .i10({regfile$10$,regfile$10$}),
    .i11({regfile$11$,regfile$11$}),
    .i12({regfile$12$,regfile$12$}),
    .i13({regfile$13$,regfile$13$}),
    .i14({regfile$14$,regfile$14$}),
    .i15({regfile$15$,regfile$15$}),
    .i16({regfile$16$,regfile$16$}),
    .i17({regfile$17$,regfile$17$}),
    .i18({regfile$18$,regfile$18$}),
    .i19({regfile$19$,regfile$19$}),
    .i2({regfile$2$,regfile$2$}),
    .i20({regfile$20$,regfile$20$}),
    .i21({regfile$21$,regfile$21$}),
    .i22({regfile$22$,regfile$22$}),
    .i23({regfile$23$,regfile$23$}),
    .i24({regfile$24$,regfile$24$}),
    .i25({regfile$25$,regfile$25$}),
    .i26({regfile$26$,regfile$26$}),
    .i27({regfile$27$,regfile$27$}),
    .i28({regfile$28$,regfile$28$}),
    .i29({regfile$29$,regfile$29$}),
    .i3({regfile$3$,regfile$3$}),
    .i30({regfile$30$,regfile$30$}),
    .i31({regfile$31$,regfile$31$}),
    .i4({regfile$4$,regfile$4$}),
    .i5({regfile$5$,regfile$5$}),
    .i6({regfile$6$,regfile$6$}),
    .i7({regfile$7$,regfile$7$}),
    .i8({regfile$8$,regfile$8$}),
    .i9({regfile$9$,regfile$9$}),
    .sel(i_rs1),
    .o({n8,n7}));  // register.v(23)
  binary_mux_s1_w32 mux5 (
    .i0(n43),
    .i1(regdat),
    .sel(n4),
    .o(o_read_dat1));  // register.v(25)
  binary_mux_s1_w32 mux6 (
    .i0(n44),
    .i1(regdat),
    .sel(n4),
    .o(o_read_dat2));  // register.v(25)
  binary_mux_s1_w32 mux7 (
    .i0(regfile$31$),
    .i1(regdat),
    .sel(n46[31]),
    .o(n47));  // register.v(63)
  binary_mux_s1_w32 mux8 (
    .i0(regfile$30$),
    .i1(regdat),
    .sel(n46[30]),
    .o(n48));  // register.v(63)
  binary_mux_s1_w32 mux9 (
    .i0(regfile$29$),
    .i1(regdat),
    .sel(n46[29]),
    .o(n49));  // register.v(63)
  reg_ar_as_w1024 reg0 (
    .clk(i_clock),
    .d(n79),
    .reset({n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,3'b000,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,3'b000,n45,3'b000,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,3'b000,n45,1'b0,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,2'b00,n45,n45,2'b00,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,2'b00,n45,n45,1'b0,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,1'b0,n45,2'b00,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,1'b0,n45,3'b000,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,1'b0,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,1'b0,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,2'b00,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,n45,2'b00,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,2'b00,n45,n45,2'b00,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,2'b00,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,2'b00,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,2'b00,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,1'b0,n45,1'b0,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,1'b0,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,1'b0,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,1'b0,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45,n45}),
    .set({26'b00000000000000000000000000,n45,2'b00,n45,n45,n45,25'b0000000000000000000000000,n45,n45,n45,1'b0,n45,n45,n45,25'b0000000000000000000000000,n45,n45,n45,1'b0,n45,1'b0,n45,27'b000000000000000000000000000,n45,2'b00,n45,26'b00000000000000000000000000,n45,n45,2'b00,n45,n45,26'b00000000000000000000000000,n45,n45,2'b00,n45,1'b0,n45,25'b0000000000000000000000000,n45,1'b0,n45,1'b0,n45,n45,26'b00000000000000000000000000,n45,1'b0,n45,1'b0,n45,n45,n45,25'b0000000000000000000000000,n45,3'b000,n45,1'b0,n45,25'b0000000000000000000000000,n45,1'b0,n45,1'b0,n45,27'b000000000000000000000000000,n45,3'b000,n45,28'b0000000000000000000000000000,n45,n45,1'b0,n45,27'b000000000000000000000000000,n45,4'b0000,n45,n45,26'b00000000000000000000000000,n45,n45,2'b00,n45,n45,26'b00000000000000000000000000,n45,n45,34'b0000000000000000000000000000000000,n45,n45,27'b000000000000000000000000000,n45,2'b00,n45,n45,27'b000000000000000000000000000,n45,30'b000000000000000000000000000000,n45,30'b000000000000000000000000000000,n45,1'b0,n45,33'b000000000000000000000000000000000,n45,1'b0,n45,30'b000000000000000000000000000000,n45,32'b00000000000000000000000000000000,n45,25'b0000000000000000000000000,n45,1'b0,n45,1'b0,n45,1'b0,n45,26'b00000000000000000000000000,n45,3'b000,n45,28'b0000000000000000000000000000,n45,3'b000,n45,26'b00000000000000000000000000,n45,2'b00,n45,1'b0,n45,27'b000000000000000000000000000,n45,1'b0,n45,1'b0,n45,26'b00000000000000000000000000,n45,36'b000000000000000000000000000000000000,n45,30'b000000000000000000000000000000,n45,33'b000000000000000000000000000000000}),
    .q({regfile$31$,regfile$30$,regfile$29$,regfile$28$,regfile$27$,regfile$26$,regfile$25$,regfile$24$,regfile$23$,regfile$22$,regfile$21$,regfile$20$,regfile$19$,regfile$18$,regfile$17$,regfile$16$,regfile$15$,regfile$14$,regfile$13$,regfile$12$,regfile$11$,regfile$10$,regfile$9$,regfile$8$,regfile$7$,regfile$6$,regfile$5$,regfile$4$,regfile$3$,regfile$2$,regfile$1$,regfile$0$}));  // register.v(63)
  not u10 (n40, i_rd[2]);  // register.v(63)
  and u11 (n6, n0, n3);  // register.v(18)
  and u12 (n30, n33, i_rd[2]);  // register.v(63)
  and u13 (n31, n35, n40);  // register.v(63)
  not u14 (n80, i_rd[1]);  // register.v(63)
  and u15 (n34, i_rd[0], i_rd[1]);  // register.v(63)
  not u16 (n45, i_rst);  // register.v(28)
  not u17 (n37, i_rd[0]);  // register.v(63)
  and u18 (n29, n33, n40);  // register.v(63)
  and u19 (n28, n36, i_rd[2]);  // register.v(63)
  and u2 (n32, n35, i_rd[2]);  // register.v(63)
  and u20 (n27, n36, n40);  // register.v(63)
  and u21 (n26, n34, i_rd[2]);  // register.v(63)
  and u22 (n25, n34, n40);  // register.v(63)
  and u23 (n24, n31, i_rd[3]);  // register.v(63)
  and u24 (n23, n31, n39);  // register.v(63)
  and u25 (n22, n29, i_rd[3]);  // register.v(63)
  and u26 (n21, n29, n39);  // register.v(63)
  and u27 (n20, n27, i_rd[3]);  // register.v(63)
  and u28 (n19, n27, n39);  // register.v(63)
  and u29 (n18, n25, i_rd[3]);  // register.v(63)
  and u3 (n33, i_rd[0], n80);  // register.v(63)
  and u30 (n17, n25, n39);  // register.v(63)
  and u31 (n16, n32, i_rd[3]);  // register.v(63)
  and u32 (n15, n32, n39);  // register.v(63)
  and u33 (n14, n30, i_rd[3]);  // register.v(63)
  and u34 (n13, n30, n39);  // register.v(63)
  and u35 (n12, n28, i_rd[3]);  // register.v(63)
  and u36 (n11, n28, n39);  // register.v(63)
  and u37 (n10, n26, i_rd[3]);  // register.v(63)
  and u38 (n9, n26, n39);  // register.v(63)
  and u39 (n46[16], n23, i_rd[4]);  // register.v(63)
  and u4 (n2, n0, n1);  // register.v(10)
  and u40 (n46[0], n23, n38);  // register.v(63)
  and u41 (n46[17], n21, i_rd[4]);  // register.v(63)
  and u42 (n46[1], n21, n38);  // register.v(63)
  and u43 (n46[18], n19, i_rd[4]);  // register.v(63)
  and u44 (n46[2], n19, n38);  // register.v(63)
  and u45 (n46[19], n17, i_rd[4]);  // register.v(63)
  and u46 (n46[3], n17, n38);  // register.v(63)
  and u47 (n46[20], n15, i_rd[4]);  // register.v(63)
  and u48 (n46[4], n15, n38);  // register.v(63)
  and u49 (n46[21], n13, i_rd[4]);  // register.v(63)
  and u5 (n4, n2, n3);  // register.v(10)
  and u50 (n46[5], n13, n38);  // register.v(63)
  and u51 (n46[22], n11, i_rd[4]);  // register.v(63)
  and u52 (n46[6], n11, n38);  // register.v(63)
  and u53 (n46[23], n9, i_rd[4]);  // register.v(63)
  and u54 (n46[7], n9, n38);  // register.v(63)
  and u55 (n46[24], n24, i_rd[4]);  // register.v(63)
  and u56 (n46[8], n24, n38);  // register.v(63)
  and u57 (n46[25], n22, i_rd[4]);  // register.v(63)
  and u58 (n46[9], n22, n38);  // register.v(63)
  and u59 (n46[26], n20, i_rd[4]);  // register.v(63)
  and u6 (n35, n37, n80);  // register.v(63)
  and u60 (n46[10], n20, n38);  // register.v(63)
  and u61 (n46[27], n18, i_rd[4]);  // register.v(63)
  and u62 (n46[11], n18, n38);  // register.v(63)
  and u63 (n46[28], n16, i_rd[4]);  // register.v(63)
  and u64 (n46[12], n16, n38);  // register.v(63)
  and u65 (n46[29], n14, i_rd[4]);  // register.v(63)
  and u66 (n46[13], n14, n38);  // register.v(63)
  and u67 (n46[30], n12, i_rd[4]);  // register.v(63)
  and u68 (n46[14], n12, n38);  // register.v(63)
  and u69 (n46[31], n10, i_rd[4]);  // register.v(63)
  and u7 (n36, n37, i_rd[1]);  // register.v(63)
  and u70 (n46[15], n10, n38);  // register.v(63)
  not u8 (n38, i_rd[4]);  // register.v(63)
  not u9 (n39, i_rd[3]);  // register.v(63)

endmodule 

module jump_input  // PC.v(115)
  (
  i_EX_aludat,
  i_EX_op,
  i_EX_rd,
  i_ID_reg_readdat1,
  i_ID_reg_readdat2,
  i_MEM_aludat,
  i_MEM_op,
  i_MEM_rd,
  i_WB_op,
  i_WB_rd,
  i_op,
  i_reg_writedat,
  i_rs1,
  i_rs2,
  o_jump_risk_block,
  o_regdat1,
  o_regdat2
  );

  input [31:0] i_EX_aludat;  // PC.v(125)
  input [6:0] i_EX_op;  // PC.v(120)
  input [4:0] i_EX_rd;  // PC.v(119)
  input [31:0] i_ID_reg_readdat1;  // PC.v(128)
  input [31:0] i_ID_reg_readdat2;  // PC.v(129)
  input [31:0] i_MEM_aludat;  // PC.v(126)
  input [6:0] i_MEM_op;  // PC.v(122)
  input [4:0] i_MEM_rd;  // PC.v(121)
  input [6:0] i_WB_op;  // PC.v(123)
  input [4:0] i_WB_rd;  // PC.v(124)
  input [6:0] i_op;  // PC.v(118)
  input [31:0] i_reg_writedat;  // PC.v(127)
  input [4:0] i_rs1;  // PC.v(116)
  input [4:0] i_rs2;  // PC.v(117)
  output o_jump_risk_block;  // PC.v(132)
  output [31:0] o_regdat1;  // PC.v(130)
  output [31:0] o_regdat2;  // PC.v(131)

  wire [1:0] n34;
  wire [1:0] n49;
  wire [1:0] rs1_select;  // PC.v(134)
  wire [1:0] rs2_select;  // PC.v(135)
  wire EX_risk;  // PC.v(137)
  wire MEM_risk;  // PC.v(138)
  wire WB_risk;  // PC.v(139)
  wire n0;
  wire n1;
  wire n10;
  wire n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire n16;
  wire n17;
  wire n18;
  wire n19;
  wire n2;
  wire n20;
  wire n21;
  wire n22;
  wire n23;
  wire n24;
  wire n25;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire n3;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire n35;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n4;
  wire n40;
  wire n41;
  wire n42;
  wire n43;
  wire n44;
  wire n45;
  wire n46;
  wire n47;
  wire n48;
  wire n5;
  wire n50;
  wire n51;
  wire n52;
  wire n53;
  wire n54;
  wire n55;
  wire n56;
  wire n57;
  wire n58;
  wire n6;
  wire n7;
  wire n8;
  wire n9;

  eq_w7 eq0 (
    .i0(i_op),
    .i1(7'b1100011),
    .o(n0));  // PC.v(142)
  eq_w1 eq1 (
    .i0(EX_risk),
    .i1(1'b1),
    .o(n10));  // PC.v(176)
  eq_w7 eq10 (
    .i0(i_EX_op),
    .i1(7'b0000011),
    .o(n50));  // PC.v(230)
  eq_w7 eq11 (
    .i0(i_MEM_op),
    .i1(7'b0000011),
    .o(n55));  // PC.v(236)
  eq_w5 eq2 (
    .i0(i_EX_rd),
    .i1(i_rs1),
    .o(n11));  // PC.v(177)
  eq_w1 eq3 (
    .i0(MEM_risk),
    .i1(1'b1),
    .o(n17));  // PC.v(181)
  eq_w5 eq4 (
    .i0(i_MEM_rd),
    .i1(i_rs1),
    .o(n24));  // PC.v(185)
  eq_w1 eq5 (
    .i0(WB_risk),
    .i1(1'b1),
    .o(n26));  // PC.v(187)
  eq_w5 eq6 (
    .i0(i_WB_rd),
    .i1(i_rs1),
    .o(n32));  // PC.v(192)
  eq_w5 eq7 (
    .i0(i_EX_rd),
    .i1(i_rs2),
    .o(n35));  // PC.v(208)
  eq_w5 eq8 (
    .i0(i_MEM_rd),
    .i1(i_rs2),
    .o(n42));  // PC.v(216)
  eq_w5 eq9 (
    .i0(i_WB_rd),
    .i1(i_rs2),
    .o(n47));  // PC.v(223)
  binary_mux_s2_w32 mux0 (
    .i0(i_ID_reg_readdat1),
    .i1(i_EX_aludat),
    .i2(i_MEM_aludat),
    .i3(i_reg_writedat),
    .sel(rs1_select),
    .o(o_regdat1));  // PC.v(172)
  binary_mux_s1_w2 mux1 (
    .i0({n33,n33}),
    .i1(2'b10),
    .sel(n25),
    .o(n34));  // PC.v(194)
  binary_mux_s1_w2 mux2 (
    .i0(n34),
    .i1(2'b01),
    .sel(n16),
    .o(rs1_select));  // PC.v(194)
  binary_mux_s2_w32 mux3 (
    .i0(i_ID_reg_readdat2),
    .i1(i_EX_aludat),
    .i2(i_MEM_aludat),
    .i3(i_reg_writedat),
    .sel(rs2_select),
    .o(o_regdat2));  // PC.v(203)
  binary_mux_s1_w2 mux4 (
    .i0({n48,n48}),
    .i1(2'b10),
    .sel(n43),
    .o(n49));  // PC.v(225)
  binary_mux_s1_w2 mux5 (
    .i0(n49),
    .i1(2'b01),
    .sel(n38),
    .o(rs2_select));  // PC.v(225)
  ne_w7 neq0 (
    .i0(i_EX_op),
    .i1(7'b0100011),
    .o(n1));  // PC.v(143)
  ne_w7 neq1 (
    .i0(i_EX_op),
    .i1(7'b1100011),
    .o(n3));  // PC.v(144)
  ne_w7 neq10 (
    .i0(i_MEM_op),
    .i1(7'b0000011),
    .o(n22));  // PC.v(184)
  ne_w32 neq11 (
    .i0({27'b000000000000000000000000000,i_WB_rd}),
    .i1(32'b00000000000000000000000000000000),
    .o(n27));  // PC.v(188)
  ne_w5 neq12 (
    .i0(i_MEM_rd),
    .i1(i_rs1),
    .o(n30));  // PC.v(190)
  ne_w5 neq13 (
    .i0(i_EX_rd),
    .i1(i_rs2),
    .o(n39));  // PC.v(214)
  ne_w5 neq14 (
    .i0(i_MEM_rd),
    .i1(i_rs2),
    .o(n45));  // PC.v(221)
  ne_w7 neq2 (
    .i0(i_MEM_op),
    .i1(7'b0100011),
    .o(n4));  // PC.v(151)
  ne_w7 neq3 (
    .i0(i_MEM_op),
    .i1(7'b1100011),
    .o(n6));  // PC.v(152)
  ne_w7 neq4 (
    .i0(i_WB_op),
    .i1(7'b0100011),
    .o(n7));  // PC.v(159)
  ne_w7 neq5 (
    .i0(i_WB_op),
    .i1(7'b1100011),
    .o(n9));  // PC.v(160)
  ne_w32 neq6 (
    .i0({27'b000000000000000000000000000,i_EX_rd}),
    .i1(32'b00000000000000000000000000000000),
    .o(n13));  // PC.v(178)
  ne_w7 neq7 (
    .i0(i_EX_op),
    .i1(7'b0000011),
    .o(n15));  // PC.v(179)
  ne_w32 neq8 (
    .i0({27'b000000000000000000000000000,i_MEM_rd}),
    .i1(32'b00000000000000000000000000000000),
    .o(n18));  // PC.v(182)
  ne_w5 neq9 (
    .i0(i_EX_rd),
    .i1(i_rs1),
    .o(n20));  // PC.v(183)
  and u10 (n16, n14, n15);  // PC.v(179)
  and u11 (n19, n17, n18);  // PC.v(182)
  and u12 (n21, n19, n20);  // PC.v(183)
  and u13 (n23, n21, n22);  // PC.v(184)
  and u14 (n25, n23, n24);  // PC.v(185)
  and u15 (n28, n26, n27);  // PC.v(188)
  and u16 (n29, n28, n20);  // PC.v(189)
  and u17 (n31, n29, n30);  // PC.v(190)
  and u18 (n33, n31, n32);  // PC.v(192)
  and u19 (n36, n10, n35);  // PC.v(208)
  and u2 (n2, n0, n1);  // PC.v(143)
  and u20 (n37, n36, n13);  // PC.v(209)
  and u21 (n38, n37, n15);  // PC.v(210)
  and u22 (n40, n19, n39);  // PC.v(214)
  and u23 (n41, n40, n22);  // PC.v(215)
  and u24 (n43, n41, n42);  // PC.v(216)
  and u25 (n44, n28, n39);  // PC.v(220)
  and u26 (n46, n44, n45);  // PC.v(221)
  and u27 (n48, n46, n47);  // PC.v(223)
  and u28 (n51, n0, n50);  // PC.v(230)
  or u29 (n52, n11, n35);  // PC.v(232)
  and u3 (EX_risk, n2, n3);  // PC.v(144)
  and u30 (n53, n51, n52);  // PC.v(232)
  and u31 (n54, n0, n15);  // PC.v(235)
  and u32 (n56, n54, n55);  // PC.v(236)
  or u33 (n57, n24, n42);  // PC.v(238)
  and u34 (n58, n56, n57);  // PC.v(238)
  AL_MUX u35 (
    .i0(n58),
    .i1(1'b1),
    .sel(n53),
    .o(o_jump_risk_block));  // PC.v(240)
  and u4 (n5, n0, n4);  // PC.v(151)
  and u5 (MEM_risk, n5, n6);  // PC.v(152)
  and u6 (n8, n0, n7);  // PC.v(159)
  and u7 (WB_risk, n8, n9);  // PC.v(160)
  and u8 (n12, n10, n11);  // PC.v(177)
  and u9 (n14, n12, n13);  // PC.v(178)

endmodule 

module onehot_mux_s4_w32
  (
  i0,
  i1,
  i2,
  i3,
  sel,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  input [31:0] i2;
  input [31:0] i3;
  input [3:0] sel;
  output [31:0] o;



endmodule 

module skip  // PC.v(90)
  (
  i_i_instr,
  i_op,
  o_skip_addr,
  o_skip_cs
  );

  input [31:0] i_i_instr;  // PC.v(91)
  input [6:0] i_op;  // PC.v(92)
  output [31:0] o_skip_addr;  // PC.v(98)
  output o_skip_cs;  // PC.v(97)

  wire [31:0] n2;
  wire n0;
  wire n1;

  eq_w7 eq0 (
    .i0(i_op),
    .i1(7'b1101111),
    .o(n0));  // PC.v(100)
  eq_w7 eq1 (
    .i0(i_op),
    .i1(7'b0010111),
    .o(n1));  // PC.v(104)
  binary_mux_s1_w32 mux0 (
    .i0(32'b00000000000000000000000000000000),
    .i1({i_i_instr[31:12],12'b000000000000}),
    .sel(n1),
    .o(n2));  // PC.v(111)
  binary_mux_s1_w32 mux1 (
    .i0(n2),
    .i1({i_i_instr[31],i_i_instr[31],i_i_instr[31],i_i_instr[31],i_i_instr[31],i_i_instr[31],i_i_instr[31],i_i_instr[31],i_i_instr[31],i_i_instr[31],i_i_instr[31],i_i_instr[31],i_i_instr[19:12],i_i_instr[20],i_i_instr[30:21],1'b0}),
    .sel(n0),
    .o(o_skip_addr));  // PC.v(111)
  AL_MUX u2 (
    .i0(n1),
    .i1(1'b1),
    .sel(n0),
    .o(o_skip_cs));  // PC.v(111)

endmodule 

module reg_ar_as_w32
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [31:0] d;
  input en;
  input [31:0] reset;
  input [31:0] set;
  output [31:0] q;



endmodule 

module add_pu32_pu32_o32
  (
  i0,
  i1,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  output [31:0] o;



endmodule 

module binary_mux_s4_w32
  (
  i0,
  i1,
  i10,
  i11,
  i12,
  i13,
  i14,
  i15,
  i2,
  i3,
  i4,
  i5,
  i6,
  i7,
  i8,
  i9,
  sel,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  input [31:0] i10;
  input [31:0] i11;
  input [31:0] i12;
  input [31:0] i13;
  input [31:0] i14;
  input [31:0] i15;
  input [31:0] i2;
  input [31:0] i3;
  input [31:0] i4;
  input [31:0] i5;
  input [31:0] i6;
  input [31:0] i7;
  input [31:0] i8;
  input [31:0] i9;
  input [3:0] sel;
  output [31:0] o;



endmodule 

module add_pu32_mu32_o32
  (
  i0,
  i1,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  output [31:0] o;



endmodule 

module binary_mux_s2_w32
  (
  i0,
  i1,
  i2,
  i3,
  sel,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  input [31:0] i2;
  input [31:0] i3;
  input [1:0] sel;
  output [31:0] o;



endmodule 

module binary_mux_s1_w7
  (
  i0,
  i1,
  sel,
  o
  );

  input [6:0] i0;
  input [6:0] i1;
  input sel;
  output [6:0] o;



endmodule 

module onehot_mux_s5_w32
  (
  i0,
  i1,
  i2,
  i3,
  i4,
  sel,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  input [31:0] i2;
  input [31:0] i3;
  input [31:0] i4;
  input [4:0] sel;
  output [31:0] o;



endmodule 

module onehot_mux_s10_w32
  (
  i0,
  i1,
  i2,
  i3,
  i4,
  i5,
  i6,
  i7,
  i8,
  i9,
  sel,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  input [31:0] i2;
  input [31:0] i3;
  input [31:0] i4;
  input [31:0] i5;
  input [31:0] i6;
  input [31:0] i7;
  input [31:0] i8;
  input [31:0] i9;
  input [9:0] sel;
  output [31:0] o;



endmodule 

module onehot_mux_s9_w4
  (
  i0,
  i1,
  i2,
  i3,
  i4,
  i5,
  i6,
  i7,
  i8,
  sel,
  o
  );

  input [3:0] i0;
  input [3:0] i1;
  input [3:0] i2;
  input [3:0] i3;
  input [3:0] i4;
  input [3:0] i5;
  input [3:0] i6;
  input [3:0] i7;
  input [3:0] i8;
  input [8:0] sel;
  output [3:0] o;



endmodule 

module lt_u31_u31
  (
  ci,
  i0,
  i1,
  o
  );

  input ci;
  input [30:0] i0;
  input [30:0] i1;
  output o;



endmodule 

module binary_mux_s3_w1
  (
  i0,
  i1,
  i2,
  i3,
  i4,
  i5,
  i6,
  i7,
  sel,
  o
  );

  input i0;
  input i1;
  input i2;
  input i3;
  input i4;
  input i5;
  input i6;
  input i7;
  input [2:0] sel;
  output o;



endmodule 

module onehot_mux_s3_w32
  (
  i0,
  i1,
  i2,
  sel,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  input [31:0] i2;
  input [2:0] sel;
  output [31:0] o;



endmodule 

module onehot_mux_s3_w1
  (
  i0,
  i1,
  i2,
  sel,
  o
  );

  input i0;
  input i1;
  input i2;
  input [2:0] sel;
  output o;



endmodule 

module reg_ar_as_w5
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [4:0] d;
  input en;
  input [4:0] reset;
  input [4:0] set;
  output [4:0] q;



endmodule 

module reg_ar_as_w7
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [6:0] d;
  input en;
  input [6:0] reset;
  input [6:0] set;
  output [6:0] q;



endmodule 

module reg_ar_as_w3
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [2:0] d;
  input en;
  input [2:0] reset;
  input [2:0] set;
  output [2:0] q;



endmodule 

module binary_mux_s1_w3
  (
  i0,
  i1,
  sel,
  o
  );

  input [2:0] i0;
  input [2:0] i1;
  input sel;
  output [2:0] o;



endmodule 

module binary_mux_s1_w5
  (
  i0,
  i1,
  sel,
  o
  );

  input [4:0] i0;
  input [4:0] i1;
  input sel;
  output [4:0] o;



endmodule 

module add_pu30_pu30_o30
  (
  i0,
  i1,
  o
  );

  input [29:0] i0;
  input [29:0] i1;
  output [29:0] o;



endmodule 

module binary_mux_s5_w32
  (
  i0,
  i1,
  i10,
  i11,
  i12,
  i13,
  i14,
  i15,
  i16,
  i17,
  i18,
  i19,
  i2,
  i20,
  i21,
  i22,
  i23,
  i24,
  i25,
  i26,
  i27,
  i28,
  i29,
  i3,
  i30,
  i31,
  i4,
  i5,
  i6,
  i7,
  i8,
  i9,
  sel,
  o
  );

  input [31:0] i0;
  input [31:0] i1;
  input [31:0] i10;
  input [31:0] i11;
  input [31:0] i12;
  input [31:0] i13;
  input [31:0] i14;
  input [31:0] i15;
  input [31:0] i16;
  input [31:0] i17;
  input [31:0] i18;
  input [31:0] i19;
  input [31:0] i2;
  input [31:0] i20;
  input [31:0] i21;
  input [31:0] i22;
  input [31:0] i23;
  input [31:0] i24;
  input [31:0] i25;
  input [31:0] i26;
  input [31:0] i27;
  input [31:0] i28;
  input [31:0] i29;
  input [31:0] i3;
  input [31:0] i30;
  input [31:0] i31;
  input [31:0] i4;
  input [31:0] i5;
  input [31:0] i6;
  input [31:0] i7;
  input [31:0] i8;
  input [31:0] i9;
  input [4:0] sel;
  output [31:0] o;



endmodule 

module binary_mux_s1_w1024
  (
  i0,
  i1,
  sel,
  o
  );

  input [1023:0] i0;
  input [1023:0] i1;
  input sel;
  output [1023:0] o;



endmodule 

module binary_mux_s5_w64
  (
  i0,
  i1,
  i10,
  i11,
  i12,
  i13,
  i14,
  i15,
  i16,
  i17,
  i18,
  i19,
  i2,
  i20,
  i21,
  i22,
  i23,
  i24,
  i25,
  i26,
  i27,
  i28,
  i29,
  i3,
  i30,
  i31,
  i4,
  i5,
  i6,
  i7,
  i8,
  i9,
  sel,
  o
  );

  input [63:0] i0;
  input [63:0] i1;
  input [63:0] i10;
  input [63:0] i11;
  input [63:0] i12;
  input [63:0] i13;
  input [63:0] i14;
  input [63:0] i15;
  input [63:0] i16;
  input [63:0] i17;
  input [63:0] i18;
  input [63:0] i19;
  input [63:0] i2;
  input [63:0] i20;
  input [63:0] i21;
  input [63:0] i22;
  input [63:0] i23;
  input [63:0] i24;
  input [63:0] i25;
  input [63:0] i26;
  input [63:0] i27;
  input [63:0] i28;
  input [63:0] i29;
  input [63:0] i3;
  input [63:0] i30;
  input [63:0] i31;
  input [63:0] i4;
  input [63:0] i5;
  input [63:0] i6;
  input [63:0] i7;
  input [63:0] i8;
  input [63:0] i9;
  input [4:0] sel;
  output [63:0] o;



endmodule 

module reg_ar_as_w1024
  (
  clk,
  d,
  en,
  reset,
  set,
  q
  );

  input clk;
  input [1023:0] d;
  input en;
  input [1023:0] reset;
  input [1023:0] set;
  output [1023:0] q;



endmodule 

module AL_DFF
  (
  input reset,
  input set,
  input clk,
  input d,
  output reg q
  );

  parameter INI = 1'b0;

  always @(posedge reset or posedge set or posedge clk)
  begin
    if (reset)
      q <= 1'b0;
    else if (set)
      q <= 1'b1;
    else
      q <= d;
  end

endmodule

module AL_MUX
  (
  input i0,
  input i1,
  input sel,
  output o
  );

  wire not_sel, sel_i0, sel_i1;
  not u0 (not_sel, sel);
  and u1 (sel_i1, sel, i1);
  and u2 (sel_i0, not_sel, i0);
  or u3 (o, sel_i1, sel_i0);

endmodule

