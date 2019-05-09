`include"def.v"
module cpu(i_instr,clock,rst,i_bus_block,o_memstraddr,o_instrnop,o_memaddr,o_memread_cs,o_memwrite_cs,i_memreaddat,o_memwritedat);

	input	clock,rst;
	input	i_bus_block;
	output[31:0]	o_memstraddr;
	wire[31:0]	o_memstraddr;
	output	o_instrnop;
	wire	o_instrnop;
	wire[6:0] IF_op;
	wire[2:0] IF_fun3;
	wire[6:0] IF_fun7;
	wire[4:0] IF_rd;
	wire[4:0] IF_rs1;
	wire[4:0] IF_rs2;
	wire	  IF_skip_cs;
	wire[31:0] IF_skip_addr;
/*IF_ID*/
	input[31:0] i_instr;
	wire[6:0]	ID_op;
	wire[2:0]	ID_fun3;
	wire[6:0]	ID_fun7;
	wire[4:0]	ID_rd;
	wire[4:0]	ID_rs1;
	wire[4:0]	ID_rs2;
	wire[31:0]	ID_memstraddr;
	wire		ID_jump_cs;
	wire[31:0]	ID_jump_addr;
	wire[31:0]	ID_jump_regdat1;
	wire[31:0]	ID_jump_regdat2;
	wire		ID_jump_risk_block;
	reg			ID_LW_block=0;
	reg[1:0]	alu_A_select;
	reg[1:0]	alu_B_select;
/*ID_EX*/
	wire[31:0]	ID_read_dat1;
	wire[31:0]	ID_read_dat2;
	wire[31:0]	EX_memstraddr;
	wire[31:0]	EX_regdat1;
	wire[31:0]	EX_regdat2;
	wire[6:0]	EX_fun7;
	wire[6:0]	EX_op;
	wire[4:0]	EX_rs1;
	wire[4:0]	EX_rs2;
	wire[4:0]	EX_rd;
	wire[3:0]   EX_operation;
	wire[31:0]	EX_A;
	wire[31:0]	EX_B;
	wire[2:0]	EX_fun3;
/*EX_MEM*/

	wire[31:0]	aludat;
	wire		zero;
	wire[31:0]	MEM_aludat;
	wire[6:0]	MEM_op;
	wire[4:0]	MEM_rd;
	wire[31:0]	MEM_regdat2;
	wire[2:0]	MEM_fun3;
	wire[2:0]	MEM_load_WHB;
	wire[1:0]	MEM_store_WHB;
/*MEM_WB*/	
	output reg[31:0] o_memaddr;
	output reg	    o_memread_cs;
	output reg	    o_memwrite_cs;
	output reg[31:0] o_memwritedat;
	input[31:0]  i_memreaddat;
	reg[31:0]	memreaddat;
	wire[31:0]   reg_writedat;
	wire		WB_regwritecs;
	wire[4:0]	WB_rd;	
	wire[6:0]	WB_op;
	
	PC instr(
			.clock(clock),
			.rst(rst),
			.i_bus_block(i_bus_block),
			.i_LW_block(ID_LW_block),
			.i_memread(o_memread_cs),
			.i_memdat(memreaddat[31:0]),
			.i_jump_cs(ID_jump_cs),
			.i_jump_addr(ID_jump_addr[31:0]),
			.i_skip_cs(IF_skip_cs),
			.i_skip_addr(IF_skip_addr[31:0]),
			.i_jump_risk_block(ID_jump_risk_block),
			.i_nowjumpstraddr(ID_memstraddr[31:0]),
			.o_instraddr(o_memstraddr[31:0]),
			.o_instrnop(o_instrnop));	
			
	coding instrcoding(
				.i_i_instr(i_instr[31:0]),
				.o_op(IF_op[6:0]),
				.o_fun3(IF_fun3[2:0]),
				.o_fun7(IF_fun7[6:0]),
				.o_rd(IF_rd[4:0]),
				.o_rs1(IF_rs1[4:0]),
				.o_rs2(IF_rs2[4:0]));	
		//skip
	
	skip unconditional(
				  .i_i_instr(i_instr[31:0]),
				  .i_op(IF_op[6:0]),
				  /*.i_fun3(IF_fun3[2:0]),
				  .i_rs1(IF_rs1[4:0]),
				  .i_rs2(IF_rs2[4:0]),
				  .i_fun7(IF_fun7[4:0]),*/
				  .o_skip_cs(IF_skip_cs),
				  .o_skip_addr(IF_skip_addr[31:0]));
		
	IF_ID_reg if_id(
				.clock(clock),
				.rst(rst),
				.i_instraddr(o_memstraddr[31:0]),
				.i_op(IF_op[6:0]),
				.i_fun3(IF_fun3[2:0]),
				.i_fun7(IF_fun7[6:0]),
				.i_rd(IF_rd[4:0]),
				.i_rs1(IF_rs1[4:0]),
				.i_rs2(IF_rs2[4:0]),
				.i_instrnop(o_instrnop),
				.i_bus_block(i_bus_block),
				.i_LW_block(ID_LW_block),
				.i_jump_cs(ID_jump_cs),
				.i_jump_risk_block(ID_jump_risk_block),
				.o_op(ID_op[6:0]),
				.o_fun3(ID_fun3[2:0]),
				.o_fun7(ID_fun7[6:0]),
				.o_rd(ID_rd[4:0]),
				.o_rs1(ID_rs1[4:0]),
				.o_instraddr(ID_memstraddr[31:0]),
				.o_rs2(ID_rs2[4:0]));
/*ID_EX*/
	jump_input risk_jump(
						.i_rs1(ID_rs1[4:0]),
						.i_rs2(ID_rs2[4:0]),
						.i_op(ID_op[6:0]),
						.i_EX_rd(EX_rd[4:0]),
						.i_EX_op(EX_op[6:0]),
						.i_MEM_rd(MEM_rd[4:0]),
						.i_MEM_op(MEM_op[6:0]),
						.i_WB_rd(WB_rd[4:0]),
						.i_WB_op(WB_op[6:0]),
						.i_EX_aludat(aludat[31:0]),
						.i_MEM_aludat(MEM_aludat[31:0]),
						.i_reg_writedat(reg_writedat[31:0]),
						.i_ID_reg_readdat1(ID_read_dat1[31:0]),
						.i_ID_reg_readdat2(ID_read_dat2[31:0]),
						.o_regdat1(ID_jump_regdat1[31:0]),
						.o_regdat2(ID_jump_regdat2[31:0]),
						.o_jump_risk_block(ID_jump_risk_block));
		
	jump condition(
				.i_rd(ID_rd[4:0]),
				.i_op(ID_op[6:0]),
				.i_rs2(ID_rs2[4:0]),
				.i_fun3(ID_fun3[2:0]),
				.i_fun7(ID_fun7[6:0]),
				.i_regdat1(ID_jump_regdat1[31:0]),
				.i_regdat2(ID_jump_regdat2[31:0]),
				.i_ID_jump_risk_block(ID_jump_risk_block),
				.o_jump_addr(ID_jump_addr[31:0]),
				.o_jump_cs(ID_jump_cs));
				
				
	register regfile(
				.i_clock(clock),
				.i_rst(rst),
				.i_rs1(ID_rs1[4:0]),
				.i_rs2(ID_rs2[4:0]),
				.o_read_dat1(ID_read_dat1[31:0]),
				.o_read_dat2(ID_read_dat2[31:0]),
				.i_write_cs(WB_regwritecs),
				.i_rd(WB_rd[4:0]),
				.regdat(reg_writedat[31:0]));

	
	// risk and block
	always@(*)begin
		if((ID_op[6:0]==`I_Load_Op)
			&&(IF_op[6:0]!=`SB_JUMP_Op)
			&&((ID_rd[4:0]==IF_rs1[4:0])
			||(ID_rd[4:0]==IF_rs2[4:0])))
			ID_LW_block=1;
		else
			ID_LW_block=0;
	end
	
	ID_EX_reg id_ex(
				.clock(clock),
				.rst(rst),
				.i_memstraddr(ID_memstraddr[31:0]),
				.i_op(ID_op[6:0]),
				.i_fun3(ID_fun3[2:0]),
				.i_fun7(ID_fun7[6:0]),
				.i_rs1(ID_rs1[4:0]),
				.i_rs2(ID_rs2[4:0]),
				.i_rd(ID_rd[4:0]),
				.i_regdat1(ID_read_dat1[31:0]),
				.i_regdat2(ID_read_dat2[31:0]),				
				.o_regdat1(EX_regdat1[31:0]),
				.o_regdat2(EX_regdat2[31:0]),
				.o_fun7(EX_fun7[6:0]),
				.o_rd(EX_rd[4:0]),
				.o_rs1(EX_rs1[4:0]),
				.o_rs2(EX_rs2[4:0]),
				.o_memstraddr(EX_memstraddr[31:0]),
				.o_op(EX_op[6:0]),
				.o_fun3(EX_fun3[2:0]));
	/*EX_MEM*/			
	//to select A for risk

	aluinput aluin(
				  .i_fun3(EX_fun3[2:0]),
				  .i_op(EX_op[6:0]),
				  .i_regdat1(EX_regdat1[31:0]),
				  .i_regdat2(EX_regdat2[31:0]),
				  .i_rs1(EX_rs1[4:0]),
				  .i_rs2(EX_rs2[4:0]),
				  .i_rd(EX_rd[4:0]),
				  .i_fun7(EX_fun7[6:0]),
				  .i_alu_A_select(alu_A_select[1:0]),
				  .i_alu_B_select(alu_B_select[1:0]),
				  .i_MEM_aludat(MEM_aludat[31:0]),
				  .i_reg_writedat(reg_writedat[31:0]),
				  .i_memstraddr(EX_memstraddr[31:0]),
				  .o_operation(EX_operation[3:0]),
				  .o_A(EX_A[31:0]),
				  .o_B(EX_B[31:0]));
	alu alu(
			.i_operation(EX_operation[3:0]),
			.i_A(EX_A[31:0]),
			.i_B(EX_B[31:0]),			
			.o_aluout(aludat[31:0]),//lw和sw input deferent
			.o_zero(zero));
//data risk and transmit	
//only stiore and jump don't have writeback ,so exploiting op!=`S_store_Op	and `SB_JUMP_Op  to judge the regwritecs
	always@(*)begin
		if((MEM_op[6:0]!=`S_store_Op)
			&&(MEM_op[6:0]!=`SB_JUMP_Op)
			&&(MEM_rd[4:0]==EX_rs1[4:0])
			&&(MEM_rd[4:0]!=0)		
			&&(MEM_op[6:0]!=`I_Load_Op)) 
				alu_A_select[1:0]=`risk_tranA_EX; //rs1 EX risk
		else if((WB_op[6:0]!=`S_store_Op)
				&&(WB_op[6:0]!=`SB_JUMP_Op)
				&&(WB_rd[4:0]!=0)
				&&(WB_rd[4:0]==EX_rs1[4:0])
				&&((MEM_rd[4:0]!=EX_rs1[4:0])))
				alu_A_select[1:0]=`risk_tranA_MEM;
		else alu_A_select=2'h0;	
							
	end
	
	always@(*)begin
		if((MEM_op[6:0]!=`S_store_Op)
			&&(MEM_op[6:0]!=`SB_JUMP_Op)
			&&(MEM_rd[4:0]==EX_rs2[4:0])
			&&(MEM_rd[4:0]!=0)
			&&(MEM_op[6:0]!=`I_Load_Op)) 
				alu_B_select[1:0]=`risk_tranB_EX; //rs1 EX risk
		else if((WB_op[6:0]!=`S_store_Op)
				&&(WB_op[6:0]!=`SB_JUMP_Op)
				&&(WB_rd[4:0]!=0)
				&&(WB_rd[4:0]==EX_rs2[4:0])
				&&((MEM_rd[4:0]!=EX_rs2[4:0])))
				alu_B_select[1:0]=`risk_tranB_MEM;
		else alu_B_select=2'h0;						
	end
	
	EX_MEM_reg ex_mem(
					.clock(clock),
					.rst(rst),
					.i_aludat(aludat[31:0]),
					.i_aluzero(zero),
					.i_fun3(EX_fun3[2:0]),
					.i_op(EX_op[6:0]),
					.i_rd(EX_rd[4:0]),
					.i_regdat2(EX_regdat2[31:0]),
					.o_fun3(MEM_fun3[2:0]),	
					.o_aludat(MEM_aludat[31:0]),
					.o_aluzero(MEM_zero),
					.o_op(MEM_op[6:0]),
					.o_rd(MEM_rd[4:0]),
					.o_regdat2(MEM_regdat2[31:0]));

/*MEM_WB*/
	always@(*)begin
		if((MEM_op[6:0]==`I_Load_Op)||(MEM_op[6:0]==`S_store_Op))	
			o_memaddr=MEM_aludat[31:0];
		else 
			o_memaddr=32'h0;
	end
	
	always@(*)begin
		if(MEM_op[6:0]==`S_store_Op)begin
			o_memwrite_cs=1'h1;
			case(MEM_fun3[2:0])
				`SB:o_memwritedat=MEM_regdat2[7:0];
				`SH:o_memwritedat=MEM_regdat2[15:0];
				`SW:o_memwritedat=MEM_regdat2[31:0];
				default:o_memwritedat=32'h0;
			endcase
		end
		else begin
			o_memwrite_cs=1'h0;
			o_memwritedat=32'h0;
		end
	end


	always@(*)begin
		if(MEM_op[6:0]==`I_Load_Op)begin
			o_memread_cs=1'h1;
			case(MEM_fun3[2:0])
				`Load_LW:memreaddat[31:0]=i_memreaddat[31:0];
				`Load_LH:memreaddat[31:0]={{16{i_memreaddat[15]}},i_memreaddat[15:0]};
				`Load_LB:memreaddat[31:0]={{24{i_memreaddat[7]}},i_memreaddat[7:0]};
				`Load_LHU:memreaddat[31:0]={16'h0,i_memreaddat[15:0]};
				`Load_LBU:memreaddat[31:0]={24'h0,i_memreaddat[7:0]};
				default:memreaddat[31:0]=32'h0;
			endcase
			
		end
		else begin
			memreaddat[31:0]=32'h0;
			o_memread_cs=1'h0;
		end
	end
	MEM_WB_reg mem_wb(
					.clock(clock),
					.rst(rst),
					.i_op(MEM_op[6:0]),
					.i_aludat(MEM_aludat[31:0]),
					.i_memdat(memreaddat[31:0]),
					.i_rd(MEM_rd[4:0]),
					.o_regwritecs(WB_regwritecs),
					.o_reg_writedat(reg_writedat[31:0]),
					.o_rd(WB_rd[4:0]),
					.o_op(WB_op[6:0]));

endmodule
