#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include  <stdint.h>

void koule( float polomer, float *povrch, float *objem,float PI );
double eX(double x,int n);
double lnX(double x,int n);
int main(void) {
    float povrch = 0.0f;
    float objem = 0.0f;
    float pi = 3.14;
    koule(1.2,&povrch,&objem,pi);
    double aproxE = eX(3.0,40);
    printf("Povrch= %f, Objem =%f\n",povrch,objem);
    printf("%lf\n",aproxE);

    double aproxLnE = lnX(3.0,50);
    printf("%lf\n",aproxLnE);
    return 0;
}
