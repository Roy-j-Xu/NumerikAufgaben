#include <stdio.h>
#include "helper.h"

int main(void)
{
    double A[3][3] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };
    double* ptr = (double*) &A;

    double** v1 = columnVector(ptr, 3, 3, 0, 1);
    double** v2 = columnVector(ptr, 3, 3, 1, 1);
    double* v = v1[0];
    double value = *v;
    printf("(%f, %f)", *v1[0], *v1[1]);
    printf("(%f, %f)", *v2[0], *v2[1]);

    printf("%f", dot(v1, v2, 2));
}