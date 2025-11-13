module riscv_top #(
   parameter WIDTH        = 32
)
(
   rst,
   clk,
   instr_addr,
   instr_data
);
//==================================
//        PORTS DESCRIPTION
//==================================
input                      clk;        // System clock input
input                      rst;        // System reset input
output  [0 : 0]            instr_addr; // Instruction address bus
output  [0 : 0]            instr_data; // instruction data bus

//==================================
//      WIRE'S, REG'S and etc
//==================================
(* keep *) wire    [WIDTH - 1 : 0]    instr_addr_wire;
(* keep *) wire    [WIDTH - 1 : 0]    instr_data_wire;

wire                       we_wire;

wire    [WIDTH - 1 : 0]    mem_addr_o_wire;
wire    [WIDTH - 1 : 0]    mem_data_i_wire;
wire    [WIDTH - 1 : 0]    mem_data_o_wire;

//==================================
//           ASSIGNMENTS
//==================================
assign instr_addr = instr_addr_wire[0];
assign instr_data = instr_data_wire[0];

//==================================
//          INSTATIATIONS
//==================================
RV32 #(
    .WIDTH ( WIDTH )
) riscv (
    .clk_i        ( clk ),
    .rst_i        ( ~rst ),
    .instr_addr_o ( instr_addr_wire ),
    .instr_data_i ( instr_data_wire ),
    .mem_we_o     ( we_wire ),
    .mem_addr_o   ( mem_addr_o_wire ),
    .mem_data_i   ( mem_data_i_wire ),
    .mem_data_o   ( mem_data_o_wire )
);

dpram #(
    .DATA_WIDTH ( WIDTH ),
    .ADDR_WIDTH ( WIDTH )
) dual_port_ram (
    .data_a ( 32'b0          ), // Connected to zero for read-only port
    .data_b ( mem_data_o_wire ),
    .addr_a ( instr_addr_wire ),
    .addr_b ( mem_addr_o_wire ),
    .we_a   ( 1'b0           ), // Write disabled for port A
    .we_b   ( we_wire        ),
    .clk    ( clk            ),
    .q_a    ( instr_data_wire ),
    .q_b    ( mem_data_i_wire )
);
endmodule 