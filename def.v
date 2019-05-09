

`define R_Op 7'h33	//0110011
`define I_addi_Op 7'h13	//R immediate
`define I_Load_Op 7'h03
`define	I_JALR_Op 7'h67
`define S_store_Op 7'h23
`define SB_JUMP_Op 7'h63
`define U_LUI_Op 7'h37
`define U_AUIPC_Op	7'h17
`define UJ_Op 7'h6F


`define R_add	17'h33
`define R_sub	17'h8033
`define R_SLL	17'hB3
`define R_SLT	17'h133
`define R_SLTU	17'h1B3
`define R_XOR	17'h233
`define R_SRL	17'h2B3
`define R_SRA	17'h82B3
`define R_OR	17'h333
`define R_AND	17'h3B3

`define ADDI	3'h0
`define SLTI	3'h2
`define SLTIU	3'h3
`define XORI	3'h4
`define ORI		3'h6
`define ANDI	3'h7
`define SLLI	3'h1
`define SRLI	10'h005
`define SRAI	10'h105

`define LB		3'h0
`define LH		3'h1
`define LW		3'h2
`define LBU		3'h4
`define LHU		3'h5

`define SB		3'h0
`define SH		3'h1
`define SW		3'h2

`define BEQ		3'h0
`define BNE		3'h1
`define BLT		3'h4
`define BGE		3'h5
`define BLTU	3'h6
`define BGEU	3'h7
/*alu operate*/
`define	alu_add	4'h0
`define alu_sub 4'h8
`define alu_SLL 4'h1	//left shift
`define alu_SLT 4'h2	//compare rs1<rs2
`define alu_SLTU 4'h3	// compare x0!=rs2
`define alu_XOR 4'h4
`define alu_SRL	4'h5
`define alu_SRA 4'hD
`define alu_OR  4'h6
`define alu_AND	4'h7



`define alu_inputR 4'h1
`define alu_inputI 4'h2
`define alu_inputS1 4'h3
`define alu_inputI1 4'h4
`define alu_inputI2 4'h5
`define alu_inputJAL 4'h6

`define Memread 1'h1
`define Memwrite 1'h1
`define RegWrite 1'h1
`define MemToReg 1'h1

`define Load_LW	3'h2
`define Load_LH	3'h1
`define Load_LB	3'h0
`define Load_LHU	3'h5
`define Load_LBU	3'h4

`define score_SW 2'h1
`define score_SH 2'h2
`define score_SB 2'h3

`define risk_tranA_EX 2'h1
`define risk_tranA_MEM 2'h2
`define risk_tranB_EX 2'h1
`define risk_tranB_MEM 2'h2

`define spi_write_en 8'h06
`define spi_write_disen 8'h04
`define spi_read_en 8'h03