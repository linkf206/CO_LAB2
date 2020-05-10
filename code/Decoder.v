//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
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
assign RegWrite_o = (instr_op_i == 'd0) | (instr_op_i == 'd8) | (instr_op_i == 'd10);
//assign ALU_op_o
assign ALUSrc_o = (instr_op_i == 'd8 | instr_op_i == 'd10)? 1 : 0;
assign RegDst_o = (instr_op_i == 'd0)? 1 : 0;
assign Branch_o = (instr_op_i == 'd4)? 1 : 0;
endmodule





                    
                    