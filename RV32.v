/* Single clock RISC-V CPU top module */
module RV32
#(
   parameter XLEN = 32
)

(
   clk_i,
   rst_i,
   instr_addr_o,
   instr_data_i,
   mem_we_o,
   mem_addr_o,
   mem_data_i,
   mem_data_o
);
input               clk_i;         // Clock input
input               rst_i;         // Reset input

output  [XLEN-1:0]  instr_addr_o; // 32-bit instruction address
input   [XLEN-1:0]  instr_data_i;  // 32-bit instruction data

output              mem_we_o;      // Memory write strobe
output  [XLEN-1:0]  mem_addr_o;    // 32-bit memory address
input   [XLEN-1:0]  mem_data_i;    // 32-bit read memory data
output  [XLEN-1:0]  mem_data_o;    // 32-bit write memory data

//=== Wire's, reg's and etc... ===
// wire's for program counter
wire   [XLEN-1:0]  pc_next_wire;
wire   [XLEN-1:0]  pc_wire;
wire               PCSrc_wire;

// ALU wire's
wire   [XLEN-1:0]  SrcB_wire;
wire   [XLEN-1:0]  ALUResult_wire;

// Adder pc plus four wire's
wire   [XLEN-1:0]  PCPlus4_wire;

// Extend module wire's
wire   [XLEN-1:0]  ImmExt_wire;

// Adder PCTarget module wire's
wire   [XLEN-1:0]  PCTarget_wire;

// Register file module wire's
wire   [XLEN-1:0]  rd1_wire;
wire   [XLEN-1:0]  rd2_wire;

// Control unit wire's
wire   [1:0]       ImmSrc_wire;
wire               RegWrite_wire;
wire               MemWrite_wire;
wire               ALUSrc_wire;
wire   [2:0]       ALUControl_wire;
wire               Zero_wire;
wire               ResultSrc_wire;

// Others's wire's
wire   [XLEN-1:0]  Result_wire;

//=== Assignments ===
assign instr_addr_o  = pc_wire;        // address bus for instruction memory
assign mem_data_o    = rd2_wire;       // assign to data output memory bus
assign mem_addr_o    = ALUResult_wire; // assign to address output memory bus 
assign mem_we_o      = MemWrite_wire;  // assign to write enable output signal from ctrl unit

//=== Instatiations ===
mux_2_1 pc_mux (
   .i0      ( PCPlus4_wire ),
   .i1      ( PCTarget_wire ),
   .s       ( PCSrc_wire ),
   .f       ( pc_next_wire )
);

mux_2_1 alusrc (
   .i0      ( rd2_wire ),
   .i1      ( ImmExt_wire ),
   .s       ( ALUSrc_wire ),
   .f       ( SrcB_wire )
);

mux_2_1 resultsrc (
   .i0       ( ALUResult_wire ),
   .i1       ( mem_data_i ),
   .s        ( ResultSrc_wire ),
   .f        ( Result_wire )
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
   .instr   ( instr_data_i[31:7] ),
   .immsrc  ( ImmSrc_wire ),
   .immext  ( ImmExt_wire )
);

reg_file register_file (
   .clk     ( clk_i ),
   .we3     ( RegWrite_wire ),
   .a1      ( instr_data_i[19:15] ),
   .a2      ( instr_data_i[24:20] ),
   .a3      ( instr_data_i[11:7] ),
   .wd3     ( Result_wire ),
   .rd1     ( rd1_wire ),
   .rd2     ( rd2_wire )
);

ALU alu (
   .clk           ( clk_i ),
   .a             ( rd1_wire ),
   .b             ( SrcB_wire ),
   .alucontrol    ( ALUControl_wire ),
   .result        ( ALUResult_wire ),
   .zero          ( Zero_wire )
);

ctrl_unit control_unit (
   .op          ( instr_data_i[6:0] ),
   .funct3      ( instr_data_i[14:12] ),
   .funct7b5    ( instr_data_i[30] ),
   .zero        ( Zero_wire ),
   .pcsrc       ( PCSrc_wire ),
   .resultsrc   ( ResultSrc_wire ),
   .memwrite    ( MemWrite_wire ),
   .alucontrol  ( ALUControl_wire ),
   .alusrc      ( ALUSrc_wire ),
   .immsrc      ( ImmSrc_wire ),
   .regwrite    ( RegWrite_wire )
);
endmodule 