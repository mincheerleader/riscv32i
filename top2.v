module top2(i_iodat,o_iodat,o_ioaddr,clock,rst,memread,memwrite_cs );
	
	input clock,rst;
	input[31:0] i_iodat;
	output[31:0] o_iodat;
	//wire[31:0] i_iodat;
	output	memread;
	output	memwrite_cs;
	output[31:0] o_ioaddr;
	wire	memread_cs;
	wire	memwrite_cs;
	wire	instrnop;
	wire	bus_block;
	wire	instr_read;
	wire[31:0] memaddress;
	wire[31:0] memreaddat;
	wire[31:0] memstraddress;
	wire[31:0] writedat;
	wire[31:0] instruction;
	
	assign	memread=(instr_read|memread_cs);
	io busarbitration(
					.clock(clock),
					.rst(rst),
					.i_iodat(i_iodat[31:0]),
					.i_instrnop(instrnop),
					.i_memread_cs(memread_cs),
					.i_memwrite_cs(memwrite_cs),
					.i_memstraddress(memstraddress[31:0]),
					.i_memaddress(memaddress[31:0]),
					.i_writedat(writedat[31:0]),
					.o_iodat(o_iodat[31:0]),
					.o_instr_read(instr_read),
					.o_bus_block(bus_block),
					.o_memreaddat(memreaddat[31:0]),				
					.o_instruction(instruction[31:0]),
					.o_ioaddr(o_ioaddr[31:0]));
	cpu	a(
		.clock(clock),
		.rst(rst),
		.i_instr(instruction[31:0]),
		.i_bus_block(bus_block),
		.o_memstraddr(memstraddress[31:0]),
		.o_memaddr(memaddress[31:0]),
		.o_memread_cs(memread_cs),
		.o_memwrite_cs(memwrite_cs),
		.i_memreaddat(memreaddat[31:0]),
		.o_memwritedat(writedat[31:0]),
		.o_instrnop(instrnop));
		

endmodule
