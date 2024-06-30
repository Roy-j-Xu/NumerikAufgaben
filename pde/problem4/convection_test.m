function convection_test()
N= [10, 50, 100];
nu = [10, 50, 200];

for i = 1:3
    for j = 1:3
        subplot(3, 3, 3*(i-1) + j)
        plot_solutions(N(i), nu(j));
    end
end

end

function plot_solutions(N, nu)
X = linspace(0, 1, N+2);

plot(X, solve_convection_central(N, nu), DisplayName="Central");
hold on;
plot(X, solve_convection_upstream(N, nu), DisplayName="Upstream");
legend show;

title("N = " + N + ", \nu = " + nu);

end