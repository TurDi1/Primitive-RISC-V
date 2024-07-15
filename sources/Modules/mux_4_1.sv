module mux_4_1 
#(
   parameter XLEN = 32
)
(
   a,
   b,
   c,
   d,
   s,
   f
);

input  logic   [XLEN-1:0]  a;
input  logic   [XLEN-1:0]  b;
input  logic   [XLEN-1:0]  c;
input  logic   [XLEN-1:0]  d;
input  logic   [1:0]       s;
output logic   [XLEN-1:0]  f;

always_comb
begin
   case(s)
      2'b00: f = a;
      2'b01: f = b;
      2'b10: f = c;
      2'b11: f = d;
   endcase
end
endmodule 