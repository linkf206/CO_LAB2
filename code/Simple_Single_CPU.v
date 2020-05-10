//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [32-1:0] pc_in;
wire [32-1:0] pc_out;
wire [32-1:0] adder1_out;
wire [32-1:0] adder2_out;
wire [32-1:0] instr_out;
wire [32-1:0] extend_out;
wire [32-1:0] shift_out;
wire [32-1:0] ALU_src2;
wire [32-1:0] ALU_result;
wire [32-1:0] RSdata;
wire [32-1:0] RTdata;
wire [4:0]    RDaddr;
wire [2:0]    ALU_op;
wire [3:0]    ALUCtrl;
wire          RegDst;
wire          ALUSrc;
wire          RegWrite;
wire          Branch;
wire          zero;
wire          beq;

assign beq = Branch & zero;
//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i(rst_i),     
	    .pc_in_i(pc_in) ,   
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_out),     
	    .sum_o(adder1_out)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instr_out)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_out[20:16]),
        .data1_i(instr_out[15:11]),
        .select_i(RegDst),
        .data_o(RDaddr)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i),     
        .RSaddr_i(instr_out[25:21]),  
        .RTaddr_i(instr_out[20:16]),  
        .RDaddr_i(RDaddr),  
        .RDdata_i(ALU_result), 
        .RegWrite_i(RegWrite),
        .RSdata_o(RSdata),  
        .RTdata_o(RTdata)   
        );
	
Decoder Decoder(
        .instr_op_i(instr_out[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALU_op),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch)   
	    );

ALU_Ctrl AC(
        .funct_i(instr_out[5:0]),   
        .ALUOp_i(ALU_op),   
        .ALUCtrl_o(ALUCtrl_out) 
        );
	
Sign_Extend SE(
        .data_i(instr_out[15:0]),
        .data_o(extend_out)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RTdata),
        .data1_i(extend_out),
        .select_i(ALUSrc),
        .data_o(ALU_src2)
        );	
		
ALU ALU(
        .src1_i(RSdata),
	    .src2_i(ALU_src2),
	    .ctrl_i(ALUCtrl),
	    .result_o(ALU_result),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(adder1_out),     
	    .src2_i(shift_out),     
	    .sum_o(adder2_out)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(extend_out),
        .data_o(shift_out)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(adder1_out),
        .data1_i(adder2_out),
        .select_i(beq),
        .data_o(pc_in)
        );	

endmodule
		  


