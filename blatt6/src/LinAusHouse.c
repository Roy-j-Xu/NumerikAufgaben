#include <math.h>
#include "HouseQR.h"
#include "vorrueckwaertsub.h"

// Given result of HouseQR and vector b, calculate and store Q^tb in b
void Qtb(double* A, double* alpha, double* b, int m, int n)
{
    for (int j = 0; j < MIN(m - 1, n); ++j)
    {
        int currentSize = m - j;
        double** bSection = columnVector(b, m, 1, 0, j);
        double** v = columnVector(A, m, n, j, j);

        // printVector(b, m);

        // Calculate -<v, v> = alpha * v1
        double beta = alpha[j] * A[j * n + j];

        // Calculate v_b = −2<v, b>/<v, v>
        double vb = dot(v, bSection, currentSize) / beta;

        // Calculate Qb = b + v_b v
        addMultipleTo(bSection, v, vb, currentSize);
    }
    // printVector(b, m);
}

// Given result of HouseQR, return R represented by a double pointer. Here m >= n.
double** getR(double* A, double* alpha, int n)
{
    double** R = initMatrix(n, n);
    for (int i = 0; i < n; ++i)
    {
        R[i][i] = alpha[i];
        for (int j = 0; j < n; ++j)
        {
            if (j > i) R[i][j] = A[i * n + j];
            if (j < i) R[i][j] = 0;
        }
    }
    // printMatrix(R, n, n);
    return R;
}

// Calculate solution bar{x} and store it in b. Return mean square error.
double LinAusHouse(double* A, double* b, int m, int n)
{
    // Perform HouseQR
    double* alpha = HouseQR(A, m, n);

    // Calculate and store Q^tb = (b_1, b_2) in b
    Qtb(A, alpha, b, m, n);

    // Get matrix R
    double** R = getR(A, alpha, n);

    // Solve Rx = b_1, here b_1 has size n
    rwsubs(n, R, b);

    // Calculate mean square error = |b_2|
    double** b2 = columnVector(b, m, 1, 0, n);
    double error = sqrt(dot(b2, b2, m - n));

    return error;
}

