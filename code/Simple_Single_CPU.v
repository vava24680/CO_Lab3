//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:0416315王定偉、0416005張彧豪
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------
//Done
/*
0502 Comments
add branch mux(4-1)
add brach_target mux(2-1)
add memory mux(4-1)
modify the pc source mux to jump mux
*/
module Simple_Single_CPU(
        clk_i,
		rst_i
		);

//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
/*For SLL instruction*/
wire [32-1:0] shamt;
/*For PC Module*/
wire [32-1:0] pc_number;
wire [32-1:0] pc_number_next;
wire [32-1:0] pc_number_in;
/*For IM Module*/
wire [32-1:0] instruction_o;
/*For Reg_File Module*/
wire [5-1:0]  WriteReg;
wire [32-1:0] RSdata_o;
wire [32-1:0] RTdata_o;
/*For Decoder Module*/
wire  Branch_o;
wire [2-1:0] MemToReg_o;
wire [2-1:0] BranchType_o;
wire  Jump_o;
wire  MemRead_o;
wire  MemWrite_o;
wire [3-1:0] ALU_op_o;
wire  ALUSrc_2_o;
wire  RegWrite_o;
wire  RegDst_o;
/*For ALU_Ctrl Module*/
wire ALUSrc_1_o;
wire [4-1:0] ALUCtrl_o;
/*For Sign_Extend Module*/
wire [32-1:0] SE_data_o;
/*For ALU Module*/
wire [32-1:0] ALU_src_1;
wire [32-1:0] ALU_src_2;
wire [32-1:0] result_o;
wire zero_o;
/*For Memory Module*/
wire [32-1:0] MEM_Read_data_o;
/*For Adder2*/
wire [32-1:0] Adder2_result;
/*For Shift_Left_Two_32 Module*/
wire [32-1:0] SL_32_data_o;

wire Brach_signal;
assign shamt = {27'b0,instruction_o[10:6]};
assign Brach_signal = Branch_o & zero_o;

//Greate componentes
ProgramCounter PC(
		//Done
        .clk_i(clk_i),
	    .rst_i (rst_i),
	    .pc_in_i(pc_number_in),
	    .pc_out_o(pc_number)
	    );

Adder Adder1(
		//Done
        .src1_i(pc_number),
	    .src2_i(32'd4),
	    .sum_o(pc_number_next)
	    );

Instr_Memory IM(
		//Done
        .pc_addr_i(pc_number),
	    .instr_o(instruction_o)
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
		//Done
        .data0_i(instruction_o[20:16]),
        .data1_i(instruction_o[15:11]),
        .select_i(RegDst_o),
        .data_o(WriteReg)
        );

Reg_File RF(
		//Done
        .clk_i(clk_i),
	    .rst_i(rst_i),
        .RSaddr_i(instruction_o[25:21]),
        .RTaddr_i(instruction_o[20:16]),
        .RDaddr_i(WriteReg),
        .RDdata_i(result_o),
        .RegWrite_i (RegWrite_o),
        .RSdata_o(RSdata_o),
        .RTdata_o(RTdata_o)
        );

Decoder Decoder(
		//Done
        .instr_op_i(instruction_o[31:26]),
	    .Branch_o(Branch_o),
		.MemToReg_o(MemToReg_o),
		.BranchType_o(BranchType_o),
		.Jump_o(Jump_o),
		.MemRead_o(MemRead_o),
		.MemWrite_o(MemWrite_o),
		.ALU_op_o(ALU_op_o),
		.ALUSrc_o(ALUSrc_2_o),
		.RegWrite_o(RegWrite_o),
		.RegDst_o(RegDst_o)
	    );

ALU_Ctrl AC(
		//Done
        .funct_i(instruction_o[5:0]),
        .ALUOp_i(ALU_op_o),
        .ALUCtrl_o(ALUCtrl_o),
		.ALUSrc_1_o(ALUSrc_1_o)
        );

Sign_Extend SE(
		//Done
        .data_i(instruction_o[16-1:0]),
        .data_o(SE_data_o)
        );



MUX_2to1 #(.size(32)) Mux_ALUSrc_1(
		//Done
        .data0_i(RSdata_o),
        .data1_i(shamt),
        .select_i(ALUSrc_1_o),
        .data_o(ALU_src_1)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc_2(
		//Done
        .data0_i(RTdata_o),
        .data1_i(SE_data_o),
        .select_i(ALUSrc_2_o),
        .data_o(ALU_src_2)
        );

ALU ALU(
		//Done
		.rst(rst_i),
        .src1_i(ALU_src_1),
	    .src2_i(ALU_src_2),
	    .ctrl_i(ALUCtrl_o),
	    .result_o(result_o),
		.zero_o(zero_o)
	    );

Data_Memory MEM(
	.clk_i(clk_i),
	.addr_i(result_o),
	.data_i(RTdata_o),
	.MemRead_i(MemRead_out),
	.MemWrite_i(MemWrite_out),
	.data_o(MEM_Read_data_o)
	);

Adder Adder2(
		//Done
        .src1_i(pc_number_next),
	    .src2_i(SL_32_data_o),
	    .sum_o(Adder2_result)
	    );

Shift_Left_Two_32 Shifter(
		//Done
        .data_i(SE_data_o),
        .data_o(SL_32_data_o)
        );

MUX_2to1 #(.size(32)) Mux_PC_Source(
		//Done
        .data0_i(pc_number_next),
        .data1_i(Adder2_result),
        .select_i(Branch_o & zero_o),
        .data_o(pc_number_in)
        );

endmodule



