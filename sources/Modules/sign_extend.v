module sign_extend 
#(
   parameter XLEN = 32
)

(
   a,
   y
);

input    [XLEN-17:0]  a; // 16-bit base addres input bus
output   [XLEN-1:0]   y; // 32-bit sign extended address output bus

assign y = { {16{a[15]} }, a};

endmodule 