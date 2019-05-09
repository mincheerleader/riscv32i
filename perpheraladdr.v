module perpheraladdr(
					i_read_cs,
					i_write_cs,
					i_address,
					o_memdat,
					o_led);
	
	input	i_read_cs;
	input	i_write_cs;
	input[31:0]	i_address;
	inout[31:0]	o_memdat;
	output o_led;
	reg led_n;

	assign	 o_memdat[31:0]=(i_write_cs)?32'bz:led_n;
	assign	o_led=led_n;
	
	always@(*)begin
		if((i_write_cs==1)
			&&(i_address[31:0]==32'h80000002))
				led_n=o_memdat[31:0];
	end

endmodule
