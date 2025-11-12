module ALU 
#(
   parameter WIDTH = 32
)
(
   a,
   b,
   alucontrol,
   result,
   zero
);
//==================================
//        PORTS DESCRIPTION
//==================================
input   [WIDTH - 1 : 0]  a;
input   [WIDTH - 1 : 0]  b;
input   [2:0]            alucontrol;
output  [WIDTH - 1 : 0]  result;
output                   zero;

//==================================
//      WIRE'S, REG'S and etc
//==================================
wire    [WIDTH - 1 : 0]  s_wire;

wire    [WIDTH - 1 : 0]  input_buses [3 : 0];
wire    [WIDTH - 1 : 0]  result_wire;

//==================================
//           ASSIGNMENTS
//==================================
// Flags and result
//assign zero         = ~|result;
assign zero           = ~|result_wire;           // NOR all bit's of result
assign result         = result_wire;

// Assign values to MUX input wire array
assign input_buses[0] = s_wire [WIDTH - 1 : 0];  // Zero and first buses are result of add_n_sub
assign input_buses[1] = s_wire [WIDTH - 1 : 0];  // 
assign input_buses[2] = a & b;                   // AND result of a & b buses
assign input_buses[3] = a | b;                   // OR result of a & b buses

//==================================
//          INSTATIATIONS
//==================================
adder_n_subtractor #(
   .WIDTH   ( WIDTH )
) add_n_sub (
   .a       ( a ),
   .b       ( b ),
   .c       ( alucontrol[0] ),
   .s       ( s_wire )
);

mux_param #(
   .N     ( 4 ),
   .WIDTH ( WIDTH )
) alu_mux (
   .i     ( input_buses ),
   .s     ( alucontrol[1:0] ),
   .f     ( result_wire )
);
endmodule 
