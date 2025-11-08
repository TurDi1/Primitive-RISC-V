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
//==================================
//        PORTS DESCRIPTION
//==================================
input                   clk;
input      [XLEN-1:0]   a;
input      [XLEN-1:0]   b;
input      [2:0]        alucontrol;
output     [XLEN-1:0]   result;
output                  zero;

//==================================
//      WIRE'S, REG'S and etc
//==================================
wire         [XLEN-1:0]  sum_out;

reg         [XLEN-1:0]  result_reg;
wire        [XLEN-1:0]  result_wire;

wire        [XLEN-1:0] mux_input [3 : 0];

//==================================
//           ASSIGNMENTS
//==================================
assign zero         = ~|result;           // NOR all bit's of result
assign result       = result_wire;

// Assign values to MUX input wire array
assign mux_input[0] = sum_out[XLEN-1:0];
assign mux_input[1] = sum_out[XLEN-1:0];
assign mux_input[2] = a & b;
assign mux_input[3] = a | b;

//==================================
//          INSTATIATIONS
//==================================
adder_n_subtractor adder_sub (
   .a       ( a[XLEN-1:0] ),
   .b       ( b[XLEN-1:0] ),
   .c       ( alucontrol[0] ),
   .s       ( sum_out[XLEN-1:0] )
);

mux_param #(.N(4)) out_mux (
   .i       ( mux_input ),
   .s       ( alucontrol[1:0] ),
   .f       ( result_wire )
);
endmodule 
