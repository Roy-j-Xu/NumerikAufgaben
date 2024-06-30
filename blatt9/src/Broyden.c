#include "Broyden.h"
#include "lrmp.h"

void rang1Update(int dim, double** B, double* d, double* fx)
{
    double d2 = dot(d, d, dim);
    for (int i = 0; i < dim; ++i)
    {
        for (int j = 0; j < dim; ++j)
        {
            B[i][j] += fx[i] * d[j] / d2; 
        }
    }    
}

int Broyden(int dim, Map f, double* x, double** B, int N, double tol, int* n)
{
    double tol2 = tol * tol;
    int* p = idPermutation(dim);
    double* fx = f(x);
    double* d = (double*) malloc(dim * sizeof(double));

    for (int time = 0; time < N; ++time)
    {
        // Set d to be -f(x)
        negative(fx, d, dim);

        // Solve B^(k) d^(k) = -f(x^(k))
        Solve(dim, B, d, p);

        // Update x and f(x)
        addTo(x, d, dim);
        functionOutput(dim, f, x, fx);

        // Update B
        rang1Update(dim, B, d, fx);

        // Check if precision is good enough
        if (dot(d, d, dim) < tol2)
        {
            free(p);
            free(fx);
            free(d);
            // Output number of iterations
            *n = time;
            return 0;
        }

    }
    free(p);
    free(fx);   
    free(d);
    *n = N; 
    return -1;
}