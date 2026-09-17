module reg_file
#(
   parameter WIDTH = 32   // Width of registers
)
(
   clk,
   we3,
   a1,
   a2,
   a3,
   wd3,
   rd1,
   rd2
);
//==================================
//        PORTS DESCRIPTION
//==================================
input                         clk;  // Clock input
input                         we3;  // Write enable input
input   [$clog2(32) - 1 : 0]   a1;  // First read address bus
input   [$clog2(32) - 1 : 0]   a2;  // Second read address bus
input   [$clog2(32) - 1 : 0]   a3;  // Third write address bus
input   [WIDTH - 1 : 0]       wd3;  // Bus with data for write
output  [WIDTH - 1 : 0]       rd1;  // First bus with data for read
output  [WIDTH - 1 : 0]       rd2;  // Second bus with data for read

//==================================
//      WIRE'S, REG'S and etc
//==================================
reg [WIDTH - 1 : 0] x [31 : 0];  // Registers

//==================================
//           ASSIGNMENTS
//==================================
assign rd1 = (a1 != 0) ? x[a1] : 0;
assign rd2 = (a2 != 0) ? x[a2] : 0;

//==================================
//              Logic
//==================================
always @(posedge clk)
   if (we3) 
      x[a3] <= wd3;
endmodule 
