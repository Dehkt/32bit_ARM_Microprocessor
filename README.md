# 32-bit ARM Microprocessor

### Design and implementation of a Single Cycle 32-bit ARM Microprocessor that supports the following instructions:
- **LDR** (Load Register)
- **STR** (Store Register)
- **ADD** (Addition)
- **SUB** (Subtraction)
- **ORR** (Logical OR)
- **AND** (Logical AND)
- **B** (Branch)

## Instruction Encoding
- Rn (Base Register) 19:16 
- Rd (Destination Register) 15:12
- Immediate 11:0 for LDR and STR, 7:0 for ALU operations.

## Datapath for LDR, STR
![image](https://github.com/user-attachments/assets/555e6c4b-3b69-4557-92b6-6741b9ab5b21)

## Synthesized Design
![image](https://github.com/user-attachments/assets/092edd26-5ae1-4e58-ab47-6ad8cd20813d)

## Resources
Digital Design and Computer Architecture: ARM Edition, David Harris and Sarah Harris.

