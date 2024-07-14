module ctrl_unit 
#(
   parameter XLEN = 32
)

(
   op,
   funct3,
   funct7b5,
   zero,
   pcsrc,
   resultsrc,
   memwrite,
   alucontrol,
   alusrc,
   immsrc,
   regwrite
);

input  logic  [6:0]  op;
input  logic  [2:0]  funct3;
input  logic         funct7b5;
input  logic         zero;
output logic         pcsrc;
output logic         resultsrc;
output logic         memwrite;
output logic  [2:0]  alucontrol;
output logic         alusrc;
output logic  [1:0]  immsrc;
output logic         regwrite;

//=== Wire's, reg's and etc... ===
logic                Branch_wire;
logic         [1:0]  aluop_wire;

//=== Assignments ===
assign pcsrc = Branch_wire & zero;

//=== Instatiations ===
alu_decoder alu_dec (
   .opb5        ( op[5] ),
   .funct3      ( funct3 ),
   .funct7b5    ( funct7b5 ),
   .aluop       ( aluop_wire ),
   .alucontrol  ( alucontrol )
);


endmodule 