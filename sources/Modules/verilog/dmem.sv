module dmem (
   clk,
   we,
   a,
   wd,
   rd
);

input  logic          clk;
input  logic          we;
input  logic [31:0]   a;
input  logic [31:0]   wd;
output logic [31:0]   rd;

logic [31:0] ram[31:0];

assign rd = ram[a[31:2]];  // word aligned

always_ff @(posedge clk)
   if (we) ram[a[31:2]] <= wd;
endmodule 