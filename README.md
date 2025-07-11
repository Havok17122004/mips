# Mini MIPS Instruction Set Architecture (ISA) Reference

This document outlines the ISA supported by the Mini MIPS processor for CS220 Assignment 8. It includes instruction types, functionality, opcodes, function codes, register mapping, control signals, and ALU operation decoding.

---

## 🧮 Arithmetic Instructions

| Instruction | Type | Opcode  | Funct   | Description                        |
|-------------|------|---------|---------|------------------------------------|
| add         | R    | 000000  | 000000  | rd = rs + rt                      |
| sub         | R    | 000000  | 000001  | rd = rs - rt                      |
| addu        | R    | 000000  | 000010  | rd = rs + rt (unsigned)           |
| subu        | R    | 000000  | 000011  | rd = rs - rt (unsigned)           |
| madd        | R    | 000000  | 000100  | HI, LO += rs * rt                 |
| maddu       | R    | 000000  | 000101  | HI, LO += rs * rt (unsigned)      |
| mul         | R    | 000000  | 000110  | HI, LO = rs * rt                  |
| and         | R    | 000000  | 000111  | rd = rs & rt                      |
| or          | R    | 000000  | 001000  | rd = rs \| rt                     |
| not         | R    | 000000  | 001001  | rd = ~rs                          |
| xor         | R    | 000000  | 001010  | rd = rs ^ rt                      |
| addi        | I    | 100001  | -       | rt = rs + immediate               |
| addiu       | I    | 100010  | -       | rt = rs + immediate (unsigned)    |
| andi        | I    | 100011  | -       | rt = rs & immediate               |
| ori         | I    | 100100  | -       | rt = rs \| immediate              |
| xori        | I    | 100101  | -       | rt = rs ^ immediate               |

---

## 🔁 Shift Instructions

| Instruction | Type | Opcode  | Funct   | Description                        |
|-------------|------|---------|---------|------------------------------------|
| sll         | R    | 000000  | 01100   | rd = rt << shamt                  |
| srl         | R    | 000000  | 01101   | rd = rt >> shamt                  |
| sla         | R    | 000000  | 01110   | rd = rt <<< shamt (same as sll)   |
| sra         | R    | 000000  | 01111   | rd = rt >>> shamt                 |

---

## 📦 Data Transfer Instructions

| Instruction | Type | Opcode  | Funct   | Description                        |
|-------------|------|---------|---------|------------------------------------|
| lw          | I    | 100110  | -       | rt = Mem[rs + immediate]           |
| sw          | I    | 100111  | -       | Mem[rs + immediate] = rt           |
| lui         | I    | 101000  | -       | rt = immediate << 16               |

---

## 🔁 Conditional Branch Instructions

| Instruction | Type | Opcode  | Description                           |
|-------------|------|---------|---------------------------------------|
| beq         | I    | 101001  | if (rs == rt) branch                  |
| bne         | I    | 101010  | if (rs != rt) branch                  |
| bgt         | I    | 101011  | if (rs > rt) branch                   |
| bgte        | I    | 101100  | if (rs >= rt) branch                  |
| ble         | I    | 101101  | if (rs < rt) branch                   |
| bleq        | I    | 101110  | if (rs <= rt) branch                  |
| bleu        | I    | 101111  | if (rs < rt) branch (unsigned)        |
| bgtu        | I    | 110000  | if (rs > rt) branch (unsigned)        |

---

## 🔁 Unconditional Branch Instructions

| Instruction | Type | Opcode  | Description                           |
|-------------|------|---------|---------------------------------------|
| j           | J    | 010001  | Jump to address                       |
| jal         | J    | 010011  | Jump and link (ra = PC + 4)           |
| jr          | R    | 010010  | funct: 000000 (Jump to rs)            |
| finish      | J    | 111111  | Program end marker                    |

---

## 🔍 Comparison Instructions

| Instruction | Type | Opcode  | Funct   | Description                        |
|-------------|------|---------|---------|------------------------------------|
| slt         | R    | 000000  | 01011   | rd = (rs < rt) ? 1 : 0            |
| slti        | I    | 110001  | -       | rt = (rs < immediate) ? 1 : 0     |
| seq         | I    | 110010  | -       | rt = (rs == immediate) ? 1 : 0    |

---

## 🧊 Floating Point Instructions (F-type)

| Instruction | Type | Opcode  | Funct   | Description                        |
|-------------|------|---------|---------|------------------------------------|
| add.s       | F    | 000001  | -       | rd = rs + rt (float)               |
| sub.s       | F    | 000010  | -       | rd = rs - rt (float)               |
| c.eq.s      | F    | 000011  | -       | cc = (rs == rt) (float compare)    |
| c.le.s      | F    | 000100  | -       | cc = (rs <= rt) (float compare)    |
| c.lt.s      | F    | 000101  | -       | cc = (rs < rt) (float compare)     |
| c.ge.s      | F    | 000110  | -       | cc = (rs >= rt) (float compare)    |
| c.gt.s      | F    | 000111  | -       | cc = (rs > rt) (float compare)     |
| mov.s       | F    | 001000  | -       | rd = rs (float move)               |
| mfc1        | F    | 001001  | -       | rd = rs (move from coprocessor)    |
| mtc1        | F    | 001010  | -       | rd = rs (move to coprocessor)      |

---

## 🛠️ Special/Uncommon Encodings

- **jr**: `opcode(6) | rs(5) | 0(15) | 0(6)` (only rs used, others zero)
- **lui**: `opcode(6) | 0(5) | rt(5) | immediate(16)` (rs always zero)
- **not**: `opcode(6) | rs(5) | 0(5) | rd(5) | 0(5) | funct(6)` (rt and shamt zero)
- **mov.s, mfc1, mtc1**: `opcode(6) | rs(5) | 0(5) | rd(5) | 0(11)` (rt zero, last 11 bits zero)
- **finish**: `opcode(6) | 0(26)` (opcode 111111, address zero)

---

## Field Widths

- **opcode**: 6 bits
- **rs, rt, rd**: 5 bits each
- **shamt**: 5 bits
- **funct**: 6 bits
- **immediate**: 16 bits
- **address**: 26 bits

---

> **Note:**  
> - F-type is a custom floating-point format in this code, not standard MIPS.  
> - All field widths are in bits.  
> - The field order and usage are based on the assembler's implementation.  
> - If an instruction is not recognized, the assembler prints:  
>   `"danger danger undefined instruction!!!!"`


---

## R-Type Function Codes

| Funct   | Instruction | Description                        |
|---------|-------------|------------------------------------|
| 000000  | add         | rd = rs + rt                       |
| 000001  | sub         | rd = rs - rt                       |
| 000010  | addu        | rd = rs + rt (unsigned)            |
| 000011  | subu        | rd = rs - rt (unsigned)            |
| 000100  | madd        | HI, LO += rs * rt                  |
| 000101  | maddu       | HI, LO += rs * rt (unsigned)       |
| 000110  | mul         | HI, LO = rs * rt                   |
| 000111  | and         | rd = rs & rt                       |
| 001000  | or          | rd = rs \| rt                      |
| 001001  | not         | rd = ~rs                           |
| 001010  | xor         | rd = rs ^ rt                       |
| 01100   | sll         | rd = rt << shamt                   |
| 01101   | srl         | rd = rt >> shamt                   |
| 01110   | sla         | rd = rt <<< shamt (same as sll)    |
| 01111   | sra         | rd = rt >>> shamt                  |
| 101010  | slt         | rd = (rs < rt) ? 1 : 0             |
| 110000  | seq         | rd = (rs == rt) ? 1 : 0            |
| 001000  | jr          | PC = rs                            |

---

## Control Unit Signal Table

| Signal           | Description                                                                                  |
|------------------|---------------------------------------------------------------------------------------------|
| AluSrc           | Selects ALU second operand: 0 = register (readdata2), 1 = sign-extended immediate           |
| FloatRegWrite    | Write enable for floating-point register file                                               |
| GeneralRegWrite  | Write enable for general-purpose register file                                              |
| MemWrite         | Write enable for data memory                                                                |
| Branch           | 1 if instruction is a branch                                                                |
| Jump             | 1 if instruction is a jump                                                                  |
| FloatEnable      | Enables output of the FPU                                                                   |
| RegDst           | 00 = rt, 01 = rd, 10 = $ra (destination register select)                                    |
| MemtoReg         | 00 = ALU output, 01 = Memory output, 10 = PC+4, 11 = immediate shifted left by 16           |
| BranchOp         | 3-bit code for branch type: 0=beq, 1=bne, 2=bgt, 3=bgte, 4=ble, 5=bleq, 6=bleu, 7=bgtu      |
| AluOp            | 4-bit code for ALU operation (see ALUOp Decoding Table)                                     |

---

### Control Signal Behavior by Opcode

| Opcode    | Instruction Type / Example | RegDst | AluSrc | MemtoReg | GeneralRegWrite | MemWrite | Branch | Jump | FloatRegWrite | FloatEnable | BranchOp | AluOp |
|-----------|---------------------------|--------|--------|----------|-----------------|----------|--------|------|---------------|-------------|----------|-------|
| 000000    | R-type                    | 01     | 0      | 00       | 1               | 0        | 0      | 0    | 0             | 0           | 000      | 0     |
| 101001    | beq                       | 01     | 0      | 00       | 0               | 0        | 1      | 0    | 0             | 0           | 000      | 4     |
| 101010    | bne                       | 01     | 0      | 00       | 0               | 0        | 1      | 0    | 0             | 0           | 001      | 4     |
| 101011    | bgt                       | 01     | 0      | 00       | 0               | 0        | 1      | 0    | 0             | 0           | 010      | 4     |
| 101100    | bgte                      | 01     | 0      | 00       | 0               | 0        | 1      | 0    | 0             | 0           | 011      | 4     |
| 101101    | ble                       | 01     | 0      | 00       | 0               | 0        | 1      | 0    | 0             | 0           | 100      | 4     |
| 101110    | bleq                      | 01     | 0      | 00       | 0               | 0        | 1      | 0    | 0             | 0           | 101      | 4     |
| 101111    | bleu                      | 01     | 0      | 00       | 0               | 0        | 1      | 0    | 0             | 0           | 110      | 5     |
| 110000    | bgtu                      | 01     | 0      | 00       | 0               | 0        | 1      | 0    | 0             | 0           | 111      | 5     |
| 100110    | lw                        | 00     | 1      | 01       | 1               | 0        | 0      | 0    | 0             | 0           | 000      | 2     |
| 100111    | sw                        | 00     | 1      | 01       | 0               | 1        | 0      | 0    | 0             | 0           | 000      | 2     |
| 010001    | j                         | 00     | 1      | 00       | 0               | 0        | 0      | 1    | 0             | 0           | 000      | X     |
| 010010    | jr                        | 00     | 1      | 00       | 0               | 0        | 1      | 1    | 0             | 0           | 000      | X     |
| 010011    | jal                       | 10     | 1      | 10       | 1               | 0        | 0      | 1    | 0             | 0           | 000      | X     |
| 100001    | addi                      | 00     | 1      | 00       | 1               | 0        | 0      | 0    | 0             | 0           | 000      | 2     |
| 100010    | addiu                     | 00     | 1      | 00       | 1               | 0        | 0      | 0    | 0             | 0           | 000      | 3     |
| 100011    | addu                      | 00     | 1      | 00       | 1               | 0        | 0      | 0    | 0             | 0           | 000      | 1     |
| 100100    | andi                      | 00     | 1      | 00       | 1               | 0        | 0      | 0    | 0             | 0           | 000      | 6     |
| 100101    | ori                       | 00     | 1      | 00       | 1               | 0        | 0      | 0    | 0             | 0           | 000      | 7     |
| 110001    | slti                      | 00     | 1      | 00       | 1               | 0        | 0      | 0    | 0             | 0           | 000      | 9     |
| 110010    | seq                       | 00     | 1      | 00       | 1               | 0        | 0      | 0    | 0             | 0           | 000      | 8     |
| 101000    | lui                       | 00     | 1      | 11       | 1               | 0        | 0      | 0    | 0             | 0           | 000      | X     |
| 000001    | add.s (float)             | 01     | 0      | 00       | 0               | 0        | 0      | 0    | 1             | 1           | 000      | 2     |
| 000010    | sub.s (float)             | 01     | 0      | 00       | 0               | 0        | 0      | 0    | 1             | 0           | 000      | 4     |
| 000011    | c.eq.s (float)            | 01     | 0      | 00       | 0               | 0        | 0      | 0    | 1             | 1           | 000      | 8     |
| 000100    | c.le.s (float)            | 01     | 0      | 00       | 0               | 0        | 0      | 0    | 1             | 1           | 000      | 13    |
| 000101    | c.lt.s (float)            | 01     | 0      | 00       | 0               | 0        | 0      | 0    | 1             | 1           | 000      | 9     |
| 000110    | c.ge.s (float)            | 01     | 0      | 00       | 0               | 0        | 0      | 0    | 1             | 1           | 000      | 11    |
| 000111    | c.gt.s (float)            | 01     | 0      | 00       | 0               | 0        | 0      | 0    | 1             | 1           | 000      | 10    |
| 001000    | mov.s (float)             | 01     | 0      | 00       | 0               | 0        | 0      | 0    | 1             | 1           | 000      | 2     |
| 001001    | mfc1                      | 01     | 0      | 00       | 1               | 0        | 0      | 0    | 0             | 1           | 000      | 2     |
| 001010    | mtc1                      | 01     | 0      | 00       | 0               | 0        | 0      | 0    | 1             | 0           | 000      | 2     |

