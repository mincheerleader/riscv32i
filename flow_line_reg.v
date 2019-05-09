`include"def.v"

module IF_ID_reg(	input clock,input rst,
					input[6:0]		i_op,
					input[31:0]		i_instraddr,
					input[2:0]		i_fun3,
					input[6:0]		i_fun7,
					input[4:0]		i_rd,
					input[4:0]		i_rs1,
					input[4:0]		i_rs2,
					input			i_instrnop,
					input			i_bus_block,
					input			i_LW_block,
					input			i_jump_cs,
					input			i_jump_risk_block,
					output [6:0] 	o_op,
					output [2:0]	o_fun3,
					output [6:0]	o_fun7,
					output [4:0]	o_rd,
					output [4:0]	o_rs1,
					output[31:0]	o_instraddr,
					output [4:0]	o_rs2);
	reg[31:0] instraddr;
	reg[6:0] op;
	reg[2:0] fun3;
	reg[6:0] fun7;
	reg[4:0] rd;
	reg[4:0] rs1;
	reg[4:0] rs2;
	
	assign	o_instraddr[31:0]=instraddr[31:0];
	assign	o_op[6:0]=op[6:0];
	assign	o_fun3[2:0]=fun3[2:0];
	assign  o_fun7[6:0]=fun7[6:0];
	assign	o_rd[4:0]=rd[4:0];
	assign  o_rs1[4:0]=rs1[4:0];
	assign	o_rs2[4:0]=rs2[4:0];
	
	
	
	always@(posedge clock or negedge rst)begin
		if(!rst)begin
			op<=7'h0;
			fun3<=3'h0;
			fun7<=7'h0;
			rd<=5'h0;
			rs1<=5'h0;
			rs2<=5'h0;
			instraddr<=32'h0;
		end
		else if((i_instrnop==1)
				||(i_bus_block==1)
				||(i_LW_block==1)
				||(i_jump_cs==1)
				||(i_jump_risk_block==1))begin
			op<=7'h0;
			fun3<=3'h0;
			fun7<=7'h0;
			rd<=5'h0;
			rs1<=5'h0;
			rs2<=5'h0;
		end
		else begin
			instraddr[31:0]<=i_instraddr[31:0];
			op[6:0]<=i_op[6:0];
			fun3[2:0]<=i_fun3[2:0];
			fun7[6:0]<=i_fun7[6:0];
			rd[4:0]<=i_rd[4:0];
			rs1[4:0]<=i_rs1[4:0];
			rs2[4:0]<=i_rs2[4:0];
		end
	end
endmodule


module ID_EX_reg(input clock, input rst,
				 input[31:0]	i_regdat1,
				 input[31:0]	i_regdat2,				
				 input[2:0]		i_fun3,
				 input[6:0]		i_fun7,
				 input[4:0]		i_rs1,
				 input[4:0]		i_rs2,
				 input[4:0]		i_rd,				 
				 input[31:0]	i_memstraddr,
				 input[6:0]		i_op,				 
				 output[6:0]	o_fun7,
				 output[4:0]	o_rs1,
				 output[4:0]	o_rs2,
				 output[31:0]	o_regdat1,
				 output[31:0]	o_regdat2,
				 output[4:0]	o_rd ,
				 output[31:0]	o_memstraddr,
				 output[6:0]	o_op,
				 output[2:0]	o_fun3);
	
	reg[31:0]	regdat1;
	reg[31:0]	regdat2;
	reg[2:0]	fun3;
	reg[6:0]	fun7;
	reg[4:0]	rs2;
	reg[4:0]	rs1;
	reg[4:0]	rd;
	reg[31:0]	memstraddr;
	reg[6:0]	op;
	
	assign	o_fun3[2:0]=fun3[2:0];
	assign	o_memstraddr[31:0]=memstraddr[31:0];
	assign	o_op[6:0]=op[6:0];
	assign	o_regdat1[31:0]=regdat1[31:0];
	assign	o_regdat2[31:0]=regdat2[31:0];
	assign	o_rs2[4:0]=rs2[4:0];
	assign	o_rs1[4:0]=rs1[4:0];
	assign	o_fun7[6:0]=fun7[6:0];
	assign	o_rd[4:0]=rd[4:0];
	
	always@(posedge clock or negedge rst)begin
		if(!rst)begin
			regdat1<=32'h0;
			regdat2<=32'h0;
			fun3<=3'h0;
			fun7<=7'h0;
			rs2<=5'h0;
			rs1<=5'h0;
			rd<=5'h0;
			op<=7'h0;
			memstraddr<=32'h0;
		end

		else begin
			regdat1[31:0]<=i_regdat1[31:0];
			regdat2[31:0]<=i_regdat2[31:0];
			fun3[2:0]<=i_fun3[2:0];
			fun7[6:0]<=i_fun7[6:0];
			rs2[4:0]<=i_rs2[4:0];
			rs1[4:0]<=i_rs1[4:0];
			rd<=i_rd[4:0];
			op[6:0]<=i_op[6:0];
			memstraddr[31:0]<=i_memstraddr[31:0];
		end
	end 

endmodule



module EX_MEM_reg(input clock,input rst,
				  input[31:0] 	i_aludat,
				  input 		i_aluzero,
				  input[4:0] 	i_rd,
				  input[31:0] 	i_regdat2,
				  input[6:0]	i_op,
				  input[2:0]	i_fun3,
				  output[2:0]	o_fun3,
				  output[6:0]	o_op,
				  output[31:0] 	o_aludat,
				  output 		o_aluzero,
				  output[4:0] 	o_rd,
				  output[31:0] 	o_regdat2 );


	reg[31:0]	aludat;
	reg			zero;
	reg[4:0]	rd;
	reg[31:0]	regdat2;
	reg[6:0]	op;
	reg[2:0]	fun3;
	
	assign	o_fun3[2:0]=fun3[2:0];
	assign	o_op[6:0]=op[6:0];	
	assign	o_aludat[31:0]=aludat[31:0];
	assign	o_aluzero=zero;
	assign	o_rd=rd;
	assign	o_regdat2=regdat2;
	
	always@(posedge clock or negedge rst)begin
		if(!rst)begin
			aludat<=32'h0;
			zero<=0;
			rd<=5'h0;
			regdat2<=32'h0;
			op<=7'h0;
			fun3=3'h0;
		end
		else begin
			aludat[31:0]<=i_aludat[31:0];
			zero<=i_aluzero;
			rd[4:0]<=i_rd[4:0];
			regdat2[31:0]<=i_regdat2[31:0];
			op[6:0]<=i_op[6:0];			
			fun3[2:0]=i_fun3[2:0];
		end
	end

endmodule


module MEM_WB_reg(input clock,input rst,
				  input[31:0] 	i_aludat,
				  input[31:0] 	i_memdat,
				  input[4:0]	i_rd,
				  input[6:0]	i_op,
				  output		o_regwritecs,
				  output[31:0]	o_reg_writedat,
				  output[4:0] 	o_rd,
				  output[6:0]	o_op );

	reg[4:0] rd;
	reg[31:0] reg_writedat;
	reg		regwritecs;
	reg[6:0]	op;
	
	assign o_op[6:0]=op[6:0];
	assign o_reg_writedat[31:0]=reg_writedat[31:0];
	assign o_regwritecs=regwritecs;
	assign o_rd[4:0]=rd[4:0];

	
	always@(posedge clock or negedge rst)begin
		if(!rst)begin
			rd<=5'h0;
			reg_writedat<=32'h0;
			regwritecs<=1'h0;
		end
		else	begin
			op[6:0]<=i_op[6:0];
			rd[4:0]<=i_rd[4:0];
			reg_writedat[31:0]<=(i_op[6:0]==`I_Load_Op)?i_memdat[31:0]:i_aludat[31:0];
			if((i_op[6:0]==`S_store_Op)
				||(i_op[6:0]==`SB_JUMP_Op)
				||(i_op[6:0]==0))	
				regwritecs=1'h0;
			else if(i_op[6:0])	regwritecs=1'h1;
			else regwritecs=1'h0;
		end
	end

endmodule

