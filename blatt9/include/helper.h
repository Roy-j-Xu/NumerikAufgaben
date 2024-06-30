#pragma once
#include <stdlib.h>
#include <stdio.h>

typedef double* (*Map)(double*);

void functionOutput(int dim, Map f, double* x, double* y);

double** initEmptyMatrix(int m, int n);

double** initMatrix(int m, int n, double* A);

void addTo(double* v1, double* v2, int size);

void addMultipleTo(double* v1, double multiple, double* v2, int size);

void multiple(double* v, double multiple, int size);

// Store -v in neg_v
void negative(double* v, double* neg_v, int size);

double dot(double* v1, double* v2, int size);

void printVector(double* v, int n);

void printMatrix(double** M, int m, int n);

int* idPermutation(int size);