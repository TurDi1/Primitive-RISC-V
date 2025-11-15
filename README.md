# Primitive-RISC-V

__Repository structure__

    .
    ├── adder.v                 # Adder module
    ├── adder_n_subtractor.v    # Adderand subtractor module
    ├── alu.v                   # ALU module
    ├── alu_decoder.v           # ALU decoder module
    ├── ctrl_unit.v             # Control unit module
    ├── dpram.v                 # DPRAM for instruction and data memory
    ├── extend.v                # Extend module
    ├── main_decoder.v          # Main decoder module
    ├── mux_param.v             # Parametrized MUX module
    ├── pc.v                    # Program counter module
    ├── reg_file.v              # Register file module
    ├── riscv.v                 # Single cycle proccessor top module
    ├── riscv_tb.v              # Testbench for single cycle proccesor riscv
    ├── tb_mach_codes.hex       # HEX-file with program for testbench
    └── README.md

----

This is example of primitive single-cycle RISC-V processor that architecture based on "Figure 7.12 Complete single-cycle processor" from book Digital Design and Computer Architecture RISC-V Edition:
![image](https://github.com/user-attachments/assets/618a5477-ddd7-4a22-80d5-e74d05265a0d)

* Note: Two memory modules for instructions and data from Figure 7.12 replaced to DPRAM memory that contain data and instructions.

Also repository have testbench for processor. This tb check result of execution of this program on address 0x40:
```
addi x31, x0, 3
sw x31, 64(x0)
lw x1, 64(x0)
addi x2, x1, 123
addi x3, x2, 51
andi x3, x3, 63
sw x3, 64(x0)
addi x0, x0, 0
```