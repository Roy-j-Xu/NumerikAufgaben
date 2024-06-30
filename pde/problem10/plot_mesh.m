function plot_mesh(X, E)
hold on;
triplot(E, X(:, 1), X(:, 2), '-');
scatter(X(:, 1), X(:, 2), '.', 'b');
end