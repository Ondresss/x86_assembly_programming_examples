#include <stdio.h>
#include <stdlib.h>

long long suma_int( int *pole, int N );
void upperPalindrom (int* num);
void mocniny( int *pole, int N, int K );
void int2binstr( int num, char *str, int *table );
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
    int mocninyNums[] = { 8,16,32 };
    long long val = suma_int(arr,9);
    printf("%lld\n",val);
    int toPalindromNum = 0x1357;
    upperPalindrom(&toPalindromNum);
    printf("%x\n",toPalindromNum);

    mocniny(mocninyNums,3,2);
    for (int i = 0; i < 3; ++i) {
        printf("%d ",mocninyNums[i]);
    }
    printf("\n");

    char str[ 128 ] = {0};
    int2binstr( 0x123, str, finta_bin );
    printf( "%s\n", str );
    exit(EXIT_SUCCESS);
}
