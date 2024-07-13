module adder_n_subtractor
#(
   parameter XLEN = 32
)

(
   a,
   b,
   c,
   s
);

input  logic  [XLEN-1:0]  a;     // first number input bus
input  logic  [XLEN-1:0]  b;     // second number input bus
input  logic              c;     // control input
output logic  [XLEN-1:0]  s;     // sum of two numbers output bus

always_comb
begin
   case(c)
      1'b0: s = a + b;
      1'b1: s = a - b;
   endcase
end
endmodule 