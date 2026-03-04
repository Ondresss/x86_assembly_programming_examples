#include <stdio.h>
#include <stdlib.h>


int findLowestPositiveNumber(int* numbers,int len);
int longest_space( char *str );
int kolik_mocnin( int *pole, int N, int K );
int binstr2int( char *binstr );


char* poz_nejdelsi_mezery( char *str );
int biggest_negative(int* arr,int len);
int biggest_remainder_2(int* arr,int len,int K);
int encode_chars(char* str);
char str[] = "Pro gram   ovani v asse bleru . ";
int main(void) {

    int arr[] = { -1, 10, -20, 20, -30, 30, -40, 40, -50, 50 };
    int arrRemainder[] = {2,4,16};
    int biggestNegative = biggest_negative(arr,10);
    printf("%d\n",biggestNegative);
    char* pos = poz_nejdelsi_mezery(str);
    printf("%s\n",pos);

    int numRemainder = biggest_remainder_2(arrRemainder,3,1);
    printf("%d\n",numRemainder);
    char strToEncode[] = "SMALL blacK CAT";
    int encodedNum = encode_chars(strToEncode);
    printf("%x\n",encodedNum);
    exit(EXIT_SUCCESS);
}
