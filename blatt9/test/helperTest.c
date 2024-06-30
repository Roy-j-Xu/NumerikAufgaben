#include <stdio.h>
#include "helper.h"
#include "lrmp.h"

int main(void)
{
    double A[3][3] = {
        {1, 2, 3},
        {0, 1, 0},
        {0, 0, 2}
    };
    double** matrix = initMatrix(3 ,3, (double*) &A);
    printMatrix(matrix, 3, 3);

    double b[3] = {4, 0, 2};
    double* b_ptr = (double*) &b;

    int* p = idPermutation(3);

    Solve(3, matrix, b_ptr, p);

    printVector(b_ptr, 3); 

}