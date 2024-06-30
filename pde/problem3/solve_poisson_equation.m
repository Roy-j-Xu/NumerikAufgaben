function u = solve_poisson_equation(a, f, g, l)
% Solve Poisson equation on a square region using FDM with 5-point-stencil.
% The equation is given by:
%
%   -\delta y = f,  inside \Omega
%           y = g,  on \partial\Omega.
%
% In FDM, we solve the derived linear equation:
%
%       A_h u_bar = b,
%
% or equivalently solving
%
%         A u_bar = h^2 * b,
%
% where A_h is of size (l-1)^2 x (l-1)^2. Here b = b0 + h^(-2) * b1. b0(i)
% is given by the value of f at the i-th grid point. b1(i) = the sum of all 
% g(x) where x a neighbor of the i-th grid point that is on the boundary.
%
%
% Inputs:
%   a   : specify the square region to be (0, a)^2.
%   f   : -\delta y = f.
%   g   : Dirichlet boundary condition.
%   l   : number of grid points minus 1.
%
% Outputs:
%   u   : a matrix approximating the solution.
if l <= 2
    error("`l` has to be an integer greater than 2.");
end

u = init_u(a, g, l);
b = generate_b(a, f, u);
A = generate_A(l);

R = chol(A);
u_bar = (R \ (R' \ b));

u(2:end-1, 2:end-1) = reshape(u_bar', [l-1, l-1]);

end

function b = generate_b(a, f, boundary)
% Calculate h^2 * b = h^2 * b0 + b1. 
%
% Here, the argument boundary is the discrete data of boundary condition,
% which can be obtained by using helper function init_u.
    l = size(boundary, 1) - 1;
    [X_full, Y_full] = meshgrid(linspace(0, a, l+1), linspace(0, a, l+1));
    X = X_full(2:end-1, 2:end-1);
    Y = Y_full(2:end-1, 2:end-1);

    % Calculate h^2 * b0.
    h = a / l;
    b = h*h * f(X, Y);

    % Adding b1 part.
    % Here size(b) = (l-1, l-1), size(boundary) = (l+1, l+1).
    b(1, :) = b(1, :) + boundary(1, 2:end-1);
    b(end, :) = b(end, :) + boundary(end, 2:end-1);
    b(:, 1) = b(:, 1) + boundary(2:end-1, 1);
    b(:, end) = b(:, end) + boundary(2:end-1, end);

    % Flatten b into a vector.
    b = reshape(b, 1, []).';
end

function A = generate_A(l)
% Generate A = h^2 A_h.
    N = l-1;
    size = N * N;
    pattern = repmat([-1, -1, 4, -1, -1], size, 1);
    for i = 1:N-1
        pattern(i * N, 2) = 0;
        pattern(i * N + 1, 4) = 0;
    end
    A = spdiags(pattern, [-N, -1, 0, 1, N], size, size);
end

function u = init_u(a, g, l)
% Generate a matrix u of size (l+1) x (l+1). Enforce boundary condition on
% u. The "inside" of u will later be filled with numerical solution
% (sounds kind of weird).
    V = linspace(0, a, l+1);
    u = zeros(l+1, l+1);

    u(1, :) = g(V, 0);
    u(end, :) = g(V, a);
    u(:, 1) = g(0, V);
    u(:, end) = g(a, V);
end