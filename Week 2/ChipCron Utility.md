## Steps to be followed to create a Custom core using ChipCron tool
## ChipCron tool Template
![Template](https://github.com/eceelango/RISC-V_HDP/assets/65966247/d5a3f70c-07e0-4541-9870-0043d773bf44)
## Architecture Type Selection
![Architecture Type](https://github.com/eceelango/RISC-V_HDP/assets/65966247/be58b678-f715-4022-8d91-84d461484473)

**+ After Selecting the Architecture**

  PC and IF will be enabled for the selected architecture
  ![After Architecture Type](https://github.com/eceelango/RISC-V_HDP/assets/65966247/776e5e0a-02a1-486c-9d90-d0e13ed691be)
## Instruction Selection
Among 47 instructions select the instructions which ever we want for our applications. Select the Unique Instruction from your RISC V compiler output.

![Instruction Selection](https://github.com/eceelango/RISC-V_HDP/assets/65966247/d49c5901-d99e-4ffd-b35f-ced3da397407)

**+ After Selecting the Instruction**

  Decode Stage and Execution Stage will be enabled for the selected architecture
 ![After Instruction Selection](https://github.com/eceelango/RISC-V_HDP/assets/65966247/e3a060bd-647d-427e-bc57-db775e62eea3)

## Number of Register Selection
![Number of Reg](https://github.com/eceelango/RISC-V_HDP/assets/65966247/1e104673-8c4b-4c85-8e29-05ad8788f150)

**+ After Selecting the Number of Registers**

 RegF block is enabled for the selected architecture
![RegF](https://github.com/eceelango/RISC-V_HDP/assets/65966247/45625b6c-0bfa-4ade-80a0-572a02cc923c)

## Defining Memory Size
![Memory Size](https://github.com/eceelango/RISC-V_HDP/assets/65966247/f45c6068-6cbe-4500-8230-d313e5e7e6aa)

**+ After Selecting the Memory Size**

MEM and WB block is enabled for the selected architecture
![MEM](https://github.com/eceelango/RISC-V_HDP/assets/65966247/336e73d7-a4b3-435c-a906-4bf50362057b)

## Pipelineling Stage
+ ChipCron supports 0 to 5 stages of Pipeline.

![Pipeline stage](https://github.com/eceelango/RISC-V_HDP/assets/65966247/fec4bf14-28a7-4295-b287-5457dcecdb9b)

**+ After Selecting the Pipeline Stage**

![After Pipeline](https://github.com/eceelango/RISC-V_HDP/assets/65966247/de9eb4eb-1d46-4f35-9bd7-d37b5d76e0d1)

**+ After Full Connection**

![After Pipeline Connection](https://github.com/eceelango/RISC-V_HDP/assets/65966247/1fca6672-9421-4102-9b9d-a7cf2d27002d)

+ Script based methodologies
+ Configuration file for Microarchitecture is dumped from RISCV compiler as a architecture specification

## ChipCron Optimization

**+ Design Configuration**
![Design Configuration](https://github.com/eceelango/RISC-V_HDP/assets/65966247/0027195c-b784-4c8e-83aa-b47243a8fd20)

## ChipCron file Dumping Procedure
![Chipcron Flow](https://github.com/eceelango/RISC-V_HDP/assets/65966247/3e57390e-c6b6-4db4-9e29-96d7b36cf8c9)

Instruction (JSON) Files and Assembly file(.txt) need to be give as a input to ChipCron tool , it will generate a ZIP file. The file consists of Synthesizable RTL with testbench. We can perform RTL simulation using Verilog and testbench file.
 
![RTL Code](https://github.com/eceelango/RISC-V_HDP/assets/65966247/6f8fa92d-62de-4952-8f4b-8b0516ab59d8)



