module adder_n_subtractor
#(
   parameter WIDTH = 32
)
(
   a,
   b,
   c,
   s
);
//==================================
//        PORTS DESCRIPTION
//==================================
input   [WIDTH - 1 : 0]  a;   // first number input bus
input   [WIDTH - 1 : 0]  b;   // second number input bus
input                    c;   // control inputs
output  [WIDTH - 1 : 0]  s;   // output bus with result of operation

//==================================
//      WIRE'S, REG'S and etc
//==================================
reg  [WIDTH - 1 : 0]     s_reg;

//==================================
//           ASSIGNMENTS
//==================================
assign s = s_reg;

//==================================
//              Logic
//==================================
always @ (*)
begin
   case(c)
      1'b0: s_reg = a + b;
      1'b1: s_reg = b + ~a + 1;
      default: s_reg = 32'hxxxxxxxx; 
   endcase
end
endmodule 