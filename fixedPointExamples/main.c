#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include  <stdint.h>
long multiplyFixed(long a, long b,long shift);
long divideFixed(long a, long b,long shift);
long sphereVolume(long r,long PI);
long sphereArea(long r,long PI);
long eulerNum();

long toFixed(double f, int shift) {
    return (long)(f * (1LL << shift));
}

double fromFixed(long i, int shift) {
    return (double)i / (1LL << shift);
}

long fixedFactorial(long n,long shift) {
    if (n == 1) return 1;

    return multiplyFixed(n, fixedFactorial(n-1, shift), shift);
}

long factorial(long n) {
    if ( n == 1) return 1;
    return n * factorial(n - 1);
}


long sin_fixed(long x, long shift) {
    long res = 0;
    long current_x_pow = x;
    long n = 0;
    while (1) {
        int exp = 2 * n + 1;
        long currentFactorial = factorial(exp);
        long currentX = x;
        for (int i = 1; i < exp; i++) {
            currentX  = multiplyFixed(currentX,x,shift);
        }
        currentFactorial = toFixed(currentFactorial, shift);
        long term = divideFixed(currentX, currentFactorial, shift);
        if (term == 0) break;
        if (n % 2 == 1) {
            res -= term;
        } else {
            res += term;
        }
        printf("n=%ld, term=%f\n", n, fromFixed(term, shift));

        n++;
        if (n >= 8) break;
    }
    return res;
}

void printFixedManual(long num, int shift,int D) {
    long integerPart = num >> shift;
    printf("%ld.", integerPart);

    unsigned long fractionalPart = num & ((1ULL << shift) - 1);

    for (int i = 0; i < D; i++) {
        fractionalPart *= 10;
        long digit = fractionalPart >> shift;
        printf("%ld", digit);
        fractionalPart &= ((1ULL << shift) - 1);
    }
    printf("\n");
}
void printFixedManual2(long num, int shift,int D) {

    unsigned long fractionalPart = num >> shift;
    long base = 1;
    long curFrac = fractionalPart;
    for (int i = 0; i < D; i++) {
        if (curFrac & 0x1) base *= 2;
        double res = 1/ base;
        printf("%f.", res);
        fractionalPart >>= 1;
    }
    printf("%ld", base);
    printf("\n");
}



int main(void) {
    int shift = 32;
    double PI2 = 1.57079632679;
    long PI2Fixed = toFixed(PI2, shift);

    long sinRes = sin_fixed(PI2Fixed, shift);
    double res = fromFixed(sinRes, shift);

    printFixedManual2(0x18000000,shift,8);
    return 0;
}
