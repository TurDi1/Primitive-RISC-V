`timescale 1 ns / 1 ns

module riscv_tb_beq ();
//==================================
//           PARAMETERS
//==================================
parameter CLK_WIDTH       = 10ns;  // 50 MHz. Clock width, half period.
parameter WIDTH           = 32;    // Data width
parameter IMEM_ADDR_WIDTH = 5;
parameter DMEM_ADDR_WIDTH = 5;

parameter string MEM_FILE = "tb_mach_codes_beq.hex";

parameter LAST_INSTR_ADDR = 32'h0000002C;

parameter SIGNATURE_ADDR  = 32'h00000008;
parameter PASS_SIGNATURE  = 32'h00000031;
parameter FAIL_SIGNATURE  = 32'h00000011;


int unsigned rst_time;        // Variable of time for reset
reg success;                  // Success simulation variable

//==================================
//      WIRE'S, REG'S and etc
//==================================
// System required registers
reg                                  sys_clk_reg;
reg                                  sys_rst_reg;

wire     [WIDTH - 1 : 0]             instr_addr_wire;
wire     [WIDTH - 1 : 0]             instr_data_wire;

wire                                 we_wire;
wire     [WIDTH - 1 : 0]             mem_addr_o_wire;
wire     [WIDTH - 1 : 0]             mem_data_i_wire;
wire     [WIDTH - 1 : 0]             mem_data_o_wire;


//==================================
//          SYSTEM CLOCK
//==================================
initial
begin
    sys_clk_reg = 0;

    forever
    begin
        #CLK_WIDTH sys_clk_reg = ~sys_clk_reg;
    end
end

//==================================
//      Main block of testbench
//==================================
initial
begin
    $display("-----------------------------------");
    $display("[TB INFO]  STARTING SIMULATION");
    $display("-----------------------------------");
    $display("");
    
    success = 0;
    system_reset();

    $display("-----------------------------------------------");
    $display("[TB INFO]  WAITING FOR PROGRAM EXECUTION... ");
    $display("TIME:  %t", $realtime);
    $display("-----------------------------------------------");

    fork : beq_check
    begin
        fork
            begin
                wait(instr_addr_wire == LAST_INSTR_ADDR);
                $display("-----------------------------------------------");
                $display("[TB INFO]  RISCV RECEIVED LAST INSTRUCTION... ");
                $display("TIME:  %t", $realtime);
                $display("-----------------------------------------------");
                $display("");    
            end

            begin // Waiting write transaction
                wait((we_wire == 1'b1) && (mem_addr_o_wire == SIGNATURE_ADDR) && (mem_data_o_wire == PASS_SIGNATURE));
                @(posedge sys_clk_reg);

                if((we_wire == 1'b1) && (mem_addr_o_wire == SIGNATURE_ADDR) && (mem_data_o_wire == PASS_SIGNATURE))
                begin
                    $display("------------------------------------------------------------");
                    $display("[TB INFO]  ON RISCV MEM PORTS CAPTURED RIGHT WRITE TO DMEM: ");
                    $display("[TB INFO]  mem_addr_o - %h ", mem_addr_o_wire);
                    $display("[TB INFO]  mem_data_o - %h", mem_data_o_wire);
                    $display("[TB INFO]  mem_we_o   - %h", we_wire);
                    $display("------------------------------------------------------------");
                    success = 1;
                end
            end
        join
    end

    begin // Wrong write checker
        wait((we_wire == 1'b1) && (mem_addr_o_wire == SIGNATURE_ADDR) && (mem_data_o_wire == FAIL_SIGNATURE));
        @(posedge sys_clk_reg);

        if((we_wire == 1'b1) && (mem_addr_o_wire == SIGNATURE_ADDR) && (mem_data_o_wire == FAIL_SIGNATURE))
        begin
            $display("------------------------------------------------------------");
            $display("[TB INFO]  ON RISCV MEM PORTS CAPTURED WRONG WRITE TO DMEM: ");
            $display("[TB INFO]  mem_addr_o - %h ", mem_addr_o_wire);
            $display("[TB INFO]  mem_data_o - %h", mem_data_o_wire);
            $display("[TB INFO]  mem_we_o   - %h", we_wire);
            $display("------------------------------------------------------------");
            $fatal;
        end
    end

    begin
        #1000;
        $display("---------------------------------------------------");
        $display("[TB ERROR] TIMEOUT: PROGRAM EXECUTION CHECK TIMEOUT");
        $display("TIME:  %t", $realtime);
        $display("---------------------------------------------------");
        $fatal;               
    end
    join_any
    disable beq_check;


    $display("");
    $display("====================== Results of simulation ======================");
    if (success == 1)
    begin
        $display("==              EXPECTED DMEM WRITE TRANSACTION PASSED           ==");
        $display("===================================================================");
        $display("");
        $finish;        
    end
    else
    begin
        $display("==              EXPECTED DMEM WRITE TRANSACTION FAIL            ==");
        $display("===================================================================");
        $display("");
        $fatal;
    end    
end

//==================================
//          INSTATIATIONS
//==================================
riscv #(
    .WIDTH        ( WIDTH )
) riscv_single_cycle (
    .clk_i        ( sys_clk_reg     ),
    .rst_i        ( sys_rst_reg     ),
    .instr_addr_o ( instr_addr_wire ),
    .instr_data_i ( instr_data_wire ),
    .mem_we_o     ( we_wire         ),
    .mem_addr_o   ( mem_addr_o_wire ),
    .mem_data_i   ( mem_data_i_wire ),
    .mem_data_o   ( mem_data_o_wire )
);

imem #(
    .DATA_WIDTH ( WIDTH ),
    .ADDR_WIDTH ( IMEM_ADDR_WIDTH ),
    .MEM_FILE   ( MEM_FILE )
) rom (
    .addr       ( instr_addr_wire[IMEM_ADDR_WIDTH + 1 : 2] ),
    .data       ( instr_data_wire )
);

dmem #(
   .DATA_WIDTH  ( WIDTH ),
   .INDEX_WIDTH ( DMEM_ADDR_WIDTH )
) ram (
   .data_wr    ( mem_data_o_wire ),
   .addr       ( mem_addr_o_wire[DMEM_ADDR_WIDTH + 1 : 2] ),
   .we         ( we_wire ),
   .clk        ( sys_clk_reg ),
   .data_rd    ( mem_data_i_wire )
);

//==================================
//         TESTBENCH TASKS
//==================================
task system_reset;
begin
    sys_rst_reg = 1;
    $display("----------------------------");
    $display("[TB INFO]  RESET SETTED!");
    $display("TIME:  %t", $realtime);
    $display("----------------------------");

    // Set random time in range between 20-40 ns
    rst_time = $urandom_range(20ns, 40ns);
    
    #rst_time sys_rst_reg = 0;
    $display("----------------------------");
    $display("[TB INFO]  RESET RELEASED!");
    $display("TIME:  %t", $realtime);
    $display("----------------------------");
    $display("");
end
endtask
//
endmodule 