function [u, N, X, E] = solve_poisson_equation(mesh_file_name, f, g)
[M, Ma, N, X, E] = extract_mesh(mesh_file_name);
A = helper1.stiffness_matrix(M, Ma, N, X, E);
b = helper2.calculate_b(M, Ma, N, X, E, f);

g_A = calculate_g_A(M, Ma, X, g);
A_II = A(1:M, 1:M);
A_IA = A(1:M, M+1:M+Ma);
f_I = b(1:M)';

u = zeros(M + Ma, 1);
u(1:M) = A_II \ (f_I - A_IA * g_A);
u(M+1:M+Ma) = g_A;
end

function g_A = calculate_g_A(M, Ma, X, g)
g_A = zeros(Ma, 1);
X_A = X(:, M+1:M+Ma);
g_A(:) = g(X_A(1, :), X_A(2, :));
end