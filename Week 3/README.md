# Weather Station Clock

## Objective:

Combine a digital clock with temperature and humidity readings, displaying all information on a single screen or separate modules

## Key Components:

+ RISCV Microcontroller with Required  I/O
+ RTC module for timekeeping
+ DHT11 or DHT22 sensor for temperature and humidity
+ LCD or OLED display

## Block Diagram:
![Block Diagram](https://github.com/eceelango/RISC-V_HDP/assets/65966247/b9ede566-33f6-4dd2-8c50-11bc05c8d83e)


# MICROMOUSE MAZE SOLVER ROBOT CONTROLLER DEVELOPMENT

## Key Objectives:

+ The key objective of a maze solver bot is to find a path from a designated start point to an end point within a maze, efficiently and accurately. 
+ This involves navigating through a complex network of paths and walls, avoiding dead ends, and potentially optimizing for the shortest or quickest path depending on the specific goals. 
+ The bot must use algorithms and strategies to explore and solve the maze, adapting to various maze configurations and overcoming challenges such as loops, multiple paths, and dynamic changes within the maze environment.

## Key Components:

+ RISCV Microcontroller with Required  I/O
+ Sensors
+ Motor Drivers
+ N20 Motors
+ Robotic Chasis with Wheel

## Key Functions:

1. Three VL53L0X TOF Sensors gather distance data for maze perception.
2. Wall Following algorithm maps the maze efficiently for optimized paths.
3. RISC V microcontroller makes real-time movement decisions.
4. DVR8835 Motor Driver controls N20 Motors for accurate navigation.
