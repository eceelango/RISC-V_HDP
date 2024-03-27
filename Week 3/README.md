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

## Register architecture of x30 for GPIOs

## Sensor Functions & Pinout

## Motor Driver Functions & Pinout

## N20 Motors

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

    // For the purpose of this example, let's manually assign values
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
    // Code to move the robot forward
}

void turnRight() {
    printf("Turning right\n");
    // Code to turn the robot right
}

void turnLeft() {
    printf("Turning left\n");
    // Code to turn the robot left
}

void stop() {
    printf("Stopping\n");
    // Code to stop the robot
}

```
