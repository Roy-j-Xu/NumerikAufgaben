#include <math.h>
#include "Broyden.h"

double p[3] = {-3, 2, 0};
double q[3] = {0, 0, 4};
double m[3] = {10, 13, 6};

double functionComponent(int i, int index, double x1, double x2)
{
    double P = p[i] - x1;
    double Q = q[i] - x2;
    double d = pow(P*P + Q*Q, 1.5);
    if (index == 0)
    {
        return m[i] * P / d;
    }
    else
    {
        return m[i] * Q / d;
    }
}

double* problem3Func(double* x)
{
    double* output = malloc(2 * sizeof(double));
    output[0] = 0;
    output[1] = 0;
    for (int i = 0; i < 3; ++i)
    {
        output[0] += functionComponent(i, 0, x[0], x[1]);
        output[1] += functionComponent(i, 1, x[0], x[1]);
    }
    return output;
}

// Difference quotient
double** jacobianApprox(double* x0, double h)
{
    double** B = malloc(2 * sizeof(double*));
    double* U0 = problem3Func(x0);

    x0[0] += h;
    double* col0 = problem3Func(x0);
    addMultipleTo(col0, -1, U0, 2);
    multiple(col0, 1/h, 2);

    x0[0] -= h;
    x0[1] += h;
    double* col1 = problem3Func(x0);
    addMultipleTo(col1, -1, U0, 2);
    multiple(col1, 1/h, 2);

    x0[1] -= h;

    B[0] = col0;
    B[1] = col1;
    double temp = B[0][1];
    B[0][1] = B[1][0];
    B[1][0] = temp;
    return B;
}

void testWithInitialValues(double* x0, double** B0)
{
    int* n = (int*) malloc(sizeof(int));

    printf(".......................\n");
    printf("With x0 = ");
    printVector(x0, 2);
    printf("and B0 = \n");
    printMatrix(B0, 2, 2);
    printf("we have: ");

    int flag = Broyden(2, problem3Func, x0, B0, 80, 1e-12, n);

    printf("flag = %i, steps = %i.\n", flag, *n);
    if (flag != 0) 
    {
        printf(".......................\n");
        return;
    }

    printf("The zero point x = ");
    printVector(x0, 2);
    printf("To varify this is indeed a zero point, we have f(x) = ");
    printVector(problem3Func(x0), 2);
    printf(".......................\n");

    free(n);
}

int main()
{
    double x0[2] = {-0.8, 0.2};
    double x1[2] = {-0.8, 0.2};
    double x2[2] = {0.5, 2.2};
    double x3[2] = {0.5, 2.2};
    double B_init[2][2] = {
        {1, 0},
        {0, 1}
    };
    double** B0 = initMatrix(2, 2, (double*) B_init);
    double** B1 = jacobianApprox(x1, 1e-5);
    double** B2 = initMatrix(2, 2, (double*) B_init);
    double** B3 = jacobianApprox(x2, 1e-5);

    testWithInitialValues(x0, B0);
    testWithInitialValues(x1, B1);
    testWithInitialValues(x2, B2);
    testWithInitialValues(x3, B3);

    freeMatrix(2, 2, B0);
    freeMatrix(2, 2, B1);
    freeMatrix(2, 2, B2);
    freeMatrix(2, 2, B3);

    return 0;
}

/*
For Broyden method, using approximation of jacobian matrix 
improves steps required for given tolerence. This is why using 
difference quotient results in less steps. Since the algorithm 
is looking for local zeros, the result may be different when 
different initial value x0 is provided.
*/
