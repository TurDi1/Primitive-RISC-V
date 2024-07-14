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

input  logic  [6:0]  op;
output logic         branch;
output logic  [1:0]  resultsrc;
output logic         memwrite;
output logic         alusrc;
output logic  [1:0]  immsrc;
output logic         regwrite;
output logic  [1:0]  aluop;
output logic         jump;

//=== Wire's, reg's and etc... ===
logic    [10:0]      control_signals;

//=== Assignments ===
assign {regwrite, immsrc, alusrc, memwrite, resultsrc, branch, aluop, jump} = control_signals;

//=== Logic section ===
always_comb
begin
   case(op)
      //RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump 
      7'b0000011: controls = 11'b1_00_1_0_01_0_00_0; // lw
      7'b0100011: controls = 11'b0_01_1_1_00_0_00_0; // sw
      7'b0110011: controls = 11'b1_xx_0_0_00_0_10_0; // R–type
      7'b0010011: controls = 11'b1_00_1_0_;
      default: controls = 11'bx_xx_x_x_xx_x_xx_x;    // ???
end

endmodule 