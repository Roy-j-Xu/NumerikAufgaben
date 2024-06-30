#include <stdio.h>
#include <math.h>

double Exp(double x, int n)
{
    double result = 1;
    for (int i = 0; i < n; i++) {
        result *= x;
        result /= n-i;
        result++;
    }
    return result;
}

void main(void)
{
    double realVal = exp(-5.5);
    double M1, M2, M3;
    for (int n = 3; n <= 30; n += 3) {
        M1 = Exp(-5.5, n);
        M2 = 1/Exp(5.5, n);
        M3 = pow(Exp(0.5, n), -11);

        // Taylor series for exp(x) converges the fastest when x is positive and around 0
        printf("Errors are E1 = %f, E2 = %f, E3 = %f\n", realVal-M1, realVal-M2, realVal-M3);
    }
}