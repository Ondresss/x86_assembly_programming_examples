#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void sums_of_bytes( long *pole, int N );
int main(void) {
    long nums[] = {0x0102010201020102};
    sums_of_bytes(nums,1);
    for (int i = 0; i < 1; ++i) {
        printf("%ld ", nums[i]);
    }
    printf("\n");
    exit(EXIT_SUCCESS);
}
