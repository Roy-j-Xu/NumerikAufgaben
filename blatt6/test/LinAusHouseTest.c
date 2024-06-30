#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "LinAusHouse.h"


int main()
{
    double M[3][2] = {
        {1, 2},
        {3, 4},
        {5, 6}
    };
    double B[3] = {3, 7, 11};
    double* A = (double*) &M;
    double* b = (double*) &B;

    double error = LinAusHouse(A, b, 3, 2);

    printf("b = ");
    printVector(b, 3);
    printf("error = %f", error);
}