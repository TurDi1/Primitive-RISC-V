# Primitive-RISC-V

__Repository structure__

    .
    ├── adder.sv                # Adder module
    ├── adder_n_subtractor.sv   # Adderand subtractor module
    ├── alu.sv                  # ALU module
    ├── alu_decoder.sv          # ALU decoder module
    ├── ctrl_unit.sv            # Control unit module
    ├── dmem.sv                 # Data memory module
    ├── extend.sv               # Extend module
    ├── imem.sv                 # instruction memory module
    ├── main_decoder.sv         # Main decoder module
    ├── mux_param.sv            # Parametrized MUX module
    ├── pc.sv                   # Program counter module
    ├── reg_file.sv             # Register file module
    ├── riscv.sv                # Single cycle proccessor top module
    ├── riscv_tb.sv             # Testbench for single cycle proccesor riscv
    ├── tb_mach_codes.hex       # HEX-file with program for testbench
    └── README.md

----

This is example of primitive single-cycle RISC-V processor that architecture based on "Figure 7.12 Complete single-cycle processor" from book Digital Design and Computer Architecture RISC-V Edition:
![image](https://github.com/user-attachments/assets/618a5477-ddd7-4a22-80d5-e74d05265a0d)

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

* Note: at moment supported only addi, sw, lw, andi instructions