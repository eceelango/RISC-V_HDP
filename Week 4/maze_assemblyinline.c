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

