#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void str_up_low( char *str, int up_down );
void sums_of_bytes( long *pole, int N );
void long2str( long num, char *cislo );
int main(void) {
    long nums[] = {0x0102010201020102};
    sums_of_bytes(nums,1);
    for (int i = 0; i < 1; ++i) {
        printf("%ld ", nums[i]);
    }
    printf("\n");
    long num = 0x6162636465666768;
    char cislo[9] = {0};
    long2str(num,cislo);
    printf("%s\n",cislo);

    char str[128] = "ahoj";
    str_up_low(str,1);
    printf("%s\n",str);

    exit(EXIT_SUCCESS);
}
