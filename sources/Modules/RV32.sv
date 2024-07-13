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
input  logic             clk_i;         // Clock input
input  logic             rst_i;         // Reset input

output logic [XLEN-1:0]  instr_iaddr_o; // 32-bit instruction address
input  logic [XLEN-1:0]  instr_data_i;  // 32-bit instruction data

output logic             mem_we_o;      // Memory write strobe
output logic [XLEN-1:0]  mem_addr_o;    // 32-bit memory address
input  logic [XLEN-1:0]  mem_data_i;    // 32-bit read memory data
output logic [XLEN-1:0]  mem_data_o;    // 32-bit write memory data

//=== Wire's, reg's and etc... ===
// wire's for program counter
logic   [XLEN-1:0]  pc_next_wire;
logic   [XLEN-1:0]  pc_wire;
logic               PCSrc_wire;

// ALU wire's


// Adder pc plus four wire's
logic   [XLEN-1:0]  PCPlus4_wire;

// Extend module wire's
logic   [1:0]       ImmSrc_wire;
logic   [XLEN-1:0]  ImmExt_wire;

// Adder PCTarget module wire's
logic   [XLEN-1:0]  PCTarget_wire;

// Register file module wire's
logic   [XLEN-1:0]  rd1_wire;
logic   [XLEN-1:0]  rd2_wire;

// Control unit wire's


//=== Assignments ===
assign instr_iaddr_o = pc_wire;        // address bus for instruction memory
 

//=== Logic section ===
//

//=== Instatiations ===
mux_2_1 pc_mux (
   .i0      ( PCPlus4_wire ),
   .i1      ( PCTarget_wire ),
   .s       ( PCSrc_wire ),
   .f       ( pc_next_wire )
);

pc program_cntr (
   .rst     ( rst_i ),
   .clk     ( clk_i ),
   .en      ( 1'b1 ),
   .pc      ( pc_wire ),
   .pc_next ( pc_next_wire )
);

adder pc_plus_four (
   .a       ( pc_wire ),
   .b       ( 32'd4 ),
   .s       ( PCPlus4_wire )
);

adder pc_target (
   .a       ( pc_wire ),
   .b       ( ImmExt_wire ),
   .s       ( PCTarget_wire )
);

extend extnd(
   instr    ( instr_data_i[31:7] ),
   immsrc   ( ImmSrc_wire ),
   immext   ( ImmExt_wire )
);

reg_file register_file (
   .clk     ( clk_i ),
   .we3     (  ),
   .a1      (  ),
   .a2      (  ),
   .a3      (  ),
   .wd3     (  ),
   .rd1     (  ),
   .rd2     (  )
);

endmodule 