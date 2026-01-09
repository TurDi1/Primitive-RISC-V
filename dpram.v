module dpram
#(
   parameter DATA_WIDTH = 32,
   parameter ADDR_WIDTH = 32
)
(
   data_a,
   data_b,
   addr_a,
   addr_b,
   we_a,
   we_b,
   clk,
   q_a,
   q_b
);
//==================================
//        PORTS DESCRIPTION
//==================================
input       [DATA_WIDTH - 1 : 0]   data_a;
input       [DATA_WIDTH - 1 : 0]   data_b;
input       [ADDR_WIDTH - 1 : 0]   addr_a;
input       [ADDR_WIDTH - 1 : 0]   addr_b;
input                              we_a;
input                              we_b;
input                              clk;
output reg  [DATA_WIDTH - 1 : 0]   q_a;
output reg  [DATA_WIDTH - 1 : 0]   q_b;

//==================================
//      WIRE'S, REG'S and etc
//==================================
(* ram_init_file = "tb_mach_codes.hex" *)
reg [DATA_WIDTH - 1 : 0] ram [31 : 0];

// Initialize memory with hex file. Only for simulation
initial begin
   $readmemh("tb_mach_codes.hex", ram);
end

//==================================
//              Logic
//==================================
// Port A (INSTRUCTION MEMORY) 
always @ (posedge clk)
begin
   if (we_a) 
   begin
      ram[addr_a[31:2]] = data_a;
   end
   q_a <= ram[addr_a[31:2]];
end 

// Port B (DATA MEMORY)
always @ (posedge clk)
begin
   if (we_b) 
   begin
      ram[addr_b[31:2]] = data_b;
   end
   q_b <= ram[addr_b[31:2]];
end
endmodule 