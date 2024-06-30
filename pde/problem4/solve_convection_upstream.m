function u = solve_convection_upstream(N, nu)
% Solve convection-diffusion equation on the domain (0, 1) with y(0) = 0 
% and y(1) = 1, using upstream method.

h = 1 / (N + 1);
c_a = (1 + nu * h);
const = 1 ./ (1 - power(c_a, N+1));
u = const * (1 - power(c_a, 0:N+1));

end