//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:0416315王定偉、0416005張彧豪
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);

//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
//Parameter


//Main function
always @ ( * ) begin
	case (instr_op_i)
		6'd0://R-type
			begin
				ALU_op_o = 3'b000;
				ALUSrc_o = 1'b0;
				RegWrite_o = 1'b1;
				RegDst_o = 1'b1;
				Branch_o = 1'b0;
			end
		6'd4://Branch Equal
			begin
				ALU_op_o = 3'b001;
				ALUSrc_o = 1'b0;
				RegWrite_o = 1'b0;
				RegDst_o = 1'b0;
				Branch_o = 1'b1;
			end
		6'd5://Brach not Equal
			begin
				ALU_op_o = 3'b010;
				ALUSrc_o = 1'b0;
				RegWrite_o = 1'b0;
				RegDst_o = 1'b0;
				Branch_o = 1'b1;
			end
		6'd8://Addi
			begin
				ALU_op_o = 3'b011;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 1'b0;
				Branch_o = 1'b0;
			end
		6'd15://For LUI
			begin
				ALU_op_o = 3'b100;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 1'b0;
				Branch_o = 1'b0;
			end
		6'd13://For ORI
			begin
				ALU_op_o = 3'b101;
				ALUSrc_o = 1'b1;
				RegWrite_o = 1'b1;
				RegDst_o = 1'b0;
				Branch_o = 1'b0;
			end
		default:
			begin
				{ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,Branch_o}=7'bxxxxxxx;
			end
	endcase
end
endmodule






