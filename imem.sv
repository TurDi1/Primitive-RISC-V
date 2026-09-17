module imem
#(
   parameter DATA_WIDTH = 32,
   parameter ADDR_WIDTH = 5
)
(
   addr,
   data
);
//==================================
//        PORTS DESCRIPTION
//==================================
input   [ADDR_WIDTH - 1 : 0]   addr;
output  [DATA_WIDTH - 1 : 0]   data;

//==================================
//      WIRE'S, REG'S and etc
//==================================
(* ram_init_file = "tb_mach_codes.hex" *)
reg [DATA_WIDTH - 1 : 0] rom [(2 ** ADDR_WIDTH) - 1 : 0];

//==================================
//          ASSIGNMENTS
//==================================
assign data = rom[addr];

// Initialize ROM with hex file. Only for simulation
initial begin
   $readmemh("tb_mach_codes.hex", rom);
end
endmodule