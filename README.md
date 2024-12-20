# 32-bit Single Cycle Microprocessor 
### Supports the following instructions
- **LDR** (Load Register)
- **STR** (Store Register)
- **ADD** (Addition)
- **SUB** (Subtraction)
- **ORR** (Logical OR)
- **AND** (Logical AND)
- **B** (Branch)

## Instruction Encoding for LDR, STR, ADD, SUB, AND, ORR, and B.
### LDR (Load Register)
| Field      | Bits     | Description                                  |
|------------|----------|-----------------------------------------------|
|  Cond      | 31:28    | Varies, defines execution condition           |
|  Op        | 27:26    |  01                                          |
|  Funct     | 25:20    | Bit[5]:  X  (don't care), Bit[0]:  1  (LDR)   |
|  Rn        | 19:16    | Base register                                |
|  Rd        | 15:12    | Destination register                         |
|  Immediate | 11:0     | Immediate offset                             |

### STR (Store Register)
| Field      | Bits     | Description                                  |
|------------|----------|-----------------------------------------------|
|  Cond      | 31:28    | Varies, defines execution condition           |
|  Op        | 27:26    |  01                                          |
|  Funct     | 25:20    | Bit[5]:  X  (don't care), Bit[0]:  0  (STR)   |
|  Rn        | 19:16    | Base register                                |
|  Rd        | 15:12    | Source register                              |
|  Immediate | 11:0     | Immediate offset                             |

## Data Processing Instructions (AND, ORR, ADD, SUB)
| **Field**  | **Bits**   | **Description**               |
|------------|------------|-------------------------------|
|  Cond      | 31:28      | Condition flags               |
|  Op        | 27:26      | Operation:  00  for Reg and Imm   |
|  Funct     | 25:20      | Bit[5]: 0 for Reg, 1 for Imm. (rest is operation dependant) |
|  Rn        | 19:16      | First source register         |
|  Rd        | 15:12      | Destination register          |
|  Rm        | 3:0        | Second source register (Reg Addr.) |
|  Imm       | 11:0 or 7:0| Immediate value (Imm Addr.)   |
#### Register Addressing 
- **Second source**: Taken from  Rm  (Instr[3:0]).
- **Control Signal**:  RegSrc  selects between  Rd  (Instr[15:12]) for STR and  Rm  for DP instructions.
- **ALU Input**:  ALUSrc  selects between  ExtImm  (for Imm Addr.) and register file for DP instructions.

#### Immediate Addressing
- **Immediate**: 8-bit (Instr[7:0]) is zero extended to 32 bits.
- **Control Signal**:  ImmSrc  selects between 8-bit (for DP) or 12-bit (for LDR/STR) zero extended immediate.
- **ALU Result**: Written back to the destination register via the multiplexer controlled by MemtoReg.

## Branch (B)
| **Field**  | **Bits**   | **Description**              |
|------------|------------|------------------------------|
|  Cond      | 31:28      | Condition flags              |
|  Op        | 27:26      | Operation:  10  for Branch   |
|          | 25:24      | Unused   |
|  Imm       | 23:0       | 24-bit signed immediate      |


## Full Datapath and Control Unit
![image](https://github.com/user-attachments/assets/6f889f18-24a4-4a62-8eea-3acc680f2390)
(made in draw.io)

## Synthesized Design
![image](https://github.com/user-attachments/assets/092edd26-5ae1-4e58-ab47-6ad8cd20813d)

## Resources
Digital Design and Computer Architecture: ARM Edition, David Harris and Sarah Harris.

