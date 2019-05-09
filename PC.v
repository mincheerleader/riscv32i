`include"def.v"
module PC(input clock,input rst,
		  input			i_memread,
		  input			i_bus_block,
		  input			i_LW_block,
		  input			i_skip_cs,
		  input			i_jump_cs,
		  input[31:0]	i_jump_addr,
		  input[31:0]	i_skip_addr,
		  input[31:0]	i_memdat,
		  input[31:0]	i_nowjumpstraddr,
		  input			i_jump_risk_block,
	  	  output[31:0] 	o_instraddr,
	  	  output		o_instrnop );

	reg[31:0]	instraddr;
	reg		instr_nop=0;
	reg		LW_block;	
	reg[1:0]	PC_add=2'h0;
	
	assign	o_instrnop=instr_nop;
	assign	o_instraddr[31:0]=instraddr[31:0];
	
	always@(posedge clock or negedge rst)begin
		if(!rst)	LW_block<=1'h0;
		else  LW_block<=i_LW_block;
	end
	

	always@(posedge clock or negedge rst)begin
		if(!rst)begin	
				instraddr<=32'h4;
				instr_nop<=1'h0;
			end
	 	else if(((i_memread==1)&&(i_memdat==32'h0))
	 			||(i_LW_block==1)
	 			||(i_bus_block==1)
	 			||(i_jump_risk_block==1))begin
	 		if((i_jump_risk_block==1))
	 			instraddr[31:0]<=i_nowjumpstraddr[31:0];
	 		else
		 		instraddr[31:0]<=instraddr[31:0];//mem中数据还没读出来，保持上次的指令地址不变
		 	if((i_memread==1)&&(i_memdat==32'h0))instr_nop<=1'h1;
		 	else instr_nop<=1'h0;
		end
		//else if((i_jump_risk_block==1))begin
		//	instraddr[31:0]<=i_nowjumpstraddr[31:0];
		//end
		else if(i_skip_cs==1)begin
			instraddr[31:0]<=instraddr[31:0]+i_skip_addr[31:0];
			instr_nop<=1'h0;
		end
		else if(i_jump_cs==1)begin
			instraddr[31:0]<=instraddr[31:0]+i_jump_addr[31:0]-4;
			instr_nop<=1'h0;
		end
		else begin
			instraddr[31:0]<=instraddr[31:0]+4;
			instr_nop<=1'h0;
		end
	end
endmodule


module coding(
			input[31:0] 	i_i_instr,
			output reg[6:0]	o_op,
			output reg[2:0]	o_fun3,
			output reg[6:0]	o_fun7,
			output reg[4:0]	o_rd,
			output reg[4:0]	o_rs1,
			output reg[4:0]	o_rs2);
			
			
		always@(*)begin
		

			o_op[6:0]<=i_i_instr[6:0];
			o_fun3[2:0]<=i_i_instr[14:12];
			o_fun7[6:0]<=i_i_instr[31:25];
			o_rd[4:0]<=i_i_instr[11:7];
			o_rs1[4:0]<=i_i_instr[19:15];
			o_rs2[4:0]<=i_i_instr[24:20];
		
		end

endmodule


module skip(
			input[31:0]	i_i_instr,			  
			input[6:0]	i_op,
			/*input[2:0]	i_fun3,
			input[4:0]  i_rs1,
			input[4:0]	i_rs2,
			input[4:0]	i_fun7,*/
			output reg		 o_skip_cs,
			output reg[31:0] o_skip_addr);
	always@(*)begin
		if(i_op[6:0]==`UJ_Op)begin
			o_skip_cs=1'h1;
			o_skip_addr[31:0]={{11{i_i_instr[31]}},i_i_instr[31],i_i_instr[19:12],i_i_instr[20],i_i_instr[30:21],1'h0};
		end
		else if(i_op[6:0]==`U_AUIPC_Op)begin
			o_skip_cs=1'h1;
			o_skip_addr[31:0]={i_i_instr[31:12],12'h0};
		end
		else begin
			o_skip_cs=1'h0;
			o_skip_addr[31:0]=32'h0;
		end
	end
endmodule

module jump_input(
				input[4:0]	i_rs1,
				input[4:0]	i_rs2,
				input[6:0]	i_op,
				input[4:0]	i_EX_rd,
				input[6:0]	i_EX_op,
				input[4:0]	i_MEM_rd,
				input[6:0]	i_MEM_op,
				input[6:0]	i_WB_op,
				input[4:0]	i_WB_rd,
				input[31:0]	i_EX_aludat,
				input[31:0]	i_MEM_aludat,
				input[31:0]	i_reg_writedat,
				input[31:0]	i_ID_reg_readdat1,
				input[31:0]	i_ID_reg_readdat2,
				output reg[31:0]	o_regdat1,
				output reg[31:0]	o_regdat2,
				output reg			o_jump_risk_block);
				
		reg[1:0]	rs1_select=2'h0;
		reg[1:0]	rs2_select=2'h0;
		
		reg			EX_risk=0;//regwritecs and i_op[6:0]==`SB_JUMP_Op
		reg			MEM_risk=0;
		reg			WB_risk=0;
		
		always@(*)begin
			if((i_op[6:0]==`SB_JUMP_Op)
				&&(i_EX_op[6:0]!=`S_store_Op)
				&&(i_EX_op[6:0]!=`SB_JUMP_Op))
					EX_risk=1;
			else EX_risk=0;
		end
		
		always@(*)begin
			if((i_op[6:0]==`SB_JUMP_Op)
				&&(i_MEM_op[6:0]!=`S_store_Op)
				&&(i_MEM_op[6:0]!=`SB_JUMP_Op))
					MEM_risk=1;		
			else MEM_risk=0;
		end
		
		always@(*)begin	
			if((i_op[6:0]==`SB_JUMP_Op)
				&&(i_WB_op[6:0]!=`S_store_Op)
				&&(i_WB_op[6:0]!=`SB_JUMP_Op))
					WB_risk=1;		
			else WB_risk=0;		
		end
//transport	don't have Load
	//select rs1
		always@(*)begin
			case(rs1_select[1:0])
				2'h0:o_regdat1[31:0]=i_ID_reg_readdat1[31:0];
				2'h1:o_regdat1[31:0]=i_EX_aludat[31:0];
				2'h2:o_regdat1[31:0]=i_MEM_aludat[31:0];
				2'h3:o_regdat1[31:0]=i_reg_writedat[31:0];
			endcase
		end		

		always@(*)begin
			if((EX_risk==1)
				&&(i_EX_rd[4:0]==i_rs1[4:0])
				&&(i_EX_rd[4:0]!=0)
				&&(i_EX_op[6:0]!=`I_Load_Op))
					rs1_select[1:0]=2'h1;//EX risk
			else if((MEM_risk==1)
					&&(i_MEM_rd[4:0]!=0)
					&&(i_EX_rd[4:0]!=i_rs1[4:0])
					&&(i_MEM_op[6:0]!=`I_Load_Op)
					&&(i_MEM_rd[4:0]==i_rs1[4:0]))
					rs1_select[1:0]=2'h2;
			else if((WB_risk==1)
					&&(i_WB_rd[4:0]!=0)
					&&(i_EX_rd[4:0]!=i_rs1[4:0])
					&&(i_MEM_rd[4:0]!=i_rs1[4:0])
					//&&(i_WB_op[6:0]!=`I_Load_Op)	WB段Load可以
					&&(i_WB_rd[4:0]==i_rs1[4:0]))
					rs1_select[1:0]=2'h3;
			else	rs1_select[1:0]=2'h0;
		end
	//select rs2
		always@(*)begin
			case(rs2_select[1:0])
				2'h0:o_regdat2[31:0]=i_ID_reg_readdat2[31:0];
				2'h1:o_regdat2[31:0]=i_EX_aludat[31:0];
				2'h2:o_regdat2[31:0]=i_MEM_aludat[31:0];
				2'h3:o_regdat2[31:0]=i_reg_writedat[31:0];
			endcase
		end		

		always@(*)begin
			if((EX_risk==1)
				&&(i_EX_rd[4:0]==i_rs2[4:0])
				&&(i_EX_rd[4:0]!=0)
				&&(i_EX_op[6:0]!=`I_Load_Op))
					rs2_select[1:0]=2'h1;//EX risk
			else if((MEM_risk==1)
					&&(i_MEM_rd[4:0]!=0)
					&&(i_EX_rd[4:0]!=i_rs2[4:0])
					&&(i_MEM_op[6:0]!=`I_Load_Op)
					&&(i_MEM_rd[4:0]==i_rs2[4:0]))
					rs2_select[1:0]=2'h2;
			else if((WB_risk==1)
					&&(i_WB_rd[4:0]!=0)
					&&(i_EX_rd[4:0]!=i_rs2[4:0])
					&&(i_MEM_rd[4:0]!=i_rs2[4:0])
					//&&(i_WB_op[6:0]!=`I_Load_Op)
					&&(i_WB_rd[4:0]==i_rs2[4:0]))
					rs2_select[1:0]=2'h3;
			else	rs2_select[1:0]=2'h0;
		end		
// block have Load	//block in EX and MEM.  don't need block if load in the WB  
		always@(*)begin
			if((i_op[6:0]==`SB_JUMP_Op)
				&&(i_EX_op[6:0]==`I_Load_Op)
				&&((i_EX_rd[4:0]==i_rs1[4:0])
				||(i_EX_rd[4:0]==i_rs2[4:0])))
					o_jump_risk_block=1'h1;
			else if((i_op[6:0]==`SB_JUMP_Op)
					&&(i_EX_op[6:0]!=`I_Load_Op)
					&&(i_MEM_op[6:0]==`I_Load_Op)
					&&((i_MEM_rd[4:0]==i_rs1[4:0])
					||(i_MEM_rd[4:0]==i_rs2[4:0])))
					o_jump_risk_block=1'h1;
			else	o_jump_risk_block=1'h0;
		end
		
endmodule

module jump(
			input[4:0]	i_rd,
			input[6:0]	i_op,
			input[4:0]	i_rs2,
			input[2:0]	i_fun3,
			input[6:0]	i_fun7,
			input[31:0] i_regdat1,
			input[31:0]	i_regdat2,
			input		i_ID_jump_risk_block,
			output reg[31:0]	o_jump_addr,
			output reg			o_jump_cs);
	
	reg[31:0]	JALR_jump_addr=32'h0;
	reg			JALR_jump_cs;
	
	reg[31:0]	SB_jump_addr=32'h0;
	reg			SB_jump_cs;
	
	
	//if jump risk block is existent ,the jump is uneffect
	always@(*)begin
		if(i_ID_jump_risk_block==1)begin
			o_jump_addr[31:0]=32'h0;
			o_jump_cs=1'h0;
		end
		else begin
			case(i_op[6:0])
				`I_JALR_Op:begin
						o_jump_addr[31:0]=JALR_jump_addr[31:0];
						o_jump_cs=JALR_jump_cs;
					end
				`SB_JUMP_Op:begin
						o_jump_addr[31:0]=SB_jump_addr[31:0];
						o_jump_cs=SB_jump_cs;
					end
				default:begin
						o_jump_addr[31:0]=32'h0;
						o_jump_cs=1'h0;
					end
			endcase
		end
	end

//I JALR	
	always@(*)begin
		if(i_op[6:0]==`I_JALR_Op)begin	//the last bit is zero
			JALR_jump_addr[31:0]=({{20{i_fun7[6]}},i_fun7[6:0],i_rs2[4:0]}+i_regdat1[31:0])&32'hfffffffe;
			JALR_jump_cs=1'h1;
		end
		else begin
			JALR_jump_addr[31:0]=32'h0;
			JALR_jump_cs=1'h0;
		end
	end
	
	
	
//SB JUMP
	always@(*)begin
		if(i_op[6:0]==`SB_JUMP_Op)
			SB_jump_addr[31:0]={{19{i_fun7[6]}},i_fun7[6],i_rd[0],i_fun7[5:0],i_rd[4:1],1'h0};
		else	SB_jump_addr[31:0]<=32'h0;
	end
	
	always@(*)begin
		if(i_op[6:0]==`SB_JUMP_Op)
			case(i_fun3[2:0])
				`BEQ:SB_jump_cs=(i_regdat1[31:0]==i_regdat2[31:0]);
				`BNE:SB_jump_cs=(i_regdat1[31:0]!=i_regdat2[31:0]);
				`BLT:SB_jump_cs=((i_regdat1[31:0]&32'hffffffff)<(i_regdat2[31:0]&32'hffffffff));	//compare the sign
				`BLTU:SB_jump_cs=((i_regdat1[31:0]&32'h7fffffff)<(i_regdat2[31:0]&32'h7fffffff));//compare the unsign
				`BGE:SB_jump_cs=((i_regdat1[31:0]&32'hffffffff)>=(i_regdat2[31:0]&32'hffffffff));	//compare the sign
				`BGEU:SB_jump_cs=((i_regdat1[31:0]&32'h7fffffff)>=(i_regdat2[31:0]&32'h7fffffff));//compare the unsign
				default:SB_jump_cs=1'h0;
			endcase			
		else	SB_jump_cs=1'h0;
	end
	
endmodule
