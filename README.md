# Primitive-RISC-V

---
=== SIMULATION STATUS 27.07: rewrite tb. Described testbench that now semi automated. Result of sim - success. ===
![image](https://github.com/user-attachments/assets/4a7dc289-9b42-4ee3-9122-78cd2b405734)

---
=== SIMULATION STATUS 24.07: rewrite memory. Described dual port ram. Result of sim - success. ===

Data in dual port ram on init:

![dualport_init_modelsim](https://github.com/user-attachments/assets/2573814a-8ac2-4e58-9718-9707425768c1)

---

Data in ram after run all instructions:

![dualport_after_instructions_modelsim](https://github.com/user-attachments/assets/c9b5ecf0-b02f-43bf-8b92-ca261fc35871)

---
=== SIMULATION STATUS 22.07: An attempt to rewrite the testbench to suit myself. Writing a testbench from scratch, using machine codes as a basis. Result - success. ===

---

=== SIMULATION STATUS 18.07: The first two instructions are carried out. Then an error with mem_address. ===
   Adder/subtractor  was rewrited. Corrected data from adder/subtractor corectly arrive to mux4:1, but correct value from mux output arrive to output ALU incorrect.

---

Example of primitive single clock cycle RISC-V processor.

Architecture of processor based on:
![image](https://github.com/user-attachments/assets/618a5477-ddd7-4a22-80d5-e74d05265a0d)

---

Result's of simulation base modules:
---

MUX 2:1 ![mux_2_1_waveform](https://github.com/user-attachments/assets/bcbe9de8-0c03-4c12-8f4a-a2886447684e)
---

MUX 4:1 ![mux_4_1](https://github.com/user-attachments/assets/6e767ea9-5e93-4f19-b25f-eda848b4cb44)
---

ADDER ![adder_waveform](https://github.com/user-attachments/assets/9dbab0e0-8573-4644-9e3d-23a010301310)
---

PC 
![pc_waveform](https://github.com/user-attachments/assets/34fa43cd-8d58-42e0-92d7-c28a83bac988)
---



