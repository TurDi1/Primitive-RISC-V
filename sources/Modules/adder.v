module adder 
#(
   parameter XLEN = 32
)

(
   a,
   b,
   s
);

input    [XLEN-1:0]  a; // first number input bus
input    [XLEN-1:0]  b; // second number input bus
output   [XLEN-1:0]  s; // sum of two numbers output bus

assign   s = a + b;

endmodule 