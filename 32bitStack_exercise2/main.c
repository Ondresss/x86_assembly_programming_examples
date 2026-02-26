#include <stdio.h>
#include <stdlib.h>


int findLowestPositiveNumber(int* numbers,int len);


int main(void) {
    int nums[] =  { -10, 10, -20, 20, -30, 30, -40, 40, -50, 50 };
    int lowestPositive = findLowestPositiveNumber(nums,10);
    printf("lowestPositive = %d\n",lowestPositive);
    exit(EXIT_SUCCESS);
}
