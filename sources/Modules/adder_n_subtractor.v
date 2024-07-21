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

input         [XLEN-1:0]  a;     // first number input bus
input         [XLEN-1:0]  b;     // second number input bus
input                     c;     // control input
output reg    [XLEN-1:0]  s;     // output bus with result of operation on two numbers

always @ (*)
begin
   case(c)
      1'b0: s = a + b;
      1'b1: s = b + ~a + 1;
      default: s = 32'hxxxxxxxx; 
   endcase
end
endmodule 