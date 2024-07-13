module mux_2_1
#(
   parameter XLEN = 32
)

(
   i0,
   i1,
   s,
   f
);

input  logic  [XLEN-1:0]  i0; // input bus 0 
input  logic  [XLEN-1:0]  i1; // input bus 1
input  logic              s;  // select input
output logic  [XLEN-1:0]  f;  // output selected bus

assign   f = (~s) ? i0 : i1; 

endmodule 