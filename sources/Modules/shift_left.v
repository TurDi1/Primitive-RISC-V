// Module for shift data to left
module shift_left 
#(
   parameter XLEN = 32
)

(
   a,
   y
);

input    [XLEN-1:0]    a;  // input bus with data for multiplication by 4
output   [XLEN-1:0]    y;  // data output bus with result of multiplication

assign y = { a[29:0], 2'b00 };

endmodule 