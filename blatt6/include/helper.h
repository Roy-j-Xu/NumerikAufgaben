#pragma once
#include <stdlib.h>
#include <stdio.h>

// Here sign(0) = 1
int sign(double x);

int MIN(int a, int b);

double** initMatrix(int m, int n);

// Dot product of 2 vectors
double dot(double** v1, double** v2, int size);

// Add a multiple of second vector to the first vector in place
void addMultipleTo(double** v1, double** v2, double multiple, int size);

// Get column vector of a matrix. The output vector stores the address of v_i in vector[i]
double** columnVector(double* A, int n_rows, int n_cols, int col, int startRow);

void printSubvector(double** v, int n);

void printVector(double* v, int n);

void printMatrix(double** M, int m, int n);