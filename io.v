module io(clock,
		  rst,
		  i_iodat,
		  i_memaddress,
		  i_memread_cs,
		  i_memwrite_cs,
		  i_memstraddress,
		  i_instrnop,
		  i_writedat,
		  o_bus_block,
		  o_instr_read,
		  o_instruction,
		  o_memreaddat,
		  o_ioaddr,
		  o_iodat );
	
	input clock;
	input rst;
	input[31:0]		i_iodat;
	input[31:0]		i_memaddress;
	input			i_memread_cs;
	input			i_memwrite_cs;
	input[31:0]		i_memstraddress;
	input			i_instrnop;
	input[31:0]		i_writedat;
	output reg[31:0]	o_iodat;
	output reg		o_bus_block;
	output 			o_instr_read;
	output reg[31:0]	o_instruction;
	output reg[31:0]	o_memreaddat;
	output reg[31:0]	o_ioaddr;
	
	
	reg 	instr_read;  
	reg[31:0]	instruction;
	//reg[31:0]	iodat;
	assign o_instr_read=instr_read;
//	assign i_iodat=(i_memwrite_cs)?iodat:32'bz;
	//出现储存器没读完PC继续加的情况将上次PC值赋予

	
	
	always@(posedge clock or negedge rst)begin
		if(!rst)	instruction<=32'h0;
		else if((i_memread_cs!=1)&&(i_memwrite_cs!=1)) instruction[31:0]<=i_iodat[31:0];
	end
	
	
	always@(*)begin
		if((i_memread_cs==1)||(i_memwrite_cs==1))begin
			 instr_read=0;
			 o_instruction[31:0]=instruction[31:0]; //instruction is the last and add a block
			 o_bus_block=1;			 //and PC-4
			 o_ioaddr[31:0]=i_memaddress[31:0];
			 if(i_memread_cs==1)begin
			 	o_memreaddat[31:0]=i_iodat[31:0];
			 	o_iodat[31:0]<=32'h0;
			 end
			 else begin
			    o_iodat[31:0]=i_writedat[31:0];
			    o_memreaddat[31:0]=32'h0;
			 end
		end

		else begin
			 instr_read=1;
			 o_bus_block=0;	
			 o_instruction[31:0]=i_iodat[31:0];
			 o_ioaddr[31:0]=i_memstraddress[31:0];
			 o_memreaddat[31:0]=32'h0;
			 o_iodat[31:0]=32'h0;
		end
	end



	
endmodule
