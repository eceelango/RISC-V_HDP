#include<stdio.h>
int main() {

int a,b,result ; // introducting a,b, result as integers
char op;  // Operation
printf("Enter two numbers:"); //printing and scanning the numbers
scanf("%d %d", &a, &b);

printf("Enter the operation from ADD, SUB, MUL, DIV, OR, AND, XOR : "); //printing what operation is to be done
scanf(" %c", &op);

switch(op) {
 case '+': // Addition
   result = a + b; 
  break;
 
 case '-': // Subtraction
    result = a - b;
  break;

 case '*': // Multiplication
    result = a * b;
  break;

 case '/': // Division
    result = a / b;
  break;

 case '|': // OR
   result = a | b;
  break;

 case '&': // AND
   result = a & b;
  break;

 case '^': // XOR
   result = a ^ b;
  break;

 default: // If others, wrong operation will be generated
   printf("Wrong operation");
   return 1;
}

printf("Result is: %d", result); // Printing the result

return 0;

}