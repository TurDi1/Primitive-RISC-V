module ALU 
#(
   parameter XLEN = 32
)

(
   a,
   b,
   alucontrol,
   result,
   zero
);

input  logic  [XLEN-1:0]   a;
input  logic  [XLEN-1:0]   b;
input  logic  [2:0]        alucontrol;
output logic  [XLEN-1:0]   result;
output logic               zero;

//=== Wire's, reg's and etc... ===
logic         [XLEN-1:0]   inv_b;
logic         [XLEN-1:0]   b_mux_out;
logic         [XLEN-1:0]   and_wire;
logic         [XLEN-1:0]   or_wire;

logic         [XLEN-1:0]   sum_out;

logic         [XLEN-1:0]   result_wire;

//=== Assignments ===
assign and_wire   = a & b;
assign or_wire    = a | b;

assign inv_b      = ~b;             // inverting of b number
assign zero       = ~|result_wire;  // NOR all bit's of result
assign result     = result_wire;

//=== Instatiations ===
mux_2_1 b_mux (
   .i0       ( b ),
   .i1       ( inv_b ),
   .s        ( alucontrol[0] ),
   .f        ( b_mux_out )
);

adder_n_subtractor adder_sub (
   .a        ( a ),
   .b        ( b_mux_out ),
   .c        ( alucontrol[0] ),
   .s        ( sum_out )
);

mux_4_1 out_mux (
   .a       ( sum_out ),
   .b       ( sum_out ),
   .c       ( and_wire ),
   .d       ( or_wire ),
   .s        ( alucontrol[1:0] ),
   .f        ( result_wire )
);
endmodule 