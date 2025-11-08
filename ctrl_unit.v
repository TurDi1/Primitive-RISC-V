module ctrl_unit (
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
//==================================
//        PORTS DESCRIPTION
//==================================
input    [6:0]  op;
input    [2:0]  funct3;
input           funct7b5;
input           zero;
output          pcsrc;
output          resultsrc;
output          memwrite;
output   [2:0]  alucontrol;
output          alusrc;
output   [1:0]  immsrc;
output          regwrite;

//==================================
//      WIRE'S, REG'S and etc
//==================================
wire                Branch_wire;
wire         [1:0]  aluop_wire;
wire         [1:0]  resultsrc_wire;

//==================================
//           ASSIGNMENTS
//==================================
assign pcsrc      = Branch_wire & zero;
assign resultsrc  = resultsrc_wire[0];

//==================================
//          INSTATIATIONS
//==================================
alu_decoder alu_dec (
   .opb5        ( op[5] ),
   .funct3      ( funct3 ),
   .funct7b5    ( funct7b5 ),
   .aluop       ( aluop_wire ),
   .alucontrol  ( alucontrol )
);

main_decoder main_dec (
   .op          ( op ),
   .branch      ( Branch_wire ),
   .resultsrc   ( resultsrc_wire ),
   .memwrite    ( memwrite ),
   .alusrc      ( alusrc ),
   .immsrc      ( immsrc ),
   .regwrite    ( regwrite ),
   .aluop       ( aluop_wire ),
   .jump        (  ) // not used in this version
);
endmodule 