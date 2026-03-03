#include <stdio.h>
#include <stdlib.h>


int findLowestPositiveNumber(int* numbers,int len);
int longest_space( char *str );
int kolik_mocnin( int *pole, int N, int K );
int binstr2int( char *binstr );

char str[] = "Pro gram   ovani v asse bleru . ";
int main(void) {
    int nums[] =  { -10, 10, -20, 20, -30, 30, -40, 40, -50, 50 };
    int numsK[] =  { 2,16,3 };
    int lowestPositive = findLowestPositiveNumber(nums,10);
    printf("lowestPositive = %d\n",lowestPositive);
    int longestSpace = longest_space(str);
    printf("longestSpace = %d\n",longestSpace);

    int nKBits = kolik_mocnin(numsK,3,1);
    printf("K Bits: %d\n",nKBits);
    char binCode[] = "1010101001010101";
    int number = binstr2int(binCode );
    printf("%x\n",number);
    exit(EXIT_SUCCESS);
}
