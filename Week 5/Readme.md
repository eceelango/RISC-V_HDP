# Creating Custom RISC-V Processor for Controlling the Maze
## Unique Instruction
I have run the python scripts in terminal to get the unique instruction (Reference:https://github.com/BhattSoham/RISCV-HDP/blob/main/week3/script.py). Note the .txt should on the same the folder where youa re running the script
+ python script.py (if its not supported use the below command)
+ python3 script.py
+ Number of different instructions:**15**
+ List of unique instructions:
```
addi
nop
ori
lw
bnez
srli
jal
j
mv
sw
li
andi
and
ret
blt
```
### Pesudo Instruction Equivalent Command
```
li, mv = ADDI 
j, ret = JAL 
beqz = beq  
bnez = bne

```
### RISC V Custom Core Configuration (.json)
```
{
    "ALU_dist": 3,
    "pc_bit_width":8,
    "value_bit_width":32,
    "data_mem_bit_width":8,
    "immediate":12,
    "address_size":5,
    "shamt":5,
    "instructions":{
        "LUI"   :false, 
        "AUIPC" :false,
        "JAL"   :true,  
        "JALR"  :false,
        "BEQ"   :false,
        "BNE"   :true,
        "BLT"   :true,
        "BGE"   :false,
        "BLTU"  :false,
        "BGEU"  :false,
        "LB"    :false,
        "LH"    :false,
        "LW"    :true,
        "LBU"   :false,
        "LHU"   :false,
        "SB"    :false,
        "SH"    :false,
        "SW"    :true,
        "ADDI"  :true,
        "SLTI"  :false,
        "SLTIU" :false,
        "XORI"  :false,
        "ORI"   :true,
        "ANDI"  :true,
        "SLLI"  :false,
        "SRLI"  :true,
        "SRAI"  :false,
        "ADD"   :false,
        "SUB"   :false,
        "SLL"   :false,
        "SLT"   :false,
        "SLTU"  :false,
        "XOR"   :false,
        "SRL"   :false,
        "SRA"   :false,
        "OR"    :false,
        "AND"   :true,
        "MUL"   :false,
        "MULH"  :false,
        "MULHSU":false,
        "MULHU" :false,
        "DIV"   :false,
        "DIVU"  :false,
        "REM"   :false,
        "REMU"  :false,
        "R_type":true,
        "I_type":true,
        "S_type":true,
        "B_type":true,
        "U_type":true,
        "J_type":true,
        "M_type":false 
    },
    "pipelines" :{
        "IF-ID" : true,
        "ID-ALU": false,
        "ALU-M1": false,
        "M1-M2" : true,
        "M2-WB" : true
    },
    "ASIC":false
}

```
### Uploading .json and .txt file
Upload All.json and Upload assembly.txt in the following web address, Verilog file for the Microarchitecture (RISC V) and its corresponding testbench code will be generated as .zip

http://16.16.202.21/

![Screenshot from 2024-04-09 22-45-20](https://github.com/eceelango/RISC-V_HDP/assets/65966247/5ca83750-cad3-4a13-9a46-b47b9b5c70f4)

