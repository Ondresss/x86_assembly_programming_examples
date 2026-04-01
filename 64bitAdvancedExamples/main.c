#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void bubble( int *pole, int N );
void bez_opakovani( char *str );
int median( int *pole, int N );
int bSearch(int* pole,int l,int r,int x);
void bubbleChars( char* str, int len );
void bez_znaku( char *str, char *co_nechci );
int main(void) {

    char charsToSort[128] = "dbdz";
    bubbleChars(charsToSort,6);
    for (int i = 0; i < 6; i++) {
        printf("%c ",charsToSort[i]);
    }
    printf("\n");
    char charsRem[128] = "aabc";
    bez_znaku(charsRem,"aa");
    for (int i =0; charsRem[i] != '\0'; i++) {
        printf("%c ",charsRem[i]);
    }
    printf("\n");
    int nums[128]  = {2,5,1,4};
    int pos = bSearch(nums,0,4,1);
    printf("pos = %d\n",pos);
    exit(EXIT_SUCCESS);
}
