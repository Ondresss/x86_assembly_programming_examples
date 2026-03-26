#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void bubble( int *pole, int N );
int main(void) {
    int sortArr[128] = {15,4,10,1,12,3};
    bubble(sortArr,6);
    for (int i = 0; i < 6; ++i) {
        printf("%d ",sortArr[i]);
    }
    printf("\n");
    exit(EXIT_SUCCESS);
}
