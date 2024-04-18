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
//#include <stdio.h>

// Using int 0 = false, 1 = true
int Sensor1 = 0;    // Left Sensor
int Sensor2 = 0;    // Front Sensor
int Sensor3 = 0;    // Right Sensor
int Motor1A=0;
int Motor1B=0;
int Motor2A=0;
int Motor2B=0;

// Prototype function declarations
void moveForward();
void turnRight();
void turnLeft();
void goBack();
void stop();
void delay(long iterations);
void readSensors(int *Sensor1, int *Sensor2, int *Sensor3);

int main() {
    while (1) { // keep the robot running infintely
int Sensor1, Sensor2, Sensor3;
        readSensors(&Sensor1, &Sensor2, &Sensor3); // Update sensor readings
        if (!Sensor3) { // If the path is clear on the right (no obstacle)
            turnRight();
         
        } else if (!Sensor2) { // If the right is blocked but forward is clear (no obstacle)
            moveForward();
        } else if (!Sensor1) { // If both right and forward paths are blocked, turn left (no obstacle)
            turnLeft();
              } else {
            // If all paths are blocked, Turn Back
            goBack();
            }
    }
    return 0;
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
riscv64-unknown-elf-objdump -d  -r out > maze1.txt
```
```
out:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <main>:
   10074:	fe010113          	addi	sp,sp,-32
   10078:	00112e23          	sw	ra,28(sp)
   1007c:	00812c23          	sw	s0,24(sp)
   10080:	02010413          	addi	s0,sp,32
   10084:	fe440693          	addi	a3,s0,-28
   10088:	fe840713          	addi	a4,s0,-24
   1008c:	fec40793          	addi	a5,s0,-20
   10090:	00068613          	mv	a2,a3
   10094:	00070593          	mv	a1,a4
   10098:	00078513          	mv	a0,a5
   1009c:	03c000ef          	jal	ra,100d8 <readSensors>
   100a0:	fe442783          	lw	a5,-28(s0)
   100a4:	00079663          	bnez	a5,100b0 <main+0x3c>
   100a8:	0e4000ef          	jal	ra,1018c <turnRight>
   100ac:	fd9ff06f          	j	10084 <main+0x10>
   100b0:	fe842783          	lw	a5,-24(s0)
   100b4:	00079663          	bnez	a5,100c0 <main+0x4c>
   100b8:	088000ef          	jal	ra,10140 <moveForward>
   100bc:	fc9ff06f          	j	10084 <main+0x10>
   100c0:	fec42783          	lw	a5,-20(s0)
   100c4:	00079663          	bnez	a5,100d0 <main+0x5c>
   100c8:	120000ef          	jal	ra,101e8 <turnLeft>
   100cc:	fb9ff06f          	j	10084 <main+0x10>
   100d0:	174000ef          	jal	ra,10244 <goBack>
   100d4:	fb1ff06f          	j	10084 <main+0x10>

000100d8 <readSensors>:
   100d8:	fd010113          	addi	sp,sp,-48
   100dc:	02812623          	sw	s0,44(sp)
   100e0:	03010413          	addi	s0,sp,48
   100e4:	fca42e23          	sw	a0,-36(s0)
   100e8:	fcb42c23          	sw	a1,-40(s0)
   100ec:	fcc42a23          	sw	a2,-44(s0)
   100f0:	cc800793          	li	a5,-824
   100f4:	fef42623          	sw	a5,-20(s0)
   100f8:	fec42783          	lw	a5,-20(s0)
   100fc:	00ff7f33          	and	t5,t5,a5
   10100:	001f7793          	andi	a5,t5,1
   10104:	fcf42e23          	sw	a5,-36(s0)
   10108:	fec42783          	lw	a5,-20(s0)
   1010c:	00ff7f33          	and	t5,t5,a5
   10110:	001f5f13          	srli	t5,t5,0x1
   10114:	001f7793          	andi	a5,t5,1
   10118:	fcf42c23          	sw	a5,-40(s0)
   1011c:	fec42783          	lw	a5,-20(s0)
   10120:	00ff7f33          	and	t5,t5,a5
   10124:	002f5f13          	srli	t5,t5,0x2
   10128:	001f7793          	andi	a5,t5,1
   1012c:	fcf42a23          	sw	a5,-44(s0)
   10130:	00000013          	nop
   10134:	02c12403          	lw	s0,44(sp)
   10138:	03010113          	addi	sp,sp,48
   1013c:	00008067          	ret

00010140 <moveForward>:
   10140:	fd010113          	addi	sp,sp,-48
   10144:	02812623          	sw	s0,44(sp)
   10148:	03010413          	addi	s0,sp,48
   1014c:	cc800793          	li	a5,-824
   10150:	fef42623          	sw	a5,-20(s0)
   10154:	fec42783          	lw	a5,-20(s0)
   10158:	fe842703          	lw	a4,-24(s0)
   1015c:	fe442683          	lw	a3,-28(s0)
   10160:	fe042603          	lw	a2,-32(s0)
   10164:	fdc42583          	lw	a1,-36(s0)
   10168:	00ff7f33          	and	t5,t5,a5
   1016c:	010f6713          	ori	a4,t5,16
   10170:	000f6693          	ori	a3,t5,0
   10174:	000f6613          	ori	a2,t5,0
   10178:	200f6593          	ori	a1,t5,512
   1017c:	00000013          	nop
   10180:	02c12403          	lw	s0,44(sp)
   10184:	03010113          	addi	sp,sp,48
   10188:	00008067          	ret

0001018c <turnRight>:
   1018c:	fd010113          	addi	sp,sp,-48
   10190:	02112623          	sw	ra,44(sp)
   10194:	02812423          	sw	s0,40(sp)
   10198:	03010413          	addi	s0,sp,48
   1019c:	cc800793          	li	a5,-824
   101a0:	fef42623          	sw	a5,-20(s0)
   101a4:	fec42783          	lw	a5,-20(s0)
   101a8:	fe842703          	lw	a4,-24(s0)
   101ac:	fe442683          	lw	a3,-28(s0)
   101b0:	fe042603          	lw	a2,-32(s0)
   101b4:	fdc42583          	lw	a1,-36(s0)
   101b8:	00ff7f33          	and	t5,t5,a5
   101bc:	010f6713          	ori	a4,t5,16
   101c0:	000f6693          	ori	a3,t5,0
   101c4:	100f6613          	ori	a2,t5,256
   101c8:	000f6593          	ori	a1,t5,0
   101cc:	2bc00513          	li	a0,700
   101d0:	0d0000ef          	jal	ra,102a0 <delay>
   101d4:	00000013          	nop
   101d8:	02c12083          	lw	ra,44(sp)
   101dc:	02812403          	lw	s0,40(sp)
   101e0:	03010113          	addi	sp,sp,48
   101e4:	00008067          	ret

000101e8 <turnLeft>:
   101e8:	fd010113          	addi	sp,sp,-48
   101ec:	02112623          	sw	ra,44(sp)
   101f0:	02812423          	sw	s0,40(sp)
   101f4:	03010413          	addi	s0,sp,48
   101f8:	cc800793          	li	a5,-824
   101fc:	fef42623          	sw	a5,-20(s0)
   10200:	fec42783          	lw	a5,-20(s0)
   10204:	fe842703          	lw	a4,-24(s0)
   10208:	fe442683          	lw	a3,-28(s0)
   1020c:	fe042603          	lw	a2,-32(s0)
   10210:	fdc42583          	lw	a1,-36(s0)
   10214:	00ff7f33          	and	t5,t5,a5
   10218:	000f6713          	ori	a4,t5,0
   1021c:	020f6693          	ori	a3,t5,32
   10220:	000f6613          	ori	a2,t5,0
   10224:	200f6593          	ori	a1,t5,512
   10228:	2bc00513          	li	a0,700
   1022c:	074000ef          	jal	ra,102a0 <delay>
   10230:	00000013          	nop
   10234:	02c12083          	lw	ra,44(sp)
   10238:	02812403          	lw	s0,40(sp)
   1023c:	03010113          	addi	sp,sp,48
   10240:	00008067          	ret

00010244 <goBack>:
   10244:	fd010113          	addi	sp,sp,-48
   10248:	02112623          	sw	ra,44(sp)
   1024c:	02812423          	sw	s0,40(sp)
   10250:	03010413          	addi	s0,sp,48
   10254:	cc800793          	li	a5,-824
   10258:	fef42623          	sw	a5,-20(s0)
   1025c:	fec42783          	lw	a5,-20(s0)
   10260:	fe842703          	lw	a4,-24(s0)
   10264:	fe442683          	lw	a3,-28(s0)
   10268:	fe042603          	lw	a2,-32(s0)
   1026c:	fdc42583          	lw	a1,-36(s0)
   10270:	00ff7f33          	and	t5,t5,a5
   10274:	010f6713          	ori	a4,t5,16
   10278:	000f6693          	ori	a3,t5,0
   1027c:	100f6613          	ori	a2,t5,256
   10280:	000f6593          	ori	a1,t5,0
   10284:	57800513          	li	a0,1400
   10288:	018000ef          	jal	ra,102a0 <delay>
   1028c:	00000013          	nop
   10290:	02c12083          	lw	ra,44(sp)
   10294:	02812403          	lw	s0,40(sp)
   10298:	03010113          	addi	sp,sp,48
   1029c:	00008067          	ret

000102a0 <delay>:
   102a0:	fd010113          	addi	sp,sp,-48
   102a4:	02812623          	sw	s0,44(sp)
   102a8:	03010413          	addi	s0,sp,48
   102ac:	fca42e23          	sw	a0,-36(s0)
   102b0:	fe042623          	sw	zero,-20(s0)
   102b4:	0100006f          	j	102c4 <delay+0x24>
   102b8:	fec42783          	lw	a5,-20(s0)
   102bc:	00178793          	addi	a5,a5,1
   102c0:	fef42623          	sw	a5,-20(s0)
   102c4:	fec42703          	lw	a4,-20(s0)
   102c8:	fdc42783          	lw	a5,-36(s0)
   102cc:	fef746e3          	blt	a4,a5,102b8 <delay+0x18>
   102d0:	00000013          	nop
   102d4:	02c12403          	lw	s0,44(sp)
   102d8:	03010113          	addi	sp,sp,48
   102dc:	00008067          	ret

```
