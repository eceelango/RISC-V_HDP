#include <stdio.h>

// Using int instead of bool. 0 = false, 1 = true
int Sensor1 = 0;
int Sensor2 = 0;
int Sensor3 = 0;
int Speed1 = 1;
int Speed2 = 1;
int e1=0;
int e2=0;
int d1=0;
int d2=0;

// Prototype function declarations
void moveForward();
void turnRight();
void turnLeft();
void goBack();
void stop();
void delay(long iterations);

// Function to simulate or read sensor values
void readSensors() {
    printf("Enter state for Sensor1 (Front) [0 for no obstacle, 1 for obstacle]: ");
    scanf("%d", &Sensor1);
    printf("Enter state for Sensor2 (Right) [0 for no obstacle, 1 for obstacle]: ");
    scanf("%d", &Sensor2);
    printf("Enter state for Sensor3 (Left) [0 for no obstacle, 1 for obstacle]: ");
    scanf("%d", &Sensor3);
}

int main() {
    while (1) { // Infinite loop to keep the robot running
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
    e1= 1;
    e2=0;
    d1= 0;
    d2=1;
}

void turnRight() {
    printf("Turning right\n");
    e1= 1;
    e2=0;
    d1= 1;
    d2=0;
    delay(700);
}

void turnLeft() {
    printf("Turning left\n");
    e1= 0;
    e2=1;
    d1= 0;
    d2=1;
    delay(700);
}

void goBack() {
    printf("Returning\n");
    e1= 1;
    e2=0;
    d1= 1;
    d2=0;
    delay(1400);
}

void stop() {
    printf("Stopping\n");
    e1= 0;
    e2=0;
    d1= 0;
    d2=0;
}

void delay(long iterations) {
    for(long i = 0; i < iterations; i++) {
        // Empty loop body
    }
}

