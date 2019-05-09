module mem(
		   clock,
		   rst,
		   i_read_cs,
		   i_write_cs,
		   i_address,
		   i_memdat,
		   o_memdat,
		   o_led);
	input[31:0] i_memdat;	   
	input clock;
	input rst;
	input i_write_cs;
	input i_read_cs;
	input[31:0] i_address;
	reg led_n;
	output o_led;
	output reg[31:0] o_memdat;	   
		   
		   
	reg write_cs=0;
	//wire[31:0] o_memdat;
	reg[31:0] m[31:0];
	reg[31:0] memdat;
	//assign o_memdat[31:0]=memdat[31:0];
	//always@(*)if(i_read_cs) o_memdat[31:0]=m[i_address];
	//always@(*)write_cs=i_write_cs;
	assign o_led=led_n;
	//assign	 o_memdat[31:0]=(i_read_cs)?m[i_address]:0;
	
	always@(*)begin
		if(i_read_cs==1)
			o_memdat[31:0]=m[i_address];
		else
			o_memdat[31:0]=32'h0;
	end
	always@(posedge clock or negedge rst)begin
		if(!rst)begin
			//m[0]<=32'h010C0E33;
			m[0]<=32'h0;
			m[1]<=32'h0;
			m[2]<=32'h0;
			m[3]<=32'h0;
			m[4]<=32'h4020A023;
			m[5]<=32'h0;
			m[6]<=32'h0;
			m[7]<=32'h0;
			m[8]<=32'hFF9FF1EF;
			m[9]<=32'h135;
			m[10]<=32'h136;
			m[11]<=32'h0;
			//m[12]<=32'h00628233;
			//m[12]<=32'h00311163;
			m[14]<=32'h137;
			m[15]<=32'h0;
			m[16]<=32'h139;
			m[17]<=32'h0;
			m[18]<=32'h138;
			m[19]<=32'h0;
		end
		else if(i_write_cs==1)	m[i_address]<=i_memdat[31:0];
	end
	
	always@(posedge clock or negedge rst)begin
		if(!rst)	led_n<=0;
		else if((i_write_cs==1)
				&&(i_address[31:0]==32'h00000402))begin
				led_n<=i_memdat[31:0];
		end
	end
endmodule
