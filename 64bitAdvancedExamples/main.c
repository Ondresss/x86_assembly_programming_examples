#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void bubble( int *pole, int N );
void bez_opakovani( char *str );
int main(void) {
    int sortArr[128] = {15,4,10,1,12,3};
    bubble(sortArr,6);
    for (int i = 0; i < 6; ++i) {
        printf("%d ",sortArr[i]);
    }
    printf("\n");

    char characters[128] = "abcccde";
    bez_opakovani(characters);
    for (int i = 0; characters[i] != '\0'; ++i) {
        printf("%c ",characters[i]);
    }
    printf("\n");
    exit(EXIT_SUCCESS);
}
