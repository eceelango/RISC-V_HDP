## Designing the 4-bit ALU in Verilog:

Implement the 4-bit ALU functionality in Verilog HDL.
Define input and output ports for the ALU operations.
Write testbench code to verify the functionality of the Verilog ALU.

## alu_beh.sv

```
module ALU(
    input [3:0] a, b,
    input [2:0] op,
    output reg [3:0] result
);

always @* begin
    case (op)
        3'b000: result = a + b;
        3'b001: result = a - b;
        3'b010: result = a * b;
        3'b011: if (b != 0) result = a / b;
                else result = 4'b0000;
        3'b100: result = a | b;
        3'b101: result = a ^ b;
        default: result = 4'b0000;
    endcase
end

endmodule
```
## alu_beh_tb .sv

```
module ALU_tb();

reg [3:0] a, b;
reg [2:0]op;
wire [3:0] result; 

ALU uut (
.a(a),
.b(b),
.op(op),
.result(result)
);

initial begin
  $dumpfile("ALU.vcd");
  $dumpvars(1, ALU_tb);

a = 4'b1011; b = 4'b1001; op = 3'b000; #10;
a = 4'b1100; b = 4'b1001; op = 3'b101; #10;
a = 4'b1001; b = 4'b1101; op = 3'b010; #10;
a = 4'b1101; b = 4'b1111; op = 3'b100; #10;
end

endmodule
```
## Verifying the Verilog Code using iverilog and gtkwave:

Install iverilog and gtkwave on your Ubuntu system (instructions provided).
Compile the Verilog code using iverilog.
Simulate the compiled Verilog code using vvp.
Use gtkwave to visualize the simulation waveform and verify the functionality of the Verilog ALU.

![ver_alu_gtkwave](https://github.com/LRAJA33/RISCV-HDP/assets/105126037/b14ec1aa-fadf-4c84-ba3c-d5f83e41858e)
