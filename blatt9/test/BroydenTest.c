#include <stdio.h>
#include "Broyden.h"

double* square(double* x)
{
    double* output = (double*) malloc(sizeof(double));
    double X = x[0];
    double Y = x[1];
    output[0] = X * X - 4;
    output[1] = Y * X - 2;
    return output;
}

int main()
{
    double B_init[2][2] = {{1, 0}, {0, 1}};
    double** B = initMatrix(2 ,2 , (double*) B_init);
    double x[2] = {1, 1};
    int* n = (int*) malloc(sizeof(int));
    int flag = Broyden(2, square, x, B, 20, 0.01, n);

    printf("flag = %i, steps = %i\n", flag, *n);
    printVector(x, 2);

    freeMatrix(B);
    free(n);

    return 0;
}
