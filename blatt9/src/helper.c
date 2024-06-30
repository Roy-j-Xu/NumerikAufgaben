#include "helper.h"

void functionOutput(int dim, Map f, double* x, double* y)
{
    double* output = f(x);
    for (int i = 0; i < dim; ++i)
    {
        y[i] = output[i];
    }
    free(output);
}

double **initEmptyMatrix(int m, int n)
{
    double** matrix = (double**) malloc(m * sizeof(double*));
    for (int row = 0; row < m; ++row)
    {
        matrix[row] = (double*) malloc(n * sizeof(double));
    }
    return matrix;
}

double** initMatrix(int m, int n, double* A)
{
    double** matrix = initEmptyMatrix(m, n);
    for (int row = 0; row < m; ++row)
    {
        for (int col = 0; col < n; ++col)
        {
            matrix[row][col] = A[row * n + col];
        }
    }
    return matrix;
}

void freeMatrix(int m, int n, double** matrix)
{
    for (int row = 0; row < m; ++row)
    {
        free(matrix[row]);
    }
    free(matrix);
}

void negative(double* v, double* neg_v, int size)
{
    for(int i = 0; i < size; ++i)
    {
        neg_v[i] = -v[i];
    }
}

void addTo(double* v1, double* v2, int size)
{
    for (int i = 0; i < size; ++i)
    {
        v1[i] += v2[i];
    }
}

void addMultipleTo(double* v1, double multiple, double* v2, int size)
{
    for (int i = 0; i < size; ++i)
    {
        v1[i] += multiple * v2[i];
    }
}

void multiple(double* v, double multiple, int size)
{
    for (int i = 0; i < size; ++i)
    {
        v[i] *= multiple;
    }
}

double dot(double* v1, double* v2, int size)
{
    double result = 0;
    for (int i = 0; i < size; ++i)
    {
        result += v1[i] * v2[i];
    }
    return result;
}

void printVector(double* v, int n)
{
    printf("(");
    for (int i = 0; i < n; ++i)
    {
        printf("%g",v[i]);
        if (i != n - 1)
        {
            printf(", ");
        }
    }
    printf(")\n");
}

void printMatrix(double** M, int m, int n)
{
    for (int i = 0; i < m; ++i)
    {
        printf("| ");
        for (int j = 0; j < n; ++j)
        {
            printf("%.5g\t",M[i][j]);
        }
        printf("|\n");
    }
}

int* idPermutation(int size)
{
    int* p = malloc(size * sizeof(int));
    for (int i = 0; i < size; ++i)
    {
        p[i] = i;
    }
    return p;
}