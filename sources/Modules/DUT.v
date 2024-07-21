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

imem instr_mem (
   .a    ( instr_addr_wire ),
   .rd   ( instr_data_wire )
);

dmem data_mem (
   .clk  ( clk ),
   .we   ( we_wire ),
   .a    ( mem_addr_o_wire ),
   .wd   ( mem_data_o_wire ),
   .rd   ( mem_data_i_wire )
);
endmodule 