module dmem
#(
   parameter DATA_WIDTH  = 32,
   parameter INDEX_WIDTH = 5
)
(
   data_wr,
   addr,
   we,
   clk,
   data_rd
);
//==================================
//        PORTS DESCRIPTION
//==================================
input       [DATA_WIDTH - 1 : 0]   data_wr;
input       [ADDR_WIDTH - 1 : 0]   addr;
input                              we;
input                              clk;
output      [DATA_WIDTH - 1 : 0]   data_rd;

//==================================
//      WIRE'S, REG'S and etc
//==================================
reg [DATA_WIDTH - 1 : 0] ram [(2 ** ADDR_WIDTH) - 1 : 0];

//==================================
//          ASSIGNMENTS
//==================================
assign data_rd = ram[addr];

//==================================
//              Logic
//==================================
always @ (posedge clk)
begin
   if (we) 
   begin
      ram[addr] <= data_wr;
   end
end
endmodule 