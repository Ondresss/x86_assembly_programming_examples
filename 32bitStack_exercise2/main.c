#include <stdio.h>
#include <stdlib.h>


int findLowestPositiveNumber(int* numbers,int len);
int longest_space( char *str );
int num_of_powers( int *pole, int N, int K );

char str[] = "Pro gram   ovani v asse bleru . ";
int main(void) {
    int nums[] =  { -10, 10, -20, 20, -30, 30, -40, 40, -50, 50 };
    int numsK[] =  { 2,16,3 };
    int lowestPositive = findLowestPositiveNumber(nums,10);
    printf("lowestPositive = %d\n",lowestPositive);
    int longestSpace = longest_space(str);
    printf("longestSpace = %d\n",longestSpace);
    int numOfPowers = num_of_powers(numsK,3,1);
    printf("numOfPowers = %d\n",numOfPowers);
    exit(EXIT_SUCCESS);
}
