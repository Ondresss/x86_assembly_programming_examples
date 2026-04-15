#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include  <stdint.h>
long multiplyFixed(long a, long b,long shift);
long divideFixed(long a, long b,long shift);


#define B 1023

union float_sep
{
    float f_num ;
    struct
    {
        unsigned int m :23;
        unsigned int e :8;
        unsigned int s :1;
    };
};

union mantissa
{
    struct
    {
        unsigned int m :23;
        unsigned int m1 :9;
    };
    int i_num ;
};


union double_sep
{
    double f_num ;
    struct
    {
        unsigned long m : 52;
        unsigned int e :11;
        unsigned int s :1;
    };
};

union mantissa_double
{
    struct
    {
        unsigned long m :52;
        unsigned int m1 :12;
    };
    long i_num ;
};

union double_sep divideDoubles(double a, double b) {
    union double_sep l_z ;
    union double_sep num1;
    union double_sep num2;

    num1.f_num = a;
    num2.f_num = b;

    l_z .s = ( num1 .s + num2 .s ) % 2;
    l_z .e = ( num1 .e - num2 .e + B );
    union mantissa_double l_mx = { { .m = num1.m, .m1 = 1 } };
    union mantissa_double l_my = { { .m = num2.m, .m1 = 1 } };
    union mantissa_double l_mz;
    long divison = divideFixed(l_mx.i_num,l_my.i_num,52);

    l_mz .i_num = divison;

    if (l_mz.m1 == 0) {
        l_mz.i_num <<= 1;
        l_z.e--;
    }

    l_z.m = l_mz.m;
    return l_z;
}

union float_sep divideFloats(float a, float b) {
    union float_sep l_z ;
    union float_sep num1;
    union float_sep num2;

    num1.f_num = a;
    num2.f_num = b;

    l_z .s = ( num1 .s + num2 .s ) % 2;
    l_z .e = ( num1 .e - num2 .e + B );
    union mantissa l_mx = { { .m = num1.m, .m1 = 1 } };
    union mantissa l_my = { { .m = num2.m, .m1 = 1 } };
    union mantissa l_mz;
    long long dividend  = (long long) l_mx.i_num << 23;
    int division = dividend / l_my.i_num;

    l_mz .i_num = division;

    if (l_mz.m1 == 0) {
        l_mz.i_num <<= 1;
        l_z.e--;
    }

    l_z.m = l_mz.m;
    return l_z;
}


union float_sep addFloats(float a, float b) {
    union float_sep l_z ;
    union float_sep num1;
    union float_sep num2;

    num1.f_num = a;
    num2.f_num = b;

    union mantissa l_mx = { { .m = num1.m, .m1 = 1 } };
    union mantissa l_my = { { .m = num2.m, .m1 = 1 } };
    int expDiff = 0;
    unsigned int finalExp;

    if (num1.e > num2.e) {
        expDiff = num1.e - num2.e;
        l_my.i_num >>= expDiff;
        finalExp = num1.e;
    } else {
        expDiff = num2.e - num1.e;
        l_mx.i_num >>= expDiff;
        finalExp = num2.e;
    }
    l_z.e = finalExp;
    union mantissa resultM;
    if (num1.s == num2.s) {
        resultM.i_num = l_mx.i_num + l_my.i_num;
    } else {
        if (l_mx.i_num >= l_my.i_num) {
            resultM.i_num = l_mx.i_num - l_my.i_num;
            l_z.s = num1.s;
        } else {
            resultM.i_num = l_my.i_num - l_mx.i_num;
            l_z.s = num2.s;
        }
    }
    if (resultM.m1 >= 2 ) {
        resultM.i_num >>= 1;
        l_z.e++;
    }
    l_z.m = resultM.m;
    return l_z;
}




union double_sep addDoubles(double a, double b) {
    union double_sep l_z ;
    union double_sep num1;
    union double_sep num2;

    num1.f_num = a;
    num2.f_num = b;

    union mantissa_double l_mx = { { .m = num1.m, .m1 = 1 } };
    union mantissa_double l_my = { { .m = num2.m, .m1 = 1 } };
    int expDiff = 0;
    unsigned int finalExp;

