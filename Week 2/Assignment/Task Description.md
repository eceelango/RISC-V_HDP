## Assignment
+ Verify all the c code (counter, matrix multiplication, ALU code using RISC-V compiler and spike output.
+ Measure CPU performance of all the programs mentioned above using either godbolt or RISC-V disassembler.
## Assignment 1
+ Verify all the c code (counter, matrix multiplication, ALU code using RISC-V compiler and spike output.
  ### Commands
  ```
  riscv64-unknown-elf-gcc -march=rv64i -mabi=lp64 -ffreestanding -o ./Counter.o Counter.c
  spike pk Counter.o
  
  ```
## Code for Counter.C
```
#include <stdio.h>
#include <time.h>

void delay(int n) {
    int us = n; // microseconds
    clock_t start_time = clock();
    while (clock() < start_time + (us * CLOCKS_PER_SEC / 1000000));
}

void display(int count) // Function to display the data on the four Led's
{
	printf("Count value is: %d\n", count);						
}

int main()
{
	int count = 0x00000000;
	while (1)
	{
		display(count);
		count++;
        if(count==16){
            count=0;
        }
		delay(500000);   // delay by 0.5 microseconds
	}
}
```
### Spike Simulation
![Spike Simulation Counter](https://github.com/eceelango/RISC-V_HDP/assets/65966247/1e997a6e-569e-453b-b0b3-f04ef53ef557)

## Code for Matrix Multiplication.C
```
// C program to multiply two matrices

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Edit MACROs here, according to your Matrix Dimensions for
// mat1[R1][C1] and mat2[R2][C2]
#define R1 2 // number of rows in Matrix-1
#define C1 2 // number of columns in Matrix-1
#define R2 2 // number of rows in Matrix-2
#define C2 2 // number of columns in Matrix-2

void mulMat(int mat1[][C1], int mat2[][C2])
{
	int rslt[R1][C2];

	printf("Multiplication of given two matrices is:\n");

    clock_t start_time, end_time;

    start_time = clock() ; 

	for (int i = 0; i < R1; i++) {
		for (int j = 0; j < C2; j++) {
			rslt[i][j] = 0;

			for (int k = 0; k < R2; k++) {
				rslt[i][j] += mat1[i][k] * mat2[k][j];
			}

			printf("%d\t", rslt[i][j]);
		}

		printf("\n");
	}

    end_time = clock() ; 
    printf("Total time taken in seconds %d:\n", end_time - start_time);

}

// Driver code
int main()
{
	// R1 = 4, C1 = 4 and R2 = 4, C2 = 4 (Update these
	// values in MACROs)
	int mat1[R1][C1] = { { 1, 1 },
						{ 2, 2 } };

	int mat2[R2][C2] = { { 1, 1 },
						{ 2, 2 } };


	if (C1 != R2) {
		printf("The number of columns in Matrix-1 must be "
			"equal to the number of rows in "
			"Matrix-2\n");
		printf("Please update MACROs value according to "
			"your array dimension in "
			"#define section\n");

		exit(EXIT_FAILURE);
	}

	// Function call
	mulMat(mat1, mat2);

	return 0;
}

```
### Spike Simulation
![Spike_Simulation_Matrixmul](https://github.com/eceelango/RISC-V_HDP/assets/65966247/ff5a954b-b23b-4d5a-b45a-da3f447ed51d)

## Code for ALU.C                        
```
#include<stdio.h>
int main() {

int a,b,result ; // introducting a,b, result as integers
char op;  // Operation
printf("Enter two numbers:"); //printing and scanning the numbers
scanf("%d %d", &a, &b);

printf("Enter the operation from ADD, SUB, MUL, DIV, OR, AND, XOR : "); //printing what operation is to be done
scanf(" %c", &op);

switch(op) {
 case '+': // Addition
   result = a + b; 
  break;
 
 case '-': // Subtraction
    result = a - b;
  break;

 case '*': // Multiplication
    result = a * b;
  break;

 case '/': // Division
    result = a / b;
  break;

 case '|': // OR
   result = a | b;
  break;

 case '&': // AND
   result = a & b;
  break;

 case '^': // XOR
   result = a ^ b;
  break;

 default: // If others, wrong operation will be generated
   printf("Wrong operation");
   return 1;
}

printf("Result is: %d", result); // Printing the result

return 0;

}
```
### Spike Simulation
![Spike Output Alu](https://github.com/eceelango/RISC-V_HDP/assets/65966247/598f3e02-8e36-499c-89e4-5a38d83b3c8c)


## Assignment 2
+ Measure CPU performance of all the programs mentioned above using either godbolt or RISC-V disassembler.

  ### Command
  ```
  riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -o ./Counter.o Counter.c
  riscv64-unknown-elf-objdump -d -r Counter.o > Counter_assembly.txt
  ```

Let us assume the number of clock cycles for the RISC-V instructions.

Instructions associated with add : 2 cycles.

Instructions associated with  mul, div, load, store, and move: 3 cycles.

Instructions associated with jump, and branch: 4 cycles.

All other Instructions: 2 cycles.

**# Counter**

**CPU performance**
```
addi	sp,sp,-32 -> 2 cycles
sd	ra,24(sp) -> 3 cycles
sd	s0,16(sp) -> 3 cycles
addi	s0,sp,32 -> 2 cycles
sw	zero,-20(s0) -> 3 cycles 
```
Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions

So, CPI will be 13 / 5 = 2.6.

Now,  CPU time = CPI x Number of instructions for a program x Clock cycle time (T)

Let's assume, T = 100ps.

So, CPU time = 2.6 x 5 x 100ps = 2600ps or 1.3ns.

**# Matrix Multiplication**

**CPU performance**
```
addi	sp,sp,-80 -> 2 cycles
sd	ra,72(sp) -> 3 cycles
sd	s0,64(sp) -> 3 cycles
addi	s0,sp,80 -> 2 cycles
sd	a0,-72(s0) -> 3 cycles
sd	a1,-80(s0) -> 3 cycles
lui	a5,%hi(.LC2) -> 3 cycles
addi	a0,a5,%lo(.LC2) -> 2 cycles
call	puts -> 2 cycles
call	clock -> 2 cycles
sd	a0,-40(s0) -> 3 cycles
sw	zero,-20(s0) -> 3 cycles
j	.L2 -> 3 cycles
```
Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions

So, CPI will be 34/ 13 = 2.615.

Now,  CPU time = CPI x Number of instructions for a program x Clock cycle time (T)

Let's assume, T = 100ps.

So, CPU time = 2.615 x 13 x 100ps = 3399ps or 3.399 ns.

**# ALU**

**CPU performance**
```
addi	sp,sp,-32 -> 2 cycles
sd	ra,24(sp)  -> 3 cycles
sd	s0,16(sp)  -> 3 cycles
addi	s0,sp,32  -> 2 cycles
lui	a5,%hi(.LC0)  -> 3 cycles
addi	a0,a5,%lo(.LC0)  -> 2 cycles
call	printf  -> 2 cycles
addi	a4,s0,-28  -> 2 cycles
addi	a5,s0,-24  -> 2 cycles
mv	a2,a4  -> 3 cycles
mv	a1,a5  -> 3 cycles
lui	a5,%hi(.LC1)  -> 3 cycles
addi	a0,a5,%lo(.LC1)  -> 2 cycles
call	scanf  -> 2 cycles
lui	a5,%hi(.LC2)  -> 3 cycles
addi	a0,a5,%lo(.LC2)  -> 2 cycles
call	printf  -> 2 cycles
addi	a5,s0,-29  -> 2 cycles
mv	a1,a5  -> 3 cycles
lui	a5,%hi(.LC3)  -> 3 cycles
addi	a0,a5,%lo(.LC3)  -> 2 cycles
call	scanf  -> 2 cycles
lbu	a5,-29(s0)  -> 3 cycles
sext.w	a5,a5  -> 2 cycles
mv	a3,a5  -> 3 cycles
li	a4,45  -> 3 cycles
beq	a3,a4,.L2  -> 4 cycles
mv	a3,a5  -> 3 cycles
li	a4,45  -> 3 cycles
bgt	a3,a4,.L3  -> 4 cycles
mv	a3,a5  -> 3 cycles
li	a4,42  -> 3 cycles
beq	a3,a4,.L4  -> 4 cycles
mv	a3,a5  -> 3 cycles
li	a4,43  -> 3 cycles
beq	a3,a4,.L5  -> 4 cycles
mv	a4,a5  -> 3 cycles
li	a5,38  -> 3 cycles
beq	a4,a5,.L6  -> 4 cycles
j	.L7  -> 3 cycles
```
Clock cycle per instruction (CPI) = Total number of clock cycles / Number of instructions

So, CPI will be 111/ 40 = 2.775.

Now,  CPU time = CPI x Number of instructions for a program x Clock cycle time (T)

Let's assume, T = 100ps.

So, CPU time = 2.775x 40 x 100ps = 11100ps or 11.10 ns.

