#include <stdio.h>
#include <stdlib.h>


int findLowestPositiveNumber(int* numbers,int len);
int longest_space( char *str );
char str[] = "Pro gram   ovani v asse bleru . ";
int main(void) {
    int nums[] =  { -10, 10, -20, 20, -30, 30, -40, 40, -50, 50 };
    int lowestPositive = findLowestPositiveNumber(nums,10);
    printf("lowestPositive = %d\n",lowestPositive);
    int longestSpace = longest_space(str);
    printf("longestSpace = %d\n",longestSpace);

    exit(EXIT_SUCCESS);
}
