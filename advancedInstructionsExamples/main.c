#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long suma_int( int *pole, int N );
void upperPalindrom (int* num);
void mocniny( int *pole, int N, int K );
void int2binstr( int num, char *str, int *table );
void division(int* pole,int N,int K);
long long l_bit_shift( long long num, int okolik );
void enc_dec( char *str, int N );
char bit_mirror( char num );
void mocniny2( int X, int N, int *pole );
int main(void) {
    int finta_bin[] = {
        0x30303030,
        0x31303030,
        0x30313030,
        0x31313030,
        0x30303130,
        0x31303130,
        0x30313130,
        0x31313130,
        0x30303031,
        0x31303031,
        0x30313031,
        0x31313031,
        0x30303131,
        0x31303131,
        0x30313131,
        0x31313131
    };
    int arr[] = {1111111111,1111111111,1111111111,1111111111,1111111111,1111111111,1111111111,1111111111,1111111111};
    long long shiftedNum = l_bit_shift(0x8888888888,1);
    printf("%llX\n",shiftedNum);
    char toDecode[] = "ABC";
    for (int i = 0; i < strlen(toDecode); i++) {
        printf("%02X",toDecode[i]);
    }
    printf("\n");
    enc_dec(toDecode,3);
    for (int i = 0; i < strlen(toDecode); i++) {
        printf("%02X",toDecode[i]);
    }

    printf("\n");
    for (int i = 32; i <= 127; i++) {
        unsigned char ret = bit_mirror(i);
        printf("%08b  %08b\n",(unsigned char)i,ret);
    }

    int numsToPowers[4];
    mocniny2(2,4,numsToPowers);
    for (int i = 0; i < 4; i++) {
        printf("%d ",numsToPowers[i]);
    }
    printf("\n");

    exit(EXIT_SUCCESS);
}
