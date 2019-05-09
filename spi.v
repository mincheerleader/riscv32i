`include"def.v"
module spi(rst,
		   clock,
		   o_cs,
		   o_DI,
		   i_DO,
		   o_clk,
		   i_memread_cs,
		   i_memwrite_cs,
		   i_address,
		   i_memdat,
		   o_memdat );

	input rst;
	input clock;
	input i_DO;
	input i_memread_cs;
	input i_memwrite_cs;
	input[23:0] i_address;
	input[7:0] i_memdat;
	output[31:0] o_memdat;
	output o_clk;	
	output o_cs;
	output reg o_DI;	
	
	wire clk_80m;
	wire extlock;
	reg cs_n=0;
	reg DI;
//	input[39:0] i_writereg;	//8bit write instruction 24bit address 8bit data 
	reg[47:0] writereg;
	reg[7:0] readreg;
	//reg[2:0] len;
	reg write_flag;
	
	reg[2:0] clock_flag;
	reg[5:0] clock_flag_n;
	reg[7:0] clk_80mtim;
	reg  flag1;
/*always@(*)begin
		if(i_memwrite_cs==1)
			writereg[47:0]<={`spi_write_en,i_address[23:0],i_memdat[0],i_memdat[1],i_memdat[2],i_memdat[3],i_memdat[4],i_memdat[5],i_memdat[6],i_memdat[7],`spi_write_disen};
		else if(i_memread_cs==1)
			writereg[31:0]<={`spi_read_en,i_address[23:0]};
	end	*/
	spi_clk clk80m(
					.refclk(clock),
					.reset(!rst),
					.stdby(1'h0),
					.extlock(extlock),
					.clk0_out(clk_80m));
					
	always@(posedge clock or negedge rst)begin
		if(!rst) clock_flag<=3'h0;
		else clock_flag[2:0]=clock_flag[2:0]+1;
	end
	
	always@(posedge clk_80m or negedge rst )begin
		if(!rst)begin
			 clock_flag_n<=6'h0;
			 flag1<=0;
		end
		else if(flag1==0)begin
			 clock_flag_n[2:0]<=clock_flag[2:0];
			 flag1<=1;
		end
		else if(flag1==1)begin
			 clock_flag_n[5:3]<=clock_flag[2:0];
			 flag1<=0;
		end
	end
	
	always@(posedge clk_80m)begin
		if((!rst)
			&&(clock_flag_n[5:3]!=clock_flag_n[2:0]))//clock is 25M 这样表示新一个25M时钟周期开始，具体仍需要仿真
			 clk_80mtim<=8'h0;
		else clk_80mtim=clk_80mtim+1;
	end
	always@(*)
		if(i_memwrite_cs==1)
			writereg[47:0]<={`spi_write_en,i_address[23:0],i_memdat[0],i_memdat[1],i_memdat[2],i_memdat[3],i_memdat[4],i_memdat[5],i_memdat[6],i_memdat[7],`spi_write_disen};
		else if(i_memread_cs==1)
			writereg[31:0]<={`spi_read_en,i_address[23:0]};
		else if(clk_80m) begin 
			if(i_memwrite_cs==1)
				{o_DI,writereg[47:0]}<={writereg[47:0],1'h0};
			else if(i_memread_cs==1)
				{o_DI,writereg[31:0]}<={writereg[31:0],1'h0};
		readreg <= { i_DO,readreg[7:1]}; 
	end

endmodule
