## Designing the 4-bit ALU in C:

Implement the 4-bit ALU functionality in C code.
Use basic arithmetic and logic operations such as addition, subtraction, bitwise AND, bitwise OR, etc.
Verify the correctness of the C code using gcc compiler.

```
#include <stdio.h>
#include <string.h>
int main() {
    int a, b, result;
    char operation;

    printf("Enter the value of a: ");
    scanf("%d", &a);
    printf("Enter the value of b: ");
    scanf("%d", &b);
    printf("Enter the required operation (add, sub, mul, div): ");
    scanf(" %c", &operation);
    switch (operation) {
        case 'a':
            result = a + b;
            printf("Value of %d + %d is %d\n", a, b, result);
            break;
        case 's':
            result = a - b;
            printf("Value of %d - %d is %d\n", a, b, result);
            break;
        case 'm':
            result = a * b;
            printf("Value of %d * %d is %d\n", a, b, result);
            break;
        case 'd':
            if (b == 0) {
                printf("Can't divide when b is zero\n");
            } else {
                result = a / b;
                printf("Value of %d / %d is %d\n", a, b, result);
            }
            break;
        default:
            printf("Invalid operation selected\n");
            break;
    }
    return 0;
}  
```

## Verifying the C Code using gcc:

Compile the C code using the gcc compiler.
Run the compiled executable to verify the functionality of the 4-bit ALU.


![4bitalu_res](https://github.com/LRAJA33/RISCV-HDP/assets/105126037/e96b8a7f-f305-4c07-9306-ab2b25ffdc38)

