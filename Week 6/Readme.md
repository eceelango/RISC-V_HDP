# UART Bypass
+ In Testbench file comment all the @(posedge slow_clk);write_instruction(32'h00000000). Because, the instruction is already written in the memory when we give ASIC "false" in .json file. It is generated for FPGA platform.
+ Make sure in Processor.v under wrapper module -  **writing_inst_done=1;**
+ If we bypass UART, it will generate the VCD file is with memory of 100 MB

  ## Commands to do iverilog Simulation
```
iverilog -o maze1_v testbench1.v processor1.v
vvp maze1_v
or
./maze1_v
```
![VCD_Uartbyepass](https://github.com/eceelango/RISC-V_HDP/assets/65966247/27d7249f-79ed-4399-9ee3-69ab2fa84f7e)

+ Click on generated VCD file GTKwave will open and select the DUT and corresponding Signals to view the output

  ![GTKwave](https://github.com/eceelango/RISC-V_HDP/assets/65966247/3a3871f9-51a4-4e78-916c-096ea77a78ff)

# Synthesis
Yosys tool is used to convert the behavioural code to gate level netlist. Here we are going to use SKY130 PDK.
Comment the module definitions of both **sky130_sram_2kbyte_1rw1r_32x256_8_data and sky130_sram_2kbyte_1rw1r_32x256_8_inst.**
All required sky130 libs are kept in the current working directory, and proper instantiation name is used for SRAM from sky130 libs
If you want your nelist for FPGA platform make **writing_inst_done=1** in verilog file. Incase of ASIC, **writing_inst_done=0**
 
 ### Yosys Tool Installation

**Command**
```
sudo apt install build-essential clang bison flex libreadline-dev \
    gawk tcl-dev libffi-dev git graphviz \
    xdot pkg-config python python3 libftdi-dev \
    qt5-default python3-dev libboost-all-dev cmake libeigen3-dev
```
```
git clone https://github.com/YosysHQ/yosys yosys --depth 1
cd yosys
git fetch --unshallow
```
```
make -j$(nproc)
sudo make install
```
![Yosys Installation](https://github.com/eceelango/RISC-V_HDP/assets/65966247/83e44e0d-ed86-445c-b56b-4aae830ac165)

To invoke the yosys tool

```
yosys
```
## Synthesis Command

### Steps:

+ Read liberty file to import sky130 cells
+ Read your verilog file and generate RTLIL
+ Synthesis of the top module (wrapper)
+ Mapping yosys standard cell to sky130 lib logic cells
+ Mapping sky130 lib flip-flop cells
+ Synthesis dumping output
+ Generating Graphviz representation of the design

```
read_liberty -lib sky130_fd_sc_hd__tt_025C_1v80_256.lib
read_verilog processor.v
synth -top wrapper
abc -liberty sky130_fd_sc_hd__tt_025C_1v80_256.lib
dfflibmap -liberty sky130_fd_sc_hd__tt_025C_1v80_256.lib
write_verilog synth_gpio.v
show wrapper
```
**synth -top wrapper
**
![Synth](https://github.com/eceelango/RISC-V_HDP/assets/65966247/e0b4f093-d085-4fa0-85a6-9db41646b0b3)

Mapping yosys standard cell to sky130 lib logic cells
![abc](https://github.com/eceelango/RISC-V_HDP/assets/65966247/6bdc5586-f62f-4ac8-b1a7-d76f55876ebe)