    if (num1.e > num2.e) {
        expDiff = num1.e - num2.e;
        l_my.i_num >>= expDiff;
        finalExp = num1.e;
    } else {
        expDiff = num2.e - num1.e;
        l_mx.i_num >>= expDiff;
        finalExp = num2.e;
    }
    l_z.e = finalExp;
    union mantissa_double resultM;
    if (num1.s == num2.s) {
        resultM.i_num = l_mx.i_num + l_my.i_num;
    } else {
        if (l_mx.i_num >= l_my.i_num) {
            resultM.i_num = l_mx.i_num - l_my.i_num;
            l_z.s = num1.s;
        } else {
            resultM.i_num = l_my.i_num - l_mx.i_num;
            l_z.s = num2.s;
        }
    }
    if (resultM.m1 >= 2 ) {
        resultM.i_num >>= 1;
        l_z.e++;
    }
    l_z.m = resultM.m;
    return l_z;
}

union double_sep multiplyDoubles(double a, double b) {
    union double_sep l_z ;
    union double_sep num1;
    union double_sep num2;

    num1.f_num = a;
    num2.f_num = b;

    l_z .s = ( num1 .s + num2 .s ) % 2;
    l_z .e = ( num1 .e + num2 .e - B );
    union mantissa_double l_mx = { { .m = num1.m, .m1 = 1 } };
    union mantissa_double l_my = { { .m = num2.m, .m1 = 1 } }, l_mz ;
    long mult = multiplyFixed(l_mx.i_num,l_my.i_num,52);

    l_mz .i_num = mult;
    if ( l_mz .m1 >= 2 )
    {
        l_mz . i_num >>= 1;
        l_z .e ++;
    }
    l_z .m = l_mz .m;
    return l_z;
}


union float_sep multiplyFloats(float a, float b) {
    union float_sep l_z ;
    union float_sep num1;
    union float_sep num2;

    num1.f_num = a;
    num2.f_num = b;

    l_z .s = ( num1 .s + num2 .s ) % 2;
    l_z .e = ( num1 .e + num2 .e - B );
    union mantissa l_mx = { { .m = num1.m, .m1 = 1 } };
    union mantissa l_my = { { .m = num2.m, .m1 = 1 } }, l_mz ;
    l_mz . i_num = ( ( long long ) l_mx . i_num ) * l_my . i_num >> 23;
    if ( l_mz .m1 >= 2 )
    {
        l_mz . i_num >>= 1;
        l_z .e ++;
    }
    l_z .m = l_mz .m;
    return l_z;
}

long factorial(long n) {
    if ( n == 1) return 1;
    return n * factorial(n - 1);
}

double sin_(double x) {
    double res = 0.0f;
    long n = 0;
    while (1) {
        int exp = 2 * n + 1;
        double currentFactorial = (double)factorial(exp);
        double currentX = x;
        for (int i = 1; i < exp; i++) {
            currentX = multiplyDoubles(currentX,x).f_num;
        }
        double term = divideDoubles(currentX, currentFactorial).f_num;
        printf("%lf\n",term);
        if (term <= 0.000001f) {
            break;
        }
        if (n % 2 == 1) {
            res  = addDoubles(res,-term).f_num;
        } else {
            res  = addDoubles(res,term).f_num;
        }
        n++;
        if (n >= 6) break;
    }
    return res;
}


void printFloatManual(union float_sep num) {
    union mantissa val = { .m = num.m, .m1 = 1 };
    int exp  = num.e - B;
    int shift = 23 - exp;
    printf("%u.",val.i_num >> shift);
    int mask = (1U << shift) - 1;
    int floatNum = val.i_num & mask;
    float sum = 0.0f;
    int curExp = 1;
    for (int i = 1; i <= shift; ++i){
        if ((floatNum >> (shift - i)) & 1) {
            sum += powf(2.0f, -i);
        }
    }
    char buffer[64];
    sprintf(buffer, "%f", sum);

    printf("%s", &buffer[2]);

}


int main(void) {
    double pi = 3.24;
    double e = 2.1;
    double sinCalc = sin_(3.14159 / 4);
    printf("%lf\n", sinCalc);
    return 0;
}
