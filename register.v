module register(input i_clock,input i_rst,input[4:0] i_rs1,input[4:0] i_rs2,
				output reg[31:0] o_read_dat1,output reg[31:0] o_read_dat2,
				input i_write_cs,input[4:0] i_rd,input[31:0] regdat);
				
		reg[31:0]	regfile[31:0];
		
	//	assign	o_read_dat1=regfile[i_rs1];
	//	assign	o_read_dat2=regfile[i_rs2];
		always@(*)begin
			if((i_write_cs==1)&&((i_rd[4:0])==i_rs1[4:0])&&((i_rd[4:0])==i_rs2[4:0]))begin
				o_read_dat1[31:0]=regdat[31:0];
				o_read_dat2[31:0]=regdat[31:0];
			end
			else if(i_write_cs==1&&(i_rd[4:0])==i_rs1[4:0])begin
				o_read_dat1[31:0]=regdat[31:0];
				o_read_dat2=regfile[i_rs2];
			end
			else if(i_write_cs==1&&(i_rd[4:0])==i_rs2[4:0])begin
				o_read_dat2[31:0]=regdat[31:0];
				o_read_dat1=regfile[i_rs1];
			end
			else begin
					o_read_dat1=regfile[i_rs1];
					o_read_dat2=regfile[i_rs2];
			end
		end
		always@(posedge i_clock or negedge i_rst)begin
			if(!i_rst)begin
				regfile[0]<=32'h0;
				regfile[1]<=32'h02;
				regfile[2]<=32'h01;
				regfile[3]<=32'h20;
				regfile[4]<=32'h15;
				regfile[5]<=32'h25;
				regfile[6]<=32'h11;
				regfile[7]<=32'h22;
				regfile[8]<=32'h55;
				regfile[9]<=32'h01;
				regfile[10]<=32'h02;
				regfile[11]<=32'h05;
				regfile[12]<=32'h50;
				regfile[13]<=32'h20;
				regfile[14]<=32'h10;
				regfile[15]<=32'h13;
				regfile[16]<=32'h03;
				regfile[17]<=32'h30;
				regfile[18]<=32'h33;
				regfile[19]<=32'h43;
				regfile[20]<=32'h34;
				regfile[21]<=32'h44;
				regfile[22]<=32'h54;
				regfile[23]<=32'h45;
				regfile[24]<=32'h57;
				regfile[25]<=32'h56;
				regfile[26]<=32'h65;
				regfile[27]<=32'h66;
				regfile[28]<=32'h12;
				regfile[29]<=32'h75;
				regfile[30]<=32'h77;
				regfile[31]<=32'h27;
			end
			else if(i_write_cs)
				regfile[i_rd]<=regdat[31:0];
				
		end


endmodule
