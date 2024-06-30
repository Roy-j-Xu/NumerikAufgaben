function problem_ii()
% From the image, error of central method seem to be O(h^2). This can be
% explained by the fact that the errors of discrete estimations used in this
% method are O(h^2).
% The error of upstream method seem to be O(h). The reason can be that the
% the backwards difference has error O(h).

nu = [10, 50, 200];
N = 2 .^ (3:10);
h = 1 ./ (N + 1);

for i = 1:3
    norm_data_central = zeros(1, 8);
    norm_data_upstream = zeros(1, 8);
    for j = 1:8
        norm_data_central(j) = norm_inf_to_exact_solution( ...
                            solve_convection_central(N(j), nu(i)), ...
                            nu(i));
        norm_data_upstream(j) = norm_inf_to_exact_solution( ...
                            solve_convection_upstream(N(j), nu(i)), ...
                            nu(i));
    end

    subplot(1, 3, i);
    set(gca, 'XScale', 'log')
    set(gca, 'YScale', 'log')
    xlabel("h")
    title("\nu = " + nu(i));

    hold on;
    plot(h, norm_data_central, DisplayName="Central");
    plot(h, norm_data_upstream, DisplayName="Upstream");
    plot(h, h, "--", DisplayName="h");
    plot(h, h.*h, "--", DisplayName="h^2");
    legend show;

end

end

function norm = norm_inf_to_exact_solution(u, nu)
const = 1 / (exp(nu) - 1);
y = @(t) const * (exp(nu * t) - 1);

n = size(u, 2);
X = linspace(0, 1, n);
u_exact = y(X);
norm = max(abs(u - u_exact), [], "all");

end