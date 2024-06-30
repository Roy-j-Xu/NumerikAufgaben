#pragma once
#include "HouseQR.h"
#include "vorrueckwaertsub.h"

// Given result of HouseQR and vector b, calculate and store Q^tb in b
void Qtb(double* A, double* alpha, double* b, int m, int n);

// Given result of HouseQR, return R represented by a double pointer. Here m >= n.
double** getR(double* A, double* alpha, int n);

// Calculate solution bar{x} and store it in b. Return mean square error.
double LinAusHouse(double* A, double* b, int m, int n);