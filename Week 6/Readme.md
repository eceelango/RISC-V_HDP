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
