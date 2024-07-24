// Quartus Prime Verilog Template
// True Dual Port RAM with single clock
//
// Read-during-write behavior is undefined for mixed ports 
// and "new data" on the same port

module dpram
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
   input [31:0] data_a, data_b,
   input [31:0] addr_a, addr_b,
   input we_a, we_b, clk,
   output reg [31:0] q_a, q_b
);

   // Declare the RAM variable
reg [7:0] ram[127:0];

  initial begin
    $readmemh("mem_init_file.hex",ram);
  end

   // Port A (DATA MEMORY) 
   always @ (posedge clk)
   begin
      if (we_a) 
      begin
         ram[addr_a] = data_a;
      end
      q_a <= ram[addr_a];
   end 

   // Port B (INSTRUCTION MEMORY)
   always @ (posedge clk)
   begin
      if (we_b) 
      begin
         ram[addr_b] = data_b;
      end
      q_b <= ram[addr_b];
   end
endmodule