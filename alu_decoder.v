module alu_decoder (
   opb5,
   funct3,
   funct7b5,
   aluop,
   alucontrol
);
//==================================
//        PORTS DESCRIPTION
//==================================
input              opb5;
input       [2:0]  funct3;
input              funct7b5;
input       [1:0]  aluop;
output reg  [2:0]  alucontrol;

//==================================
//      WIRE'S, REG'S and etc
//==================================
wire RtypeSub;

//==================================
//           ASSIGNMENTS
//==================================
assign RtypeSub = funct7b5 & opb5;

//==================================
//              Logic
//==================================
always @(*)
begin
   case(aluop)
      2'b00: alucontrol = 3'b000;                  // lw, sw instr
      2'b01: alucontrol = 3'b001;                  // beq
      default: case(funct3)
                  3'b000: if (RtypeSub)
                              alucontrol = 3'b001; // add
                          else
                              alucontrol = 3'b000; // sub
                  3'b010: alucontrol = 3'b101;     // slt         
                  3'b110: alucontrol = 3'b011;     // or
                  3'b111: alucontrol = 3'b010;     // and
                  default: alucontrol = 3'bxxx; 
               endcase
   endcase
end
endmodule 