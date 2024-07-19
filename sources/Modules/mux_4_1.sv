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

input  [XLEN-1:0]  a;
input  [XLEN-1:0]  b;
input  [XLEN-1:0]  c;
input  [XLEN-1:0]  d;
input  [1:0]       s;
output reg [XLEN-1:0]  f;

//assign f = s[1] ? (s[0] ? d : c) : (s[0] ? b : a);

always @(*)
begin
   case(s)
      2'b00: f = a;
      2'b01: f = b;
      2'b10: f = c;
      2'b11: f = d;
      default: f = 32'hxxxxxxxx;
   endcase
end
endmodule 