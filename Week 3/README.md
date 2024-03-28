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
![MAZEFLOW](https://github.com/eceelango/RISC-V_HDP/assets/65966247/c6b75dd4-eeee-48d0-bb62-448453a44ced)

## Register architecture of x30 for GPIOs

## Sensor Functions & Pinout
Three Sensor Options to implement the project
+ IR Sensor
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

### TOF Sensor
![TOF](https://github.com/eceelango/RISC-V_HDP/assets/65966247/6ac70ba8-4502-43d5-8b79-a051fc229e2b)

![Sensor Pinout](https://github.com/eceelango/RISC-V_HDP/assets/65966247/d3d00ef3-03d2-47bb-a745-58cad553e0f1)

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

```
#include <stdbool.h>
#include <stdio.h>  

// Assuming Sensor1 = Front, Sensor2 = Right, Sensor3 = Left
bool Sensor1 = false;
bool Sensor2 = false;
bool Sensor3 = false;

// Prototype function declarations
void moveForward();
void turnRight();
void turnLeft();
void stop();

// Function to simulate or read sensor values
// You need to replace these functions with actual sensor read code
void readSensors() {
    // Placeholder functions to simulate sensor readings
    // Sensor1 = readFrontSensor();
    // Sensor2 = readRightSensor();
    // Sensor3 = readLeftSensor();

    // Assume false means no obstacle, true means obstacle
    Sensor1 = false; // No obstacle in front
    Sensor2 = false; // No obstacle to the right
    Sensor3 = true;  // Obstacle to the left
}

int main() {
    while (true) { // Infinite loop to keep the robot running
        readSensors(); // Update sensor readings

        if (!Sensor2) { // If the path is clear on the right (no obstacle)
            turnRight();
            moveForward();
        } else if (!Sensor1) { // If the right is blocked but forward is clear (no obstacle)
            moveForward();
        } else if (!Sensor3) { // If both right and forward paths are blocked, turn left (no obstacle)
            turnLeft();
            moveForward();
        } else {
            // If all paths are blocked, stop
            stop();
            break; // Exiting the loop, can be removed to keep the robot in a waiting state
        }
    }
    return 0;
}

void moveForward() {
    printf("Moving forward\n");
   
}

void turnRight() {
    printf("Turning right\n");
  
}

void turnLeft() {
    printf("Turning left\n");
   
}

void stop() {
    printf("Stopping\n");
 
}

```
