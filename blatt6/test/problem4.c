#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "..\LinAusHouse.c"


int main()
{
    // Import data
    double A[10][2] = {
        {1, 728.79},
        {1, 728.61},
        {1, 750.36},
        {1, 750.31},
        {1, 766.34},
        {1, 766.53},
        {1, 790.95},
        {1, 790.23},
        {1, 809.95},
        {1, 810.36}
    };
    double b[10] = {
        7.4960e-06, 1.0062e-05, 3.6608e-05, 3.0642e-05, 6.2065e-05,
        7.1908e-05, 3.1927e-04, 2.5538e-04, 1.0599e-03, 8.4354e-04
    };
    float r = 8.314;

    // Transform data
    int m = 10, n = 2;
    for (int i = 0; i < m; ++i)
    {
        A[i][1] = - 1/(r*A[i][1]);
        b[i] = log(b[i]);
    }

    // Call function
    double error = LinAusHouse((double*)A, (double*)b, m, n);

    printf("b = ");
    printVector(b, m - n);
    printf("logC = %f, E = %f\n", b[0], b[1]);
    printf("error = %f", error);

}