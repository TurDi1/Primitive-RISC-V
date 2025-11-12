/* Single clock RISC-V CPU top module */
module RV32
#(
   parameter WIDTH        = 32,
   parameter NUM_OF_WORDS = 32
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
//==================================
//        PORTS DESCRIPTION
//==================================
input                    clk_i;         // System clock input
input                    rst_i;         // System reset input

output  [WIDTH - 1 : 0]  instr_addr_o;  // Instruction address bus
input   [WIDTH - 1 : 0]  instr_data_i;  // Instruction data bus

output                   mem_we_o;      // Memory write strobe
output  [WIDTH - 1 : 0]  mem_addr_o;    // Memory address bus
input   [WIDTH - 1 : 0]  mem_data_i;    // Read memory data bus
output  [WIDTH - 1 : 0]  mem_data_o;    // Write memory data bus

//==================================
//      WIRE'S, REG'S and etc
//==================================
// Program counter module wire's
wire   [WIDTH - 1 : 0]  pc_next_wire;
wire   [WIDTH - 1 : 0]  pc_wire;
wire                    PCSrc_wire;
// ALU module wire's
wire   [WIDTH - 1 : 0]  SrcB_wire;
wire   [WIDTH - 1 : 0]  ALUResult_wire;

// Adder pc plus four module wire's
wire   [WIDTH - 1 : 0]  PCPlus4_wire;

// Extend module wire's
wire   [WIDTH - 1 : 0]  ImmExt_wire;

// Adder PCTarget module wire's
wire   [WIDTH - 1 : 0]  PCTarget_wire;

// Register file module wire's
wire   [WIDTH - 1 : 0]  rd1_wire;
wire   [WIDTH - 1 : 0]  rd2_wire;

// Control unit module wire's
wire   [1:0]       ImmSrc_wire;
wire               RegWrite_wire;
wire               MemWrite_wire;
wire               ALUSrc_wire;
wire   [2:0]       ALUControl_wire;
wire               Zero_wire;
wire               ResultSrc_wire;

// Others's wire's
wire   [WIDTH - 1 : 0]  Result_wire;

wire   [WIDTH - 1 : 0]  pc_mux_input_wire [1:0];
wire   [WIDTH - 1 : 0]  alusrc_mux_input_wire [1:0];
wire   [WIDTH - 1 : 0]  resultsrc_mux_input_wire [1:0];

//==================================
//           ASSIGNMENTS
//==================================
assign instr_addr_o                 = pc_wire;        // address bus for instruction memory
assign mem_data_o                   = rd2_wire;       // assign to data output memory bus
assign mem_addr_o                   = ALUResult_wire; // assign to address output memory bus 
assign mem_we_o                     = MemWrite_wire;  // assign to write enable output signal from ctrl unit

assign pc_mux_input_wire[0]         = PCPlus4_wire;
assign pc_mux_input_wire[1]         = PCTarget_wire;
 
assign alusrc_mux_input_wire[0]     = rd2_wire;
assign alusrc_mux_input_wire[1]     = ImmExt_wire;

assign resultsrc_mux_input_wire[0]  = ALUResult_wire;
assign resultsrc_mux_input_wire[1]  = mem_data_i;

//==================================
//          INSTATIATIONS
//==================================
// MUX'es
mux_param #(
   .N       ( 2 ),
   .WIDTH   ( WIDTH )
) pc_mux (
   .i       ( pc_mux_input_wire ),
   .s       ( PCSrc_wire ),
   .f       ( pc_next_wire )
);

mux_param #(
   .N       ( 2 ),
   .WIDTH   ( WIDTH )
) alusrc (
   .i       ( alusrc_mux_input_wire ),
   .s       ( ALUSrc_wire ),
   .f       ( SrcB_wire )
);

mux_param #(
   .N       ( 2 ),
   .WIDTH   ( WIDTH )
) resultsrc (
   .i       ( resultsrc_mux_input_wire ),
   .s       ( ResultSrc_wire ),
   .f       ( Result_wire )
);

// Point counter
pc #(
   .WIDTH      ( WIDTH )
) program_cntr (
   .rst        ( rst_i ),
   .clk        ( clk_i ),
   .en         ( 1'b1 ),         // Forever enable
   .pc         ( pc_wire ),
   .pc_next    ( pc_next_wire )
);

// Adders
adder #(
   .WIDTH      ( WIDTH )
) pc_plus_four (
   .a          ( pc_wire ),
   .b          ( 32'd4 ),
   .s          ( PCPlus4_wire )
);

adder #(
   .WIDTH   ( WIDTH )
) pc_target (
   .a       ( pc_wire ),
   .b       ( ImmExt_wire ),
   .s       ( PCTarget_wire )
);

// Extend module
extend extnd(
   .instr   ( instr_data_i[31:7] ),
   .immsrc  ( ImmSrc_wire ),
   .immext  ( ImmExt_wire )
);

// Register file module
reg_file #(
   .N       ( NUM_OF_WORDS ),
   .WIDTH   ( WIDTH )
) register_file (
   .clk     ( clk_i ),
   .we3     ( RegWrite_wire ),
   .a1      ( instr_data_i[19:15] ),
   .a2      ( instr_data_i[24:20] ),
   .a3      ( instr_data_i[11:7] ),
   .wd3     ( Result_wire ),
   .rd1     ( rd1_wire ),
   .rd2     ( rd2_wire )
);

// ALU module
ALU #(
   .WIDTH      ( WIDTH )
) alu (
   .a          ( rd1_wire ),
   .b          ( SrcB_wire ),
   .alucontrol ( ALUControl_wire ),
   .result     ( ALUResult_wire ),
   .zero       ( Zero_wire )
);

// Control unit module
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