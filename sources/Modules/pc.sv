//=== Program counter module ===
module pc
#(
   parameter XLEN = 32
)

(
   rst,
   clk,
   en,
   pc,
   pc_next
);

input  logic               rst;     // reset input
input  logic               clk;     // clock input
input  logic               en;      // enable input
output logic [XLEN-1:0]    pc;      // output bus with output value of program counter 
input  logic [XLEN-1:0]    pc_next; // input bus with next value of program counter

//=== Wire's, reg's and etc... ===
logic  [XLEN-1:0]  pc_reg;     // point counter register

//=== Assignments ===
assign pc = pc_reg;

//=== Logic section ===
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