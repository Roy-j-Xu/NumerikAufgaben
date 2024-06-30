#include "helper.h"

// Here sign(0) = 1
int sign(double x)
{
    if (x >= 0) return 1;
    return -1;
}

int MIN(int a, int b) 
{
    return (a < b) ? a : b;
}

double** initMatrix(int m, int n)
{
    double** matrix = (double**) malloc(m * sizeof(double*));
    for (int row = 0; row < m; ++row)
    {
        matrix[row] = (double*) malloc(n * sizeof(double));
    }
    return matrix;
}

// Dot product of 2 vectors
double dot(double** v1, double** v2, int size)
{
    double result = 0;
    for (int i = 0; i < size; ++i)
    {
        result += (*v1[i]) * (*v2[i]);
    }
    return result;
}

// Add a multiple of second vector to the first vector in place
void addMultipleTo(double** v1, double** v2, double multiple, int size)
{
    for (int i = 0; i < size; ++i)
    {
        *v1[i] += multiple * (*v2[i]);
    }
}

// Get column vector of a matrix. The output vector stores the address of v_i in vector[i]
double** columnVector(double* A, int n_rows, int n_cols, int col, int startRow)
{
    int size = n_rows - startRow;
    double** vector = malloc(size * sizeof(double*));
    for (int row = startRow; row < n_rows; ++row)
    {
        vector[row - startRow] = A + row * n_cols + col;
    }
    return vector;
}


void printSubvector(double** v, int n)
{
    printf("( ");
    for (int i = 0; i < n; ++i)
    {
        printf("%f ",*(v[i]));
    }
    printf(")\n");
}

void printVector(double* v, int n)
{
    printf("( ");
    for (int i = 0; i < n; ++i)
    {
        printf("%f ",v[i]);
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
            printf("%f\t",M[i][j]);
        }
        printf("|\n");
    }
}