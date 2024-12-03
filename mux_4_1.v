module mux_4_1 
#(
   parameter N = 4,
   parameter XLEN = 32
)
(
   a,
   s,
   f
);
// ===== Ports description =====
input    [XLEN-1:0] a [N - 1 : 0];  // Data input bus
input    [$clog2(N) - 1 : 0]    s;  // Selector input bus
output   [XLEN-1:0]             f;  // Data output

// ===== Assignments =====
assign f = a[s];
//
endmodule 
