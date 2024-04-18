# **Assembly In line Code for Maze Controller**

## C Code with inline Assembly
```
#include <stdio.h>

// Using int 0 = false, 1 = true
int Sensor1 = 0;    // Left Sensor
int Sensor2 = 0;    // Front Sensor
int Sensor3 = 0;    // Right Sensor
int Motor1A = 0;
int Motor1B = 0;
int Motor2A = 0;
int Motor2B = 0;

// Prototype function declarations
void moveForward();
void turnRight();
void turnLeft();
void goBack();
void stop();
void delay(long iterations);
void readSensors(int *Sensor1, int *Sensor2, int *Sensor3);

int main() {
    while (1) { // keep the robot running infinitely
        // Get sensor readings from user input
        printf("Enter sensor values (Sensor1 Sensor2 Sensor3): ");
        scanf("%d %d %d", &Sensor1, &Sensor2, &Sensor3);

        // Basic error checking for sensor values
        if (Sensor1 < 0 || Sensor1 > 1 || Sensor2 < 0 || Sensor2 > 1 || Sensor3 < 0 || Sensor3 > 1) {
            printf("Error: Invalid sensor values detected!\n");
            continue; // Skip this iteration
        }

        // Debug print sensor values
        printf("Sensor1: %d, Sensor2: %d, Sensor3: %d\n", Sensor1, Sensor2, Sensor3);

        if (!Sensor3) { // If the path is clear on the right (no obstacle)
            printf("Turning Right...\n");
            turnRight();
        } else if (!Sensor2) { // If the right is blocked but forward is clear (no obstacle)
            printf("Moving Forward...\n");
            moveForward();
        } else if (!Sensor1) { // If both right and forward paths are blocked, turn left (no obstacle)
            printf("Turning Left...\n");
            turnLeft();
        } else {
            // If all paths are blocked, Turn Back
            printf("Going Back...\n");
            goBack();
        }
    }
    return 0;
}

// Function to read sensor values using inline assembly
void readSensors(int *Sensor1, int *Sensor2, int *Sensor3) {
    // Inline assembly to read sensor values using x30 register
    asm volatile(
        "li x30, 0xFFFFFCC8\n\t"   // Load mask value into x30 register
        "srli %0, x30, 0\n\t"      // Shift right logical x30 by 0 to extract Sensor1
        "andi %0, %0, 1\n\t"       // andi Sensor1, Sensor1, 1
        "srli x30, x30, 1\n\t"     // Shift right logical x30 by 1 to extract Sensor2
        "andi %1, x30, 1\n\t"      // andi Sensor2, x30, 1
        "srli x30, x30, 1\n\t"     // Shift right logical x30 by 1 to extract Sensor3
        "andi %2, x30, 1\n\t"      // andi Sensor3, x30, 1
        : "=r"(*Sensor1), "=r"(*Sensor2), "=r"(*Sensor3)
        :
        : "x30"
    );
 printf("Sensor 1: %2x, Sensor 2: %2x, Sensor 3: %2x\n", Sensor1, Sensor2, Sensor3);
}



void moveForward() {
    // Debug print motor values
 printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);

    // Inline assembly for motor control logic using x30 register
    asm volatile(
        "li x30, 0xFFFFFCC8\n\t"    // Load mask value into x30 register
        "and %0, zero, x30\n\t"     // and Motor1A, zero, x30
        "ori %0, %0, 16\n\t"        // ori Motor1A, Motor1A, 16
        "li %1, 0\n\t"              // li Motor1B, zero
        "li %2, 0\n\t"              // li Motor2A, zero
        "ori %3, x30, 512\n\t"      // ori Motor2B, Motor2B, 512
        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "x30"
    );

    delay(1400);
}

void turnRight() {
    // Debug print motor values
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);

    // Inline assembly for motor control logic using x30 register
    asm volatile(
        "li x30, 0xFFFFFCC8\n\t"    // Load mask value into x30 register
        "and %0, zero, x30\n\t"     // and Motor1A, zero, x30
        "ori %0, %0, 16\n\t"        // ori Motor1A, Motor1A, 16
        "li %1, 0\n\t"              // li Motor1B, zero
        "ori %2, x30, 256\n\t"      // ori Motor2A, Motor2A, 256
        "li %3, 0\n\t"              // li Motor2B, zero
        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "x30"
    );

    delay(700);
}

void turnLeft() {
    // Debug print motor values
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);

    // Inline assembly for motor control logic using x30 register
    asm volatile(
        "li x30, 0xFFFFFCC8\n\t"    // Load mask value into x30 register
        "li %0, 0\n\t"              // li Motor1A, zero
        "ori %1, x30, 32\n\t"       // ori Motor1B, Motor1B, 32
        "li %2, 0\n\t"              // li Motor2A, zero
        "ori %3, x30, 512\n\t"      // ori Motor2B, Motor2B, 512
        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "x30"
    );

    delay(700);
}

void goBack() {
    // Debug print motor values
    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);

    // Inline assembly for motor control logic using x30 register
    asm volatile(
        "li x30, 0xFFFFFCC8\n\t"    // Load mask value into x30 register
        "and %0, zero, x30\n\t"     // and Motor1A, zero, x30
        "ori %0, %0, 16\n\t"        // ori Motor1A, Motor1A, 16
        "li %1, 0\n\t"              // li Motor1B, zero
        "ori %2, x30, 256\n\t"      // ori Motor2A, Motor2A, 256
        "li %3, 0\n\t"              // li Motor2B, zero
        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "x30"
    );

    delay(1400);
}

void delay(long iterations) {
    for (long i = 0; i < iterations; i++) {
        // Empty loop body
    }
}
```
## Assembly inline Simulation Command
**+ RISCV Compiler**
```
riscv64-unknown-elf-gcc -march=rv64i -mabi=lp64 -ffreestanding -o ./maze_assemblyinline.o maze_assemblyinline.c
spike pk maze_assemblyinline.o

```
![Assembly inline Simulation](https://github.com/eceelango/RISC-V_HDP/assets/65966247/31fbf679-80b0-4fe3-be4a-75c4d6e0232c)

## Assembly Code generation
**
Make Sure Comment all the lib, printf and Scanf functions. Code should starts with int main ()**

```
// #include <stdio.h>

// Using int 0 = false, 1 = true
int Sensor1 = 0;    // Left Sensor
int Sensor2 = 0;    // Front Sensor
int Sensor3 = 0;    // Right Sensor
int Motor1A = 0;
int Motor1B = 0;
int Motor2A = 0;
int Motor2B = 0;

// Prototype function declarations
void moveForward();
void turnRight();
void turnLeft();
void goBack();
void stop();
void delay(long iterations);
void readSensors(int *Sensor1, int *Sensor2, int *Sensor3);

int main() {
    while (1) { // keep the robot running infinitely
        // Get sensor readings from user input
    //    printf("Enter sensor values (Sensor1 Sensor2 Sensor3): ");
    //    scanf("%d %d %d", &Sensor1, &Sensor2, &Sensor3);

        // Basic error checking for sensor values
        if (Sensor1 < 0 || Sensor1 > 1 || Sensor2 < 0 || Sensor2 > 1 || Sensor3 < 0 || Sensor3 > 1) {
      //      printf("Error: Invalid sensor values detected!\n");
            continue; // Skip this iteration
        }

        // Debug print sensor values
   //     printf("Sensor1: %d, Sensor2: %d, Sensor3: %d\n", Sensor1, Sensor2, Sensor3);

        if (!Sensor3) { // If the path is clear on the right (no obstacle)
      //      printf("Turning Right...\n");
            turnRight();
        } else if (!Sensor2) { // If the right is blocked but forward is clear (no obstacle)
        //    printf("Moving Forward...\n");
            moveForward();
        } else if (!Sensor1) { // If both right and forward paths are blocked, turn left (no obstacle)
        //    printf("Turning Left...\n");
            turnLeft();
        } else {
            // If all paths are blocked, Turn Back
         //   printf("Going Back...\n");
            goBack();
        }
    }
    return 0;
}

// Function to read sensor values using inline assembly
void readSensors(int *Sensor1, int *Sensor2, int *Sensor3) {
    // Inline assembly to read sensor values using x30 register
    asm volatile(
        "li x30, 0xFFFFFCC8\n\t"   // Load mask value into x30 register
        "srli %0, x30, 0\n\t"      // Shift right logical x30 by 0 to extract Sensor1
        "andi %0, %0, 1\n\t"       // andi Sensor1, Sensor1, 1
        "srli x30, x30, 1\n\t"     // Shift right logical x30 by 1 to extract Sensor2
        "andi %1, x30, 1\n\t"      // andi Sensor2, x30, 1
        "srli x30, x30, 1\n\t"     // Shift right logical x30 by 1 to extract Sensor3
        "andi %2, x30, 1\n\t"      // andi Sensor3, x30, 1
        : "=r"(*Sensor1), "=r"(*Sensor2), "=r"(*Sensor3)
        :
        : "x30"
    );
// printf("Sensor 1: %2x, Sensor 2: %2x, Sensor 3: %2x\n", Sensor1, Sensor2, Sensor3);
}



void moveForward() {
    // Debug print motor values
// printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);

    // Inline assembly for motor control logic using x30 register
    asm volatile(
        "li x30, 0xFFFFFCC8\n\t"    // Load mask value into x30 register
        "and %0, zero, x30\n\t"     // and Motor1A, zero, x30
        "ori %0, %0, 16\n\t"        // ori Motor1A, Motor1A, 16
        "li %1, 0\n\t"              // li Motor1B, zero
        "li %2, 0\n\t"              // li Motor2A, zero
        "ori %3, x30, 512\n\t"      // ori Motor2B, Motor2B, 512
        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "x30"
    );

    delay(1400);
}

void turnRight() {
    // Debug print motor values
 //   printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);

    // Inline assembly for motor control logic using x30 register
    asm volatile(
        "li x30, 0xFFFFFCC8\n\t"    // Load mask value into x30 register
        "and %0, zero, x30\n\t"     // and Motor1A, zero, x30
        "ori %0, %0, 16\n\t"        // ori Motor1A, Motor1A, 16
        "li %1, 0\n\t"              // li Motor1B, zero
        "ori %2, x30, 256\n\t"      // ori Motor2A, Motor2A, 256
        "li %3, 0\n\t"              // li Motor2B, zero
        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "x30"
    );

    delay(700);
}

void turnLeft() {
    // Debug print motor values
//    printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);

    // Inline assembly for motor control logic using x30 register
    asm volatile(
        "li x30, 0xFFFFFCC8\n\t"    // Load mask value into x30 register
        "li %0, 0\n\t"              // li Motor1A, zero
        "ori %1, x30, 32\n\t"       // ori Motor1B, Motor1B, 32
        "li %2, 0\n\t"              // li Motor2A, zero
        "ori %3, x30, 512\n\t"      // ori Motor2B, Motor2B, 512
        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "x30"
    );

    delay(700);
}

void goBack() {
    // Debug print motor values
 //   printf("Motor1A: %2x, Motor1B: %2x, Motor2A: %2x, Motor2B: %2x\n", Motor1A, Motor1B, Motor2A, Motor2B);

    // Inline assembly for motor control logic using x30 register
    asm volatile(
        "li x30, 0xFFFFFCC8\n\t"    // Load mask value into x30 register
        "and %0, zero, x30\n\t"     // and Motor1A, zero, x30
        "ori %0, %0, 16\n\t"        // ori Motor1A, Motor1A, 16
        "li %1, 0\n\t"              // li Motor1B, zero
        "ori %2, x30, 256\n\t"      // ori Motor2A, Motor2A, 256
        "li %3, 0\n\t"              // li Motor2B, zero
        : "=r"(Motor1A), "=r"(Motor1B), "=r"(Motor2A), "=r"(Motor2B)
        :
        : "x30"
    );

    delay(1400);
}

void delay(long iterations) {
    for (long i = 0; i < iterations; i++) {
        // Empty loop body
    }
}

// Function to read sensor values

void readSensors(int *Sensor1, int *Sensor2, int *Sensor3) {
 // int Sensor1, Sensor2, Sensor3;  // read whether Sensor 1,2 and 3 Obstacle is detected or not
int mask=0xFFFFFCC8;
  asm volatile( "and x30, x30, %0\n\t"
	       "andi %1, x30, 1\n\t"
               : "=r"(Sensor1)
               : "r"(mask)
               : "x30");

  asm volatile( "and x30, x30, %0\n\t" 
                "srli x30, x30, 1\n\t"
                "andi %1, x30, 1\n\t"
               : "=r"(Sensor2)
               : "r"(mask)
               : "x30");
  
  asm volatile( "and x30, x30, %0\n\t" 
                "srli x30, x30, 2\n\t"
                "andi %1, x30, 1\n\t"
               : "=r"(Sensor3)
               : "r"(mask)
               : "x30");


}

void moveForward() {
   // printf("Moving forward\n");
int mask =0xFFFFFCC8;
 int Motor1A, Motor1B, Motor2A, Motor2B;
asm volatile(
		"and x30,x30, %0\n\t"
		"ori %1,x30, 16\n\t"
                "ori %2,x30, 0\n\t"
                "ori %3,x30, 0\n\t"
                "ori %4,x30, 512\n\t"
                :
                : "r"(mask),"r"(Motor1A), "r"(Motor1B), "r"(Motor2A), "r"(Motor2B)
		: "x30"
		);

}
void turnRight() {
   // printf("Turning right\n");

int mask =0xFFFFFCC8;
 int Motor1A, Motor1B, Motor2A, Motor2B;
asm volatile(
		"and x30,x30, %0\n\t"
		"ori %1,x30, 16\n\t"
                "ori %2,x30, 0\n\t"
                "ori %3,x30, 256\n\t"
                "ori %4,x30, 0\n\t"
                :
                : "r"(mask),"r"(Motor1A), "r"(Motor1B), "r"(Motor2A), "r"(Motor2B)
		: "x30"
		);

     delay(700);
}

void turnLeft() {
  //  printf("Turning left\n");
int mask =0xFFFFFCC8;
 int Motor1A, Motor1B, Motor2A, Motor2B;
asm volatile(
		"and x30,x30, %0\n\t"
		"ori %1,x30, 0\n\t"
                "ori %2,x30, 32\n\t"
                "ori %3,x30, 0\n\t"
                "ori %4,x30, 512\n\t"
                :
                : "r"(mask),"r"(Motor1A), "r"(Motor1B), "r"(Motor2A), "r"(Motor2B)
		: "x30"
		);

    delay(700);
}

void goBack() {
    // printf("U Turn\n");
int mask =0xFFFFFCC8;
 int Motor1A, Motor1B, Motor2A, Motor2B;
asm volatile(
		"and x30,x30, %0\n\t"
		"ori %1,x30, 16\n\t"
                "ori %2,x30, 0\n\t"
                "ori %3,x30, 256\n\t"
                "ori %4,x30, 0\n\t"
                :
                : "r"(mask),"r"(Motor1A), "r"(Motor1B), "r"(Motor2A), "r"(Motor2B)
		: "x30"
		);

    delay(1400);
}

void delay(long int iterations) {
    for(long i = 0; i < iterations; i++) {
        // Empty loop body
    }
}
```

```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o maze_assemblyinline.o maze_assemblyinline.c
riscv64-unknown-elf-objdump -d maze_assemblyinline.o | less
```
![Disassemble](https://github.com/eceelango/RISC-V_HDP/assets/65966247/2875366c-b21a-4193-a505-db790718de5e)

## Assembly.txt file generation
```
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -ffreestanding -nostdlib -o out maze_assemblyinline.c
riscv64-unknown-elf-objdump -d  -r out > maze2.txt
```
```

out:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <_start>:
   10074:	ff010113          	addi	sp,sp,-16
   10078:	00112623          	sw	ra,12(sp)
   1007c:	00812423          	sw	s0,8(sp)
   10080:	01010413          	addi	s0,sp,16
   10084:	80818613          	addi	a2,gp,-2040 # 11334 <Sensor3>
   10088:	000117b7          	lui	a5,0x11
   1008c:	33078593          	addi	a1,a5,816 # 11330 <Sensor2>
   10090:	000117b7          	lui	a5,0x11
   10094:	32c78513          	addi	a0,a5,812 # 1132c <__DATA_BEGIN__>
   10098:	098000ef          	jal	ra,10130 <readSensors>
   1009c:	000117b7          	lui	a5,0x11
   100a0:	32c7a783          	lw	a5,812(a5) # 1132c <__DATA_BEGIN__>
   100a4:	0807c263          	bltz	a5,10128 <_start+0xb4>
   100a8:	000117b7          	lui	a5,0x11
   100ac:	32c7a703          	lw	a4,812(a5) # 1132c <__DATA_BEGIN__>
   100b0:	00100793          	li	a5,1
   100b4:	06e7ca63          	blt	a5,a4,10128 <_start+0xb4>
   100b8:	000117b7          	lui	a5,0x11
   100bc:	3307a783          	lw	a5,816(a5) # 11330 <Sensor2>
   100c0:	0607c463          	bltz	a5,10128 <_start+0xb4>
   100c4:	000117b7          	lui	a5,0x11
   100c8:	3307a703          	lw	a4,816(a5) # 11330 <Sensor2>
   100cc:	00100793          	li	a5,1
   100d0:	04e7cc63          	blt	a5,a4,10128 <_start+0xb4>
   100d4:	8081a783          	lw	a5,-2040(gp) # 11334 <Sensor3>
   100d8:	0407c863          	bltz	a5,10128 <_start+0xb4>
   100dc:	8081a703          	lw	a4,-2040(gp) # 11334 <Sensor3>
   100e0:	00100793          	li	a5,1
   100e4:	04e7c263          	blt	a5,a4,10128 <_start+0xb4>
   100e8:	8081a783          	lw	a5,-2040(gp) # 11334 <Sensor3>
   100ec:	00079663          	bnez	a5,100f8 <_start+0x84>
   100f0:	104000ef          	jal	ra,101f4 <turnRight>
   100f4:	f91ff06f          	j	10084 <_start+0x10>
   100f8:	000117b7          	lui	a5,0x11
   100fc:	3307a783          	lw	a5,816(a5) # 11330 <Sensor2>
   10100:	00079663          	bnez	a5,1010c <_start+0x98>
   10104:	09c000ef          	jal	ra,101a0 <moveForward>
   10108:	f7dff06f          	j	10084 <_start+0x10>
   1010c:	000117b7          	lui	a5,0x11
   10110:	32c7a783          	lw	a5,812(a5) # 1132c <__DATA_BEGIN__>
   10114:	00079663          	bnez	a5,10120 <_start+0xac>
   10118:	130000ef          	jal	ra,10248 <turnLeft>
   1011c:	f69ff06f          	j	10084 <_start+0x10>
   10120:	178000ef          	jal	ra,10298 <goBack>
   10124:	f61ff06f          	j	10084 <_start+0x10>
   10128:	00000013          	nop
   1012c:	f59ff06f          	j	10084 <_start+0x10>

00010130 <readSensors>:
   10130:	fe010113          	addi	sp,sp,-32
   10134:	00812e23          	sw	s0,28(sp)
   10138:	02010413          	addi	s0,sp,32
   1013c:	fea42623          	sw	a0,-20(s0)
   10140:	feb42423          	sw	a1,-24(s0)
   10144:	fec42223          	sw	a2,-28(s0)
   10148:	cc800f13          	li	t5,-824
   1014c:	00007633          	and	a2,zero,zero
   10150:	000076b3          	and	a3,zero,zero
   10154:	00007733          	and	a4,zero,zero
   10158:	001f7f13          	andi	t5,t5,1
   1015c:	01e66633          	or	a2,a2,t5
   10160:	001f5f13          	srli	t5,t5,0x1
   10164:	001f7f13          	andi	t5,t5,1
   10168:	01e6e6b3          	or	a3,a3,t5
   1016c:	001f5f13          	srli	t5,t5,0x1
   10170:	001f7f13          	andi	t5,t5,1
   10174:	01e76733          	or	a4,a4,t5
   10178:	fec42783          	lw	a5,-20(s0)
   1017c:	00c7a023          	sw	a2,0(a5)
   10180:	fe842783          	lw	a5,-24(s0)
   10184:	00d7a023          	sw	a3,0(a5)
   10188:	fe442783          	lw	a5,-28(s0)
   1018c:	00e7a023          	sw	a4,0(a5)
   10190:	00000013          	nop
   10194:	01c12403          	lw	s0,28(sp)
   10198:	02010113          	addi	sp,sp,32
   1019c:	00008067          	ret

000101a0 <moveForward>:
   101a0:	ff010113          	addi	sp,sp,-16
   101a4:	00112623          	sw	ra,12(sp)
   101a8:	00812423          	sw	s0,8(sp)
   101ac:	01010413          	addi	s0,sp,16
   101b0:	cc800f13          	li	t5,-824
   101b4:	01e075b3          	and	a1,zero,t5
   101b8:	0105e593          	ori	a1,a1,16
   101bc:	00000613          	li	a2,0
   101c0:	00000693          	li	a3,0
   101c4:	200f6713          	ori	a4,t5,512
   101c8:	80b1a623          	sw	a1,-2036(gp) # 11338 <Motor1A>
   101cc:	80c1a823          	sw	a2,-2032(gp) # 1133c <Motor1B>
   101d0:	80d1aa23          	sw	a3,-2028(gp) # 11340 <Motor2A>
   101d4:	80e1ac23          	sw	a4,-2024(gp) # 11344 <Motor2B>
   101d8:	57800513          	li	a0,1400
   101dc:	110000ef          	jal	ra,102ec <delay>
   101e0:	00000013          	nop
   101e4:	00c12083          	lw	ra,12(sp)
   101e8:	00812403          	lw	s0,8(sp)
   101ec:	01010113          	addi	sp,sp,16
   101f0:	00008067          	ret

000101f4 <turnRight>:
   101f4:	ff010113          	addi	sp,sp,-16
   101f8:	00112623          	sw	ra,12(sp)
   101fc:	00812423          	sw	s0,8(sp)
   10200:	01010413          	addi	s0,sp,16
   10204:	cc800f13          	li	t5,-824
   10208:	01e075b3          	and	a1,zero,t5
   1020c:	0105e593          	ori	a1,a1,16
   10210:	00000613          	li	a2,0
   10214:	100f6693          	ori	a3,t5,256
   10218:	00000713          	li	a4,0
   1021c:	80b1a623          	sw	a1,-2036(gp) # 11338 <Motor1A>
   10220:	80c1a823          	sw	a2,-2032(gp) # 1133c <Motor1B>
   10224:	80d1aa23          	sw	a3,-2028(gp) # 11340 <Motor2A>
   10228:	80e1ac23          	sw	a4,-2024(gp) # 11344 <Motor2B>
   1022c:	2bc00513          	li	a0,700
   10230:	0bc000ef          	jal	ra,102ec <delay>
   10234:	00000013          	nop
   10238:	00c12083          	lw	ra,12(sp)
   1023c:	00812403          	lw	s0,8(sp)
   10240:	01010113          	addi	sp,sp,16
   10244:	00008067          	ret

00010248 <turnLeft>:
   10248:	ff010113          	addi	sp,sp,-16
   1024c:	00112623          	sw	ra,12(sp)
   10250:	00812423          	sw	s0,8(sp)
   10254:	01010413          	addi	s0,sp,16
   10258:	cc800f13          	li	t5,-824
   1025c:	00000593          	li	a1,0
   10260:	020f6613          	ori	a2,t5,32
   10264:	00000693          	li	a3,0
   10268:	200f6713          	ori	a4,t5,512
   1026c:	80b1a623          	sw	a1,-2036(gp) # 11338 <Motor1A>
   10270:	80c1a823          	sw	a2,-2032(gp) # 1133c <Motor1B>
   10274:	80d1aa23          	sw	a3,-2028(gp) # 11340 <Motor2A>
   10278:	80e1ac23          	sw	a4,-2024(gp) # 11344 <Motor2B>
   1027c:	2bc00513          	li	a0,700
   10280:	06c000ef          	jal	ra,102ec <delay>
   10284:	00000013          	nop
   10288:	00c12083          	lw	ra,12(sp)
   1028c:	00812403          	lw	s0,8(sp)
   10290:	01010113          	addi	sp,sp,16
   10294:	00008067          	ret

00010298 <goBack>:
   10298:	ff010113          	addi	sp,sp,-16
   1029c:	00112623          	sw	ra,12(sp)
   102a0:	00812423          	sw	s0,8(sp)
   102a4:	01010413          	addi	s0,sp,16
   102a8:	cc800f13          	li	t5,-824
   102ac:	01e075b3          	and	a1,zero,t5
   102b0:	0105e593          	ori	a1,a1,16
   102b4:	00000613          	li	a2,0
   102b8:	100f6693          	ori	a3,t5,256
   102bc:	00000713          	li	a4,0
   102c0:	80b1a623          	sw	a1,-2036(gp) # 11338 <Motor1A>
   102c4:	80c1a823          	sw	a2,-2032(gp) # 1133c <Motor1B>
   102c8:	80d1aa23          	sw	a3,-2028(gp) # 11340 <Motor2A>
   102cc:	80e1ac23          	sw	a4,-2024(gp) # 11344 <Motor2B>
   102d0:	57800513          	li	a0,1400
   102d4:	018000ef          	jal	ra,102ec <delay>
   102d8:	00000013          	nop
   102dc:	00c12083          	lw	ra,12(sp)
   102e0:	00812403          	lw	s0,8(sp)
   102e4:	01010113          	addi	sp,sp,16
   102e8:	00008067          	ret

000102ec <delay>:
   102ec:	fd010113          	addi	sp,sp,-48
   102f0:	02812623          	sw	s0,44(sp)
   102f4:	03010413          	addi	s0,sp,48
   102f8:	fca42e23          	sw	a0,-36(s0)
   102fc:	fe042623          	sw	zero,-20(s0)
   10300:	0100006f          	j	10310 <delay+0x24>
   10304:	fec42783          	lw	a5,-20(s0)
   10308:	00178793          	addi	a5,a5,1
   1030c:	fef42623          	sw	a5,-20(s0)
   10310:	fec42703          	lw	a4,-20(s0)
   10314:	fdc42783          	lw	a5,-36(s0)
   10318:	fef746e3          	blt	a4,a5,10304 <delay+0x18>
   1031c:	00000013          	nop
   10320:	02c12403          	lw	s0,44(sp)
   10324:	03010113          	addi	sp,sp,48
   10328:	00008067          	ret

```
