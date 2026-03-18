#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int stringCompare(const char* dest, const char* src);
void stringSaveCopy(char* dest, char* src);
char* stringNotChr(const char* dest,char c);
char* strStr_(const char* dest, const char* src);
void bez_cislic( char *str, char *table );
void fillArr(int* dest,int* source);
int main(void) {
    char destStr[128] = "dsadsaHeHello World!";
    char srcStr[128] = "Hello";

    char tab[256] = {0};

    for (int i = 0; i < 256; i++) {
        tab[i] = i;
    }
    for (int i = '0'; i <= '9'; i++) {
        tab[i] = 0;
    }
    for (int i = 0; i < 256; i++) {
        printf("%d ",tab[i]);
    }
    printf("\n\n\n");
    // int ret = stringCompare(destStr, srcStr);
    // printf("%d\n", ret);
    //
    // char toChr[] = "       Hello World!";
    // char* pos = stringNotChr(toChr, ' ');
    // printf("%c\n", *pos);
    //
    // stringSaveCopy(destStr + 4, destStr);
    // printf("%s\n", destStr);

    char* pos = strStr_(destStr, srcStr);
    printf("%s\n", pos);
    char strCisla[125] = "aho9j";
    bez_cislic(strCisla,tab);
    printf("%s\n",strCisla);

    int ukol[] = { 4, 5, 3, 6, 2, 7, 1, 8, 0 };
    int nums[1045] = {0};
    fillArr(nums,ukol);
    int i =0;
    while (nums[i] != 0) {
        printf("%d ",nums[i]);
        i++;
    }
    printf("\n\n\n");
    exit(EXIT_SUCCESS);
}
