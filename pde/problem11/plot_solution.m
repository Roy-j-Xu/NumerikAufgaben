function plot_solution(u, N, X, E)

x = X(1, E(:, :));
x = reshape(x, [3, N]);
y = X(2, E(:, :));
y = reshape(y, [3, N]);
z = u(E);

fill3(x, y, z, 'b');
xlabel('x');
ylabel('y');
zlabel('z');

end