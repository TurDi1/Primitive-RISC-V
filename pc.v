module pc
#(
   parameter WIDTH = 32
)

(
   rst,
   clk,
   en,
   pc,
   pc_next
);
//==================================
//        PORTS DESCRIPTION
//==================================
input                    rst;     // Reset input
input                    clk;     // Clock input
input                    en;      // Enable input
output  [WIDTH - 1 : 0]  pc;      // Output bus with current value of program counter 
input   [WIDTH - 1 : 0]  pc_next; // Input bus with next value of program counter

//==================================
//      WIRE'S, REG'S and etc
//==================================
reg  [WIDTH - 1 : 0]  pc_reg;  // Point counter reg

//==================================
//           ASSIGNMENTS
//==================================
assign pc = pc_reg;

//==================================
//              Logic
//==================================
always @ (posedge clk or posedge rst)
begin
   if (rst)
      pc_reg   <= 0;
   else if (en)
      pc_reg   <= pc_next;
   else
      pc_reg   <= pc_reg;
end
endmodule 