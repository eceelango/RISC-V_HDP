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
  
![Screenshot from 2024-03-31 14-47-44](https://github.com/eceelango/RISC-V_HDP/assets/65966247/afe3c44f-229c-416a-8ddd-d7008c5fa456)

**+ RISCV Compiler**
```
riscv64-unknown-elf-gcc -march=rv64i -mabi=lp64 -ffreestanding -o ./maze.o maze.c
spike pk maze.o

```
![Screenshot from 2024-03-31 14-57-47](https://github.com/eceelango/RISC-V_HDP/assets/65966247/4b8ce8b1-2b02-4e3f-9332-dd3a7592d641)


## Register architecture of x30 for GPIOs

+ Input Signals - Sensor1, Sensor2, Sensor3;
+ Output Signals - Speed1, Speed2, e1, e2, d1 ,d2 ;
+ Number of Register bits Required - 9
+ Register bits allocations are given below

+ x30 [2:0] is Sensor -  Sensor 1 - x30[0]; Sensor 2 - x30[1]; Sensor 3 - x30[2];   // Input - Read
+ x30 [4:3] is speed - Speed 1 x30 [3]; Speed 2 x30 [4];   // Output Write
+ x30 [6:5] is e1 & e2 - e1 x30 [5] ; e2 x30 [6] ;  // Output Write
+ x30 [8:7] is d1 & d2 - d1 x30 [7] ; d2 x30 [8] ;  // Output Write



