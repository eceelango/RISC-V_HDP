# Microbot Maze Solver: Autonomous Navigation Controller Development

**Autonomous robot able to find its way through a maze in the shortest possible time**

![IMG_4124](https://github.com/eceelango/RISC-V_HDP/assets/65966247/357e906f-3e07-4aae-b149-dbfe8a4d6116)

## Key Objectives:

+ The key objective of this project is to develop a microarchitecture (RISCV controller) so that the micromouse maze solver bot will find a path from a designated start point to an end point within a maze, efficiently and accurately. 
+ This involves navigating through a complex network of paths and walls, avoiding dead ends, and potentially optimizing for the shortest or quickest path depending on the specific goals. 
+ The bot must use algorithms and strategies to explore and solve the maze, adapting to various maze configurations and overcoming challenges such as loops, multiple paths, and dynamic changes within the maze environment.

![m](https://github.com/eceelango/RISC-V_HDP/assets/65966247/02d08335-f1b6-4335-93dc-0c3e14f4d2de)

## Key Components:

+ RISCV Microcontroller with Required  I/O
+ Sensors - 3 No's
+ Motor Drivers - 2
+ N20 Motors - 2
+ Robotic Chasis with Wheel
  
![BOT](https://github.com/eceelango/RISC-V_HDP/assets/65966247/37287564-b0ea-42df-a390-8b2c4b1478bd)

## Key Functions:

1. Three Sensors gather distance data for maze perception from Front, Left and Right Side.
2. Wall Following algorithm maps the maze efficiently for optimized paths.
3. RISC V microcontroller makes real-time movement decisions.
4. Motor Driver controls N20 Motors for accurate navigation.

## Block Diagram:
![Block Diagram](https://github.com/eceelango/RISC-V_HDP/assets/65966247/6cd1881e-0a56-45c0-b909-3ddc6f1ed812)

## Flowchart
![MAZEFLOW (2)](https://github.com/eceelango/RISC-V_HDP/assets/65966247/73bf8aca-0ae2-4462-9da7-e1154d7704dd)

## Sensor Functions & Pinout
Three Sensor Options to implement the project
+ IR Sensor (This Project used IR option)
+ Ultrasonic Sensor
+ TOF Sensor
### IR Sensor

When the module detects obstacles in front of the signal, the circuit board green indicator light level, while the OUT port continuous output low-level signals, the module detects a distance of 2 ~ 10cm, detection angle 35 °, the detection distance can be potential adjustment with adjustment potentiometer clockwise, the increase in detection distance; counterclockwise adjustment potentiometer, the detection distance decreased.

![ir-sensor-module-india-800x800](https://github.com/eceelango/RISC-V_HDP/assets/65966247/3961fc7b-e74c-4db9-87d0-b59613a53b3f)

**Pinout:**
+ VCC external 3.3V-5V voltage (can be directly connected with the a 5v microcontroller and 3.3v microcontroller).
+ GND external GND.
+ OUT board digital output interface (0 and 1).
### Ultrasonic Sensor
![HCSR04-Ultrasonic-Sensor-Pinout](https://github.com/eceelango/RISC-V_HDP/assets/65966247/c924c5c7-b36c-4b72-999d-8943b4558204)
+ Operating voltage: +5V
+ Theoretical  Measuring Distance: 2cm to 450cm
+ Practical Measuring Distance: 2cm to 80cm
+ Accuracy: 3mm
+ Measuring angle covered: <15°
+ Operating Current: <15mA
+ Operating Frequency: 40Hz
  
### TOF Sensor

![TOF](https://github.com/eceelango/RISC-V_HDP/assets/65966247/6ac70ba8-4502-43d5-8b79-a051fc229e2b)
![Sensor Pinout](https://github.com/eceelango/RISC-V_HDP/assets/65966247/d3d00ef3-03d2-47bb-a745-58cad553e0f1)

+ The VL53L0X is a new generation Time-of-Flight (ToF) laser-ranging module housed in the smallest package on the market today
+ It can measure absolute distances up to 2m, setting a new benchmark in ranging performance levels, opening the door to various new applications.
+ This module has 4 pins VCC, GND, SCL, and SDA.
+ The board has a 2.8V linear regulator and integrated level shifter so, it can bear a voltage in the range of 2.6V to 5.5V.
+  It uses I2C protocol to communicate that’s why Serial Clock Line (SCL) and Serial Data Address (SDA) pins are there to communicate with the microcontroller.
+ Supply Current: 10mA

## Motor Driver Functions & Pinout
+ DRV8835 Dual Low-Voltage H-Bridge Driver
+ Separate Motor and Logic-Supply Pins
+ 0-V to 11-V Motor-Operating Supply-Voltage
+ 2-V to 7-V Logic Supply-Voltage
  ![Driver  png](https://github.com/eceelango/RISC-V_HDP/assets/65966247/eba6a543-e10d-4ab4-a493-95c4c9fca34a)

**Datasheet:** https://robu.in/wp-content/uploads/2023/05/drv8835.pdf
## N20 Motors
+ N20-12V-300 Rpm Micro Metal Gear Motor
+ Lightweight, high torque and low RPM.
  ![mOTOR](https://github.com/eceelango/RISC-V_HDP/assets/65966247/809b388b-60a0-4fa6-938f-587c86a71620)

## C Code
// Right Wall Following Algorithm

```
#include <stdio.h>

// Using int instead of bool. 0 = false, 1 = true
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

// Function to simulate or read sensor values
void readSensors() {
    printf("Enter state for Sensor3 (Right) [0 for no obstacle, 1 for obstacle]: ");
    scanf("%d", &Sensor3);
    printf("Enter state for Sensor2 (Front [0 for no obstacle, 1 for obstacle]: ");
    scanf("%d", &Sensor2);
    printf("Enter state for Sensor1 (Left) [0 for no obstacle, 1 for obstacle]: ");
    scanf("%d", &Sensor1);
}

int main() {
    while (1) { // keep the robot running infintely
        readSensors(); // Update sensor readings
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

void moveForward() {
    printf("Moving forward\n");
    Motor1A= 1;
    Motor1B=0;
    Motor2A= 0;
    Motor2B=1;
}

void turnRight() {
    printf("Turning right\n");
     Motor1A= 1;
     Motor1B=0;
     Motor2A= 1;
     Motor2B=0;
     delay(700);
}

void turnLeft() {
    printf("Turning left\n");
    Motor1A= 0;
    Motor1B=1;
    Motor2A= 0;
    Motor2B=1;
    delay(700);
}

void goBack() {
    printf("U Turn\n");
    Motor1A= 1;
    Motor1B=0;
    Motor2A= 1;
    Motor2B=0;
    delay(1400);
}

void delay(long iterations) {
    for(long i = 0; i < iterations; i++) {
        // Empty loop body
    }
}

```
## Output
**+ gcc compiler**

  ![Screenshot from 2024-04-07 19-59-42](https://github.com/eceelango/RISC-V_HDP/assets/65966247/f0b39508-44c5-476f-a86c-8eb0f5ea14cd)

**+ RISCV Compiler**
```
riscv64-unknown-elf-gcc -march=rv64i -mabi=lp64 -ffreestanding -o ./maze.o maze.c
spike pk maze.o

```
![Maze RISCV Compiler](https://github.com/eceelango/RISC-V_HDP/assets/65966247/ef16d4c1-5753-4bd3-836e-e0fd2f257c1b)


## Register architecture of x30 for GPIOs

+ Input Signals - Sensor1, Sensor2, Sensor3;
+ Output Signals -  Motor1A, Motor1B, Motor2A, Motor2B;
+ Number of Register bits Required - 7
+ Register bits allocations are given below

+ x30 [2:0] is Sensor -  Sensor 1 - x30[0]; Sensor 2 - x30[1]; Sensor 3 - x30[2];   // Input - Read
+ x30 [5:4] is e1 & e2 - e1 x30 [4] ; e2 x30 [5] ;  // Output Write
+ x30 [9:8] is d1 & d2 - d1 x30 [8] ; d2 x30 [9] ;  // Output Write

## C Code with inline Assembly
```
#include <stdio.h>

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

void moveForward() {
    printf("Moving forward\n");
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
    printf("Turning right\n");

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
    printf("Turning left\n");
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
    printf("U Turn\n");
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
