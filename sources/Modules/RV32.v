/* Single clock RISC-V CPU top module */
module RV32
#(
   parameter XLEN = 32
)

(
   clk_i,
   rst_i,
   instr_iaddr_o,
   instr_data_i,
   mem_we_o,
   mem_addr_o,
   mem_data_i,
   mem_data_o
);
input              clk_i;         // Clock input
input              rst_i;         // Reset input

output [XLEN-1:0]  instr_iaddr_o; // 32-bit instruction address
input  [XLEN-1:0]  instr_data_i;  // 32-bit instruction data

output             mem_we_o;      // Memory write strobe
output [XLEN-1:0]  mem_addr_o;    // 32-bit memory address
input  [XLEN-1:0]  mem_data_i;    // 32-bit read memory data
output [XLEN-1:0]  mem_data_o;    // 32-bit write memory data

//=== Wire's, reg's and etc... ===
// wire's for program counter
wire   [XLEN-1:0]  pc_next_wire;
wire   [XLEN-1:0]  pc_wire;
wire               PCSrc_wire;

// ALU wire's

// Adder wire's
wire   [XLEN-1:0]  PCPlus4_wire;

// Sign extend wire's
wire   [XLEN-1:0]  SignImm_wire;

// Shift left module wire's
wire   [XLEN-1:0]  shifted_data_wire;

// PCBranch module wire's
wire   [XLEN-1:0]  PCBranch_wire;

// Control unit wire's
wire               IRwrite_wire;
wire               MemWrite_wire;
wire               RegDst_wire;

wire   [XLEN-1:0]  Instr_wire;           // Instruction wire bus from instr reg

wire   [4:0]       WriteReg_wire;

//=== Assignments ===
assign instr_iaddr_o = pc_wire;        // address bus for instruction memory
 

//=== Logic section ===
//

//=== Instatiations ===
pc program_cntr (
   .rst     ( rst_i ),
   .clk     ( clk_i ),
   .en      ( 1'b1 ),
   .pc      ( pc_wire ),
   .pc_next ( pc_next_wire )
);

mux_2_1 pc_mux (
   .i0      ( PCPlus4_wire ),
   .i1      ( PCBranch_wire ),
   .s       ( PCSrc_wire ),
   .f       ( pc_next_wire )
);

adder pcplusfour (
   .a       ( pc_wire ),
   .b       ( 32'd4 ),
   .s       ( PCPlus4_wire )
);

sign_extend signextend(
   .a       ( instr_data_i[15:0] ),
   .y       ( SignImm_wire )
);

shift_left (
   .a       ( SignImm_wire ),
   .y       ( shifted_data_wire )
);

adder pcbranch (
   .a       ( shifted_data_wire ),
   .b       ( PCPlus4_wire ),
   .s       ( PCBranch_wire )
);

mux_2_1 #(.XLEN(5)) regdst (
   .i0      ( instr_data_i[20:16] ),
   .i1      ( instr_data_i[15:11] ),
   .s       ( RegDst_wire ),
   .f       ( WriteReg_wire )
);

endmodule 