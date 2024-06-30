#include <stdio.h>
#include "HouseQR.h"

int main(void)
{

    double A[3][2] = {
        {1, 2},
        {3, 4},
        {5, 6}
    };
    double* ptr = (double*) &A;
    double* alpha = HouseQR(ptr, 3, 2);

    printf("alpha = ");
    for (int i = 0; i < 2; i++)
    {
        printf("%f ", alpha[i]);
    }
    printf("\n\n");

    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 2; j++)
        {
            printf("%f ", A[i][j]);
        }
        printf("\n");
    }

    return 0;
}