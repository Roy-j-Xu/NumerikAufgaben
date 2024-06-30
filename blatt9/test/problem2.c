#include <math.h>
#include "Broyden.h"


double* problem2Func(double* x)
{
    double* output = (double*) malloc(2 * sizeof(double));
    output[0] = (x[0] + 3) * (x[1]*x[1]*x[1] - 7) + 18;
    output[1] = sin(x[1] * exp(x[0]) - 1);
    return output;
}

double** prob2Jacobian(double* x)
{
    double u = x[0];
    double v = x[1];
    double jacobian[2][2] = {
        {v*v*v - 7, 3*(u+3)*v*v},
        {exp(u)*v*cos(exp(u)*v + 1), exp(u)*cos(exp(u)*v + 1)}
    };
    return initMatrix(2, 2, (double*) jacobian);
}

void testWithInitialVector(double* x0)
{
    int* n = (int*) malloc(sizeof(int));

    // Let B0 be the Jacobian matrix at x0
    double** B0 = prob2Jacobian(x0);

    printf(".......................\n");
    printf("With x0 = ");
    printVector(x0, 2);
    printf("we have: ");

    // Flag indicates if the calculation is successful
    int flag = Broyden(2, problem2Func, x0, B0, 80, 1e-12, n);

    printf("flag = %i, steps = %i.\nThe zero point x = ", flag, *n);
    printVector(x0, 2);
    printf("To varify this is indeed a zero point, we have f(x) = ");
    printVector(problem2Func(x0), 2);
    printf(".......................\n");

    free(n);
    freeMatrix(2, 2, B0);
}

int main()
{
    double x0[2] = {-0.14, -1.47};
    testWithInitialVector(x0);

    double X0[2] = {-0.5, 1.4};
    testWithInitialVector(X0);

    return 0;
}
