#include "HouseQR.h"

double* HouseQR(double* A, int m, int n)
{
    double* alpha = malloc(MIN(m, n) * sizeof(double));
    int max_col = MIN(m - 1, n);
    for (int j = 0; j < max_col; ++j)
    {
        double** currentCol = columnVector(A, m, n, j, j);
        int currentColSize = m - j;
        // Calculate alpha for each column
        alpha[j] = - sign(A[j * n + j]) * sqrt( dot(currentCol, currentCol, currentColSize) );

        // Calculate v and store it in the current column
        A[j * n + j] -= alpha[j];

        // Calculate -<v, v> = alpha * v1
        double beta = alpha[j] * A[j * n + j];

        // Calculate QT at the bottom right corner
        for (int l = j + 1; l < n; ++l)
        {
            // Calculate v_x = −2(vT x)/(vT v)
            double** columnL = columnVector(A, m, n, l, j);
            double vx = dot(currentCol, columnL, currentColSize) / beta;

            // Calculate Qx = x + v_x v
            addMultipleTo(columnL, currentCol, vx, currentColSize);
        }
    }

    return alpha;
}