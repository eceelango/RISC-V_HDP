with open('maze1.txt', 'r') as file:
    assembly_code = file.read()
lines = assembly_code.split('\n')
unique_instructions = set()
for line in lines[5:]:
    line = line.strip()
    if line and not line.startswith('#'):
        parts = line.split()
        if len(parts) >= 3:
            instruction = parts[2]
            unique_instructions.add(instruction)
print("Number of different instructions:{}".format (len(unique_instructions)))
print("List of unique instructions:")
for instruction in unique_instructions:
    print(instruction)
