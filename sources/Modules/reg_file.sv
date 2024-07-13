module reg_file
#(
   parameter XLEN = 32
)
(
input   logic clk,            // input clock
input   logic we3,            // write enable signal to registers
input   logic [4:0] a1,       // first read address bus
input   logic [4:0] a2,       // second read address bus
input   logic [4:0] a3,       // third write address bus
input   logic [XLEN-1:0] wd3, // data bus for write to registers
output  logic [XLEN-1:0] rd1, // first data bus for read
output  logic [XLEN-1:0] rd2  // second data bus for read 
);

//=== Wire's, reg's and etc... ===
logic [31:0] x[XLEN-1:0];   // Registers

//=== Assignments ===
assign rd1 = (a1 != 0) ? x[a1] : 0;
assign rd2 = (a2 != 0) ? x[a2] : 0;

//=== Logic section ===
always_ff @(posedge clk)
if (we3) x[a3] <= wd3;

endmodule 
