`timescale 10ns/10ns

module __top(input rst,
			 input clock,
			 output led);
	
	/*output led;
	input rst;
	input clock;*/
	//reg rst=0;
	//reg	clock=0;
	//wire	clock1;
	wire	memread;
	wire	memwrite_cs;
	wire[31:0] i_data;
	wire[31:0] o_data;
	wire[31:0] addr;
	wire[31:0] writedat;
//	wire[31:0] data;
	wire	   cs;
//	wire	clock;
	wire	exlock;
	reg		led_n;
	/*
	initial	begin
		rst=0;
		#1	rst=1;
	end
	always #1	clock=!clock;
	*/

 	/*	spi_clk spi (
  						.refclk(clock),
  						.reset(!rst),
 					 	.stdby(1'h0),
  						.clk0_out(clock1),
 						.extlock(exlock));*/
	

		top2 t(
				.i_iodat(i_data[31:0]),
				.o_iodat(o_data[31:0]),
				.o_ioaddr(addr[31:0]),
				.clock(clock),
				.rst(rst),
				.memread(memread),
				.memwrite_cs(memwrite_cs) );
			
	ramm m( 
		.di(o_data[31:0]), 
		.waddr((memwrite_cs&&(addr[31:0]<32'h60))?addr[5:2]:4'h0), 
		.we(memwrite_cs), 
		.wclk(clock), 
		.do(i_data[31:0]), 
		.raddr((memread)?addr[5:2]:4'h0) );
		
		always@(posedge clock or negedge rst)begin
			if(!rst)
				led_n<=1'h0;
			else if((memwrite_cs==1)
				&&(addr[31:0]==32'h00000402))begin
				led_n<=o_data[0];
			end
		end	
		assign led=led_n;
/*	mem b(
		.clock(clock),
		.rst(rst),
		.i_read_cs(memread),
		.i_write_cs(memwrite_cs),
		.i_address(addr[31:0]),
		.i_memdat(o_data[31:0]),
		.o_memdat(i_data[31:0]),
		.o_led(led));*/
/*	spi mem(
			.clock(clock1),
			.rst(rst),
			.o_cs(cs),
			.o_DI(DI),
			.i_DO(DO),
			.o_clk(clk),
			.i_memread_cs(memread),
		   	.i_memwrite_cs(memwrite_cs),
		    .i_address(addr[23:0]),
		   	.i_memdat(o_data[7:0]),
		    .o_memdat(i_data[31:0]));*/
	
endmodule


