module adder 
#(
   parameter WIDTH = 32
)
(
   a,
   b,
   s
);
//==================================
//        PORTS DESCRIPTION
//==================================
input   [WIDTH - 1 : 0]  a; // first number input bus
input   [WIDTH - 1 : 0]  b; // second number input bus
output  [WIDTH - 1 : 0]  s; // sum of two numbers output bus

//==================================
//           ASSIGNMENTS
//==================================
assign s = a + b;
endmodule 