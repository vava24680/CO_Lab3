//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:0416315王定偉、0416005張彧豪
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o,
		  ALUSrc_1_o
          );

//I/O ports
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;
output ALUSrc_1_o;
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
reg ALUSrc_1_o;
//Parameter

/*ALUCtrl_o signal corresponding to What kind of operation
---------------------------------
ALUCtrl_o,operation             -
   0000  ,   AND                -
   0001  ,   OR                 -
   0010  ,   ADD                -
   0011  ,   Shift_Left         -
   0100  ,   LUI                -
   0101  ,   MUL                -
   0110  ,   SUB,BEQ            -
   0111  ,   SLT                -
   1000  ,   N/A                -
   1001  ,   N/A                -
   1010  ,   N/A                -
   1011  ,   N/A                -
   1100  ,   N/A                -
   1101  ,   N/A                -
   1110  ,   BNE                -
   1111  ,   SLTU               -
---------------------------------
*/
//Select exact operations
always @ ( * ) begin
	case(ALUOp_i)
		3'b000://R-type structure instruction
			begin
				case(funct_i)
					6'd32: {ALUSrc_1_o,ALUCtrl_o}=5'b00010;//Addition
					6'd34: {ALUSrc_1_o,ALUCtrl_o}=5'b00110;//Subtraction
					6'd36: {ALUSrc_1_o,ALUCtrl_o}=5'b00000;//AND
					6'd37: {ALUSrc_1_o,ALUCtrl_o}=5'b00001;//OR
					6'd42: {ALUSrc_1_o,ALUCtrl_o}=5'b00111;//SLT
					6'd43: {ALUSrc_1_o,ALUCtrl_o}=5'b01111; //For sltu still thinking, maybe change the 1-bit ALU turth table which is designed for slt instruction
					6'd24: {ALUSrc_1_o,ALUCtrl_o}=5'b00101;//MUL
					6'd0: {ALUSrc_1_o,ALUCtrl_o}=5'b10011;//SLL
					6'd4: {ALUSrc_1_o,ALUCtrl_o}=5'b00011;//SLLV
				endcase
			end
		3'b001://Branch
			begin
				{ALUSrc_1_o,ALUCtrl_o} = 5'b00110;
			end
		3'b010://Branch not Equal
			begin
				{ALUSrc_1_o,ALUCtrl_o} = 5'b01110;
			end
		3'b011://Addi
			begin
				{ALUSrc_1_o,ALUCtrl_o} = 5'b00010;
			end
		3'b100://LUI
			begin
				{ALUSrc_1_o,ALUCtrl_o} = 5'b00100;
			end
		3'b101://ORI
			begin
				{ALUSrc_1_o,ALUCtrl_o} = 5'b00001;
			end
		default:
			begin
				ALUCtrl_o=4'bxxxx;
			end
	endcase
end
endmodule






