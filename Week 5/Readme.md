# Creating Custom RISC-V Processor for Autonomous Navigation System
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

## GPIO Configuration
### Register architecture of x30 for GPIOs

+ Input Signals - Sensor1, Sensor2, Sensor3;
+ Output Signals -  Motor1A, Motor1B, Motor2A, Motor2B;
+ Number of Register bits Required - 7
+ Register bits allocations are given below

+ x30 [2:0] is Sensor -  Sensor 1 - x30[0]; Sensor 2 - x30[1]; Sensor 3 - x30[2];   // Input - Read
+ x30 [5:4] is e1 & e2 - e1 x30 [4] ; e2 x30 [5] ;  // Output Write
+ x30 [9:8] is d1 & d2 - d1 x30 [8] ; d2 x30 [9] ;  // Output Write

 #### GPIO Configuration in Verilog File
```
    module wrapper(clk,resetn,uart_rxd,uart_rx_en,uart_rx_break,uart_rx_valid,uart_rx_data, Motor1A,Motor1B,Motor2A,Motor2B, Sensors, write_done, instructions);
    input wire [3:1] Sensors;
    output reg Motor1A,Motor1B,Motor2A,Motor2B;


    output_pins = {22'b0,top_gpio_pins[9:8], 2'b0,top_gpio_pins[5:4],1'b0,Sensors} ; 
    Motor1A= top_gpio_pins[4]; 
    Motor1B= top_gpio_pins[5]; 
    Motor2A= top_gpio_pins[8]; 
    Motor2B= top_gpio_pins[9];
```
### Do the necessary changes in the Testbench file    
## iverilog Simulation

```
iverilog -o maze_v testbench.v processor.v
vvp maze_v
or
./maze_v
```
It will generate the VCD file in the folder. Click the fiel GTK wave window will open and drag and drop the signal you may see the output
