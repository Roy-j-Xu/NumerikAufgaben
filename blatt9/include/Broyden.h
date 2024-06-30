#pragma once
#include "helper.h"

int Broyden(int d, Map f, double* x, double** B, int N, double tol, int* n);