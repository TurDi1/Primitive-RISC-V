`timescale 1 ns/ 1 ns

module DUT ();

wire     [31:0]   instr_addr_wire;
wire     [31:0]   instr_data_wire;

wire              we_wire;

wire     [31:0]   mem_addr_o_wire;
wire     [31:0]   mem_data_i_wire;
wire     [31:0]   mem_data_o_wire;

reg      clk;
reg      rst;

always #5
   clk <= ~clk;

initial begin
$display("=============================== Testbench started... =================================");
   clk <= 0;
   rst <= 1;
#20
   rst <= 0;
end

always @(DUT.dual_port_ram.ram[16])
begin
   $display($time," RAM[16] (0x40 address) value = '%h", DUT.dual_port_ram.ram[16]);
   if (DUT.dual_port_ram.ram[16] == 32'h00000031)
   begin
      $display("======================================================================================");
      $display("Simulation complete. Value in RAM with address 0x40 after last instruction is correct.");
      $display("======================================================================================");
      $display("======================================================================================");
      $stop;
   end
end

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