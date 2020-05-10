//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
always @(funct_i, ALUOp_i) begin
	if(ALUOp_i == 'b010) begin
		case(funct_i)
			32: ALUCtrl_o <= 2;
			34: ALUCtrl_o <= 6;
			36: ALUCtrl_o <= 0;
			37: ALUCtrl_o <= 1;
			42: ALUCtrl_o <= 7;
		endcase
	end
	else if(ALUOp_i == 'b110)
		ALUCtrl_o <= 2;
	else if(ALUOp_i == 'b111)
		ALUCtrl_o <= 7;
	else if(ALUOp_i == 'b001)
		ALUCtrl_o <= 6;
end

endmodule     





                    
                    