module mux_param
#(
   parameter N     = 2,  // Number of input buses
   parameter WIDTH = 32  // Width of buses
)
(
   i,
   s,
   f
);
//==================================
//        PORTS DESCRIPTION
//==================================
input   [WIDTH - 1 : 0]      i [N - 1 : 0];  // Data input buses
input   [$clog2(N) - 1 : 0]  s;              // Selector input bus
output  [WIDTH - 1 : 0]      f;              // Data output bus

//==================================
//           ASSIGNMENTS
//==================================
assign f = i[s];

endmodule 