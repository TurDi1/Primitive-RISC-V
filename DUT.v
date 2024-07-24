module DUT (
   rst,
   clk
);

input    rst;
input    clk;

wire     [31:0]   instr_addr_wire;
wire     [31:0]   instr_data_wire;

wire              we_wire;

wire     [31:0]   mem_addr_o_wire;
wire     [31:0]   mem_data_i_wire;
wire     [31:0]   mem_data_o_wire;

RV32 cpu (
   .clk_i            ( clk ),
   .rst_i            ( rst ),
   .instr_addr_o     ( instr_addr_wire ),
   .instr_data_i     ( instr_data_wire ),
   .mem_we_o         ( we_wire ),
   .mem_addr_o       ( mem_addr_o_wire ),
   .mem_data_i       ( mem_data_i_wire ),
   .mem_data_o       ( mem_data_o_wire )
);

dpram dual_port_ram (
   .data_a     (  ), 
   .data_b     ( mem_data_o_wire ),
   .addr_a     ( instr_addr_wire ),
   .addr_b     ( mem_addr_o_wire ),
   .we_a       ( 1'b0 ), 
   .we_b       ( we_wire ),
   .clk        ( clk ),
   .q_a        ( instr_data_wire ), 
   .q_b        ( mem_data_i_wire )
);
endmodule 