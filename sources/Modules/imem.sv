module imem (
   a,
   rd
);

input  logic [31:0]   a;
output logic [31:0]   rd;

logic [31:0] ram[31:0];

initial
   $readmemh("tb_mach_codes.hex",ram);

assign rd = ram[a[31:2]];  // word aligned

endmodule 