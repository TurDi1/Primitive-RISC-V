module mux_4_1 
#(
   parameter XLEN = 32
)
(
   i0,
   i1,
   i2,
   i3,
   s,
   f
);

input  logic   [XLEN-1:0]  i0;
input  logic   [XLEN-1:0]  i1;
input  logic   [XLEN-1:0]  i2;
input  logic   [XLEN-1:0]  i3;
input  logic   [1:0]       s;
output logic   [XLEN-1:0]  f;

always_comb
begin
   case(s)
      2'b00: f = i0;
      2'b01: f = i1;
      2'b10: f = i2;
      2'b11: f = i3;
   endcase
end
endmodule 