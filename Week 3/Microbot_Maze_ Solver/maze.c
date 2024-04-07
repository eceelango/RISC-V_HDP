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

