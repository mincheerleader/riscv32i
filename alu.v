`include"def.v"


module aluinput(	
				input[2:0]	i_fun3,
				input[6:0]	i_op,
				input[31:0]	i_regdat1,
				input[31:0]	i_regdat2,
				input[4:0]	i_rs1,
				input[4:0]	i_rs2,
				input[4:0]	i_rd,
				input[6:0]	i_fun7,
				input[1:0]	i_alu_A_select,
				input[1:0]	i_alu_B_select,
				input[31:0] i_MEM_aludat,
				input[31:0]	i_reg_writedat,
				input[31:0]	i_memstraddr,
				output reg[3:0]	o_operation,
				output reg[31:0]	o_A,
				output reg[31:0]	o_B);
				
	reg[3:0]	operation_R;	
	reg[3:0]	operation_LS;
	reg[31:0]	o_B1;	
	reg[31:0]	o_A1;
	//risk and tranfer
	
	always@(*)begin
		case(i_alu_A_select)
			2'h0:o_A1[31:0]=i_regdat1[31:0];
			`risk_tranA_EX:o_A1[31:0]=i_MEM_aludat[31:0];
			`risk_tranA_MEM:o_A1[31:0]=i_reg_writedat[31:0];
			default:o_A1[31:0]=i_regdat1[31:0];
		endcase
	end
	always@(*)begin
		case(i_alu_B_select)
			2'h0:o_B1[31:0]=i_regdat2[31:0];
			`risk_tranA_EX:o_B1[31:0]=i_MEM_aludat[31:0];
			`risk_tranA_MEM:o_B1[31:0]=i_reg_writedat[31:0];
			default:o_B1[31:0]=i_regdat2[31:0];
		endcase
	end
	
	//slect the inputs of alu 
	
	always@(*)begin
		case(i_op[6:0])
			`U_LUI_Op:o_A[31:0]=12'h0;
			`UJ_Op:o_A[31:0]=i_memstraddr[31:0];
			`I_JALR_Op:o_A[31:0]=i_memstraddr[31:0];
			`U_AUIPC_Op:o_A[31:0]=i_memstraddr[31:0];
			default:o_A[31:0]=o_A1[31:0];
		endcase
	end
	
	
	always@(*)begin
		case(i_op[6:0])
			`R_Op:o_B[31:0]=o_B1[31:0];
			`I_Load_Op:o_B[31:0]={{20{i_fun7[6]}},i_fun7[6:0],i_rs2[4:0]};
			`S_store_Op:o_B[31:0]={{20{i_fun7[6]}},i_fun7[6:0],i_rd[4:0]};
			`I_addi_Op:begin
							if((i_fun3[2:0]==1)||(i_fun3[2:0]==5))	o_B[31:0]={27'h0,i_rs2[4:0]};	
							else o_B[31:0]={20'h0,i_fun7[6:0],i_rs2[4:0]};
						end
			`UJ_Op:o_B[31:0]=32'h4;
			`I_JALR_Op:o_B[31:0]=32'h4;
			`U_LUI_Op:o_B[31:0]={i_fun7[6:0],i_rs2[4:0],i_rs1[4:0],i_fun3[2:0],12'h0};
			`U_AUIPC_Op:o_B[31:0]={i_fun7[6:0],i_rs2[4:0],i_rs1[4:0],i_fun3[2:0],12'h0};
			7'h0:o_B[31:0]=32'h0;
			default:o_B[31:0]=32'h0;
		endcase
	end
	
	
//slect the operation of alu
	always@(*)begin
		case(i_op[6:0])
			`R_Op:o_operation[3:0]=operation_R[3:0];
			`I_addi_Op:o_operation[3:0]=operation_R[3:0];
			`I_Load_Op:o_operation[3:0]=`alu_add;
			`S_store_Op:o_operation[3:0]=`alu_add;
			`UJ_Op:o_operation[3:0]=`alu_add;
			`I_JALR_Op:o_operation[3:0]=`alu_add;
			`U_LUI_Op:o_operation[3:0]=`alu_add;
			`U_AUIPC_Op:o_operation[3:0]=`alu_add;
			default:o_operation[3:0]=`alu_add;
		endcase
	end

	always@(*)begin
		if((i_op[6:0]==`I_addi_Op)||(i_op[6:0]==`R_Op))begin
			if((i_fun3[2:0]==0)&&(i_op[6:0]==`R_Op)&&(i_fun7[6:0]==7'h20))
				operation_R[3:0]=`alu_sub;
			else if((i_fun3[2:0]==5)&&(i_fun7[6:0]==7'h20))
				operation_R[3:0]=`alu_SRA;
			else	operation_R[3:0]={1'h0,i_fun3[2:0]};
		end
		else operation_R[3:0]={1'h0,i_fun3[2:0]};
	end

		

endmodule


module alu(input[3:0] i_operation,input[31:0] i_A,input[31:0] i_B,
			output reg[31:0] o_aluout,output o_zero);
			
	assign o_zero=(o_aluout==0);
	
	always@(i_operation,i_A,i_B)begin
		case(i_operation)
			`alu_add:o_aluout=i_A+i_B;
			`alu_sub:o_aluout=i_A-i_B;
			`alu_SLL:o_aluout=i_A<<i_B[4:0];
			`alu_SLT:o_aluout=(i_A<i_B);
			`alu_SLTU:o_aluout=(i_A<i_B);	//和上面的操作还有bug
			`alu_XOR:o_aluout=((~i_A)&i_B)|(i_A&(~i_B));
			`alu_SRL:o_aluout=i_A>>i_B[4:0];
			`alu_SRA:o_aluout=i_A>>>i_B[4:0];//有问题
			`alu_OR:o_aluout=i_A|i_B;
			`alu_AND:o_aluout=i_A&i_B;
			default:o_aluout=0;
		endcase

	end

endmodule