> **Note:**  
> - All signals are set according to the opcode as shown in the always@(*) block of the ControlUnit.
> - BranchOp and AluOp values are set to select the correct branch or ALU operation.
> - FloatRegWrite and FloatEnable are used for floating-point instructions.
> - RegDst and MemtoReg are 2 bits to allow for special cases like JAL and LUI.

---

## ALUOp Decoding Table

| ALUOp Code | Operation | Used For                              |
|------------|-----------|----------------------------------------|
| 0          | RTYPE     | R-type instructions (opcode = 0)      |
| 1          | AND       | and                                   |
| 2          | ADDI      | addi                                  |
| 3          | SLT       | slti, bgt, ble, bgte, bleq            |
| 4          | SLTU      | sltu, bgtu, bleu                      |
| 6          | AND       | andi                                  |
| 7          | OR        | ori                                   |
| 8          | XOR       | xori                                  |
| 10         | SEQ       | seq                                   |
| 11         | J         | j                                     |
| 12         | JAL       | jal                                   |
| 15         | RTYPE     | R-type instructions (opcode = 0)      |

---

## ALU Control Decoding Table

| ALU_control Code | Mnemonic   | Operation                      | Source (ALUOp / funct) |
|------------------|------------|-------------------------------|------------------------|
| 0                | ALU_ADD    | ADD                           | funct = 0              |
| 1                | ALU_ADDU   | Unsigned Addition             | funct = 1              |
| 2                | ALU_SUB    | Subtraction                   | funct = 2, ALUOp=1     |
| 3                | ALU_SUBU   | Unsigned subtraction          | funct = 3              |
| 4                | ALU_AND    | Bitwise and                   | funct = 7              |
| 5                | ALU_OR     | Bitwise or                    | funct = 8              |
| 6                | ALU_NOT    | Logical not                   | funct = 9              |
| 7                | ALU_XOR    | Bitwise xor                   | funct = 10             |
| 8                | ALU_SLL    | Logical Shift left            | funct = 12, ALUOp=8    |
| 9                | ALU_SRL    | Logical Shift Right           | funct = 13, ALUOp=9    |
| 10               | ALU_SRA    | Shift right arithmetic        | funct = 15, ALUOp=10   |
| 11               | ALU_SLT    | Set less than                 | funct = 11, ALUOp=11   |
| 12               | ALU_SEQ    | Set on equal                  | funct = 48             |
| 13               | ALU_MUL    | Multiplication                | funct = 6              |
| 14               | ALU_MADD   | Multiply-Add Signed           | funct = 4              |
| 15               | ALU_MADDU  | Multiply-Add Unsigned         | funct = 5              |

---

## ✅ Notes

- All unused opcodes and funct values should be treated as *NOP or invalid*.
- *Jump target* = {PC+4[31:28], address, 2'b00}
- Immediate values are *sign-extended* where needed.
- The processor supports both general-purpose and floating-point register files.
- The ALU supports HI/LO registers for multiply and multiply-add instructions.
- Shift instructions use the `shift` signal to select between shamt and register operands.
- Floating-point instructions are handled by a dedicated FPU module and controlled via `FloatEnable`