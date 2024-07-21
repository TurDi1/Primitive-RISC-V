module ALU 
#(
   parameter XLEN = 32
)

(
   clk,
   a,
   b,
   alucontrol,
   result,
   zero
);

input                   clk;
input      [XLEN-1:0]   a;
input      [XLEN-1:0]   b;
input      [2:0]        alucontrol;
output     [XLEN-1:0]   result;
output                  zero;

//=== Wire's, reg's and etc... ===
wire         [XLEN-1:0]  sum_out;

reg         [XLEN-1:0]  result_reg;
wire        [XLEN-1:0]  result_wire;

//=== Assignments ===
assign zero       = ~|result;    // NOR all bit's of result

assign result     = result_reg;  // 

always @(clk or result_wire)
begin
   if (clk)
      result_reg  <= result_wire;
end

//=== Instatiations ===
adder_n_subtractor adder_sub (
   .a       ( a[XLEN-1:0] ),
   .b       ( b[XLEN-1:0] ),
   .c       ( alucontrol[0] ),
   .s       ( sum_out[XLEN-1:0] )
);

mux_4_1 out_mux (
   .a       ( sum_out[XLEN-1:0] ),
   .b       ( sum_out[XLEN-1:0] ),
   .c       ( a & b ),
   .d       ( a | b ),
   .s       ( alucontrol[1:0] ),
   .f       ( result_wire )
);
endmodule 