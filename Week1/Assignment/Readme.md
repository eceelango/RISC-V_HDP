# Assignment: Task 2 - 4-bit ALU Design and Verification
This assignment involves designing a 4-bit Arithmetic Logic Unit (ALU) in both C code and Verilog. The ALU design will be verified using gcc for the C code and iverilog along with gtkwave for the Verilog code. Below are the instructions for Installing Iverilog and gtkwave on Ubuntu:

## Installing Iverilog on Ubuntu:

Icarus Verilog (Iverilog) is an open-source simulator that supports the Verilog hardware description language (HDL) and is commonly used in small-scale projects for digital circuit design and verification.

1. Go to the official Icarus Verilog GitHub repository. Select the V12-branch and download
    https://github.com/steveicarus/iverilog/tree/v12-branch?ref=circuitcove.com

2. Open a terminal window and navigate to the directory where the zip or tarball was downloaded. Then, unpack the tarball or unzip using the following command:
   
     unzip iverilog-12-branch.zip
   
     cd iverilog-12-branch
   
3. Run the autoconf script to generate the configure file using the following command:
   
     sh ./autoconf.sh

4. Run the configure script using the following command:
   
     ./configure

5. Build Icarus Verilog using the make command:
   
      make
   
6. Install Icarus Verilog using the following command:
    
      sudo make install 

## Installing Gtkwave on Ubuntu:

gtkwave is a viewer for VCD (Value Change Dump) files which are usually created by digital circuit simulators. 

  sudo apt-get update

  sudo apt-get -y install gtkwave









