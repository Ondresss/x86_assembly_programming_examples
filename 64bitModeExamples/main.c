#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void str_up_low( char *str, int up_down );
void sums_of_bytes( long *pole, int N );
void long2str( long num, char *cislo );
long str2long( char *cislo );
long filterDiv( long* pole1,long N,long* pole2);

void turn_sign(int* pole,int N,int sign);
void find_high_one( int *array, int N);


int main(void) {

    int diffNums[] = {1,-1,2,3};
    turn_sign(diffNums,4,1);
    for (int i = 0; i < 4; i++) {
        printf("%d ",diffNums[i]);
    }
    printf("\n");

    int arr[] = {300, 600, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200 };
    find_high_one(arr,10);
    for (int i=0;i<10;i++) {
        printf("%d ",arr[i]);
    }
    printf("\n");
    exit(EXIT_SUCCESS);
}
