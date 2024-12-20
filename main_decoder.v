module main_decoder (
   op,
   branch,
   resultsrc,
   memwrite,
   alusrc,
   immsrc,
   regwrite,
   aluop,
   jump
);

input    [6:0]  op;
output          branch;
output   [1:0]  resultsrc;
output          memwrite;
output          alusrc;
output   [1:0]  immsrc;
output          regwrite;
output   [1:0]  aluop;
output          jump;

//=== Wire's, reg's and etc... ===
reg    [10:0]      control_signals;

//=== Assignments ===
assign {regwrite, immsrc, alusrc, memwrite, resultsrc, branch, aluop, jump} = control_signals;

//=== Logic section ===
always @ (*)
begin
   case(op)
      //RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump 
      7'b0000011: control_signals = 11'b1_00_1_0_01_0_00_0; // lw
      7'b0100011: control_signals = 11'b0_01_1_1_00_0_00_0; // sw
      7'b0110011: control_signals = 11'b1_xx_0_0_00_0_10_0; // R–type
      7'b0010011: control_signals = 11'b1_00_1_0_00_0_10_0; // addi, andi
      default: control_signals = 11'bx_xx_x_x_xx_x_xx_x;    // ???
   endcase
end   
endmodule 