# **Assembly In line Code for Maze Controller**
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

int readSensors() {
  int Sensor1, Sensor2, Sensor3;  // read whether Sensor 1,2 and 3 Obstacle is detected or not
int mask=0xFFFFFCC8
  asm volatile( "and x30, x30, %0\n\t"
	       "andi %1, x30, 1\n\t"
               : "=r"(Sensor1)
               : "r"(mask)
               : "x30");
  return Sensor1;
  asm volatile( "and x30, x30, %0\n\t" 
                "srli x30, x30, 1\n\t"
                "andi %1, x30, 1\n\t"
               : "=r"(Sensor2)
               : "r"(mask)
               : "x30");
  return Sensor2;
  asm volatile( "and x30, x30, %0\n\t" 
                "srli x30, x30, 2\n\t"
                "andi %1, x30, 1\n\t"
               : "=r"(Sensor3)
               : "r"(mask)
               : "x30");
  return Sensor3;

}


void moveForward() {
    printf("Moving forward\n");
int mask =0xFFFFFCC8
asm volatile(
		"and x30,x30, %0\n\t"
		"ori %1,x30, 16\n\t"
                "ori %2,x30, 0\n\t"
                "ori %3,x30, 0\n\t"
                "ori %4,x30, 512\n\t"
                : "r"(mask),"r"(Motor1A), "r"(Motor1B), "r"(Motor2A), "r"(Motor2B)
                :
		: "x30"
		);


void turnRight() {
    printf("Turning right\n");

int mask =0xFFFFFCC8
asm volatile(
		"and x30,x30, %0\n\t"
		"ori %1,x30, 16\n\t"
                "ori %2,x30, 0\n\t"
                "ori %3,x30, 256\n\t"
                "ori %4,x30, 0\n\t"

                : "r"(mask),"r"(Motor1A), "r"(Motor1B), "r"(Motor2A), "r"(Motor2B)
		: "x30"
		);

     delay(700);
}

void turnLeft() {
    printf("Turning left\n");
		"and x30,x30, %0\n\t"
		"ori %1,x30, 0\n\t"
                "ori %2,x30, 32\n\t"
                "ori %3,x30, 0\n\t"
                "ori %4,x30, 512\n\t"

                : "r"(mask),"r"(Motor1A), "r"(Motor1B), "r"(Motor2A), "r"(Motor2B)
		: "x30"
		);

    delay(700);
}

void goBack() {
    printf("U Turn\n");
		"and x30,x30, %0\n\t"
		"ori %1,x30, 16\n\t"
                "ori %2,x30, 0\n\t"
                "ori %3,x30, 256\n\t"
                "ori %4,x30, 0\n\t"

                : "r"(mask),"r"(Motor1A), "r"(Motor1B), "r"(Motor2A), "r"(Motor2B)
		: "x30"
		);

    delay(1400);
}

void delay(long intiterations) {
    for(long i = 0; i < iterations; i++) {
        // Empty loop body
    }
}


```