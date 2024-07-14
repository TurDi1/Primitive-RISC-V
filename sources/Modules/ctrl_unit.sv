module ctrl_unit 
#(
   parameter XLEN = 32
)

(
   op,
   funct3,
   funct7,
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
input  logic         funct7;
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

//=== Assignments ===
assign pcsrc = Branch_wire & zero;

//=== Instatiations ===

endmodule 