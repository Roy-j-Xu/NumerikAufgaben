function problem_iv()
% Uses infinity norm to measure the distance between the numerical solution
% and the exact solution. Plots the relation between h and the error.
%
% In the plotting result, the errors of (b) and (c) appear to be O(h^2), 
% which is consistent with Satz 2.13. I cannot explain what is happening 
% to (a).
a = 1;
L = 2 .^ (2:7);
h = a ./ L;

% Numerical solution of equation (c)
y3 = solve_poisson_equation(a, helper.f{3}, helper.g{3}, 2^7);

for i = 1:3
    norm_data = zeros(1, 6);
    for j = 1:6
        l = L(j);
        u = solve_poisson_equation(a, helper.f{i}, helper.g{i}, l);
        if i ~= 3
            norm_data(j) = helper.norm_inf(a, u, helper.g{i});
        else
            % For equation (c), use numerical solution for l = 2^7 as 
            % reference.
            norm_data(j) = helper.norm_inf(a, u, y3);
        end
    end
    
    subplot(2, 2, i);
    title("Equation " + char(i + 96))
    set(gca, 'XScale', 'log')
    set(gca, 'YScale', 'log')
    xlabel("h")
    hold on
    plot(h, norm_data, "DisplayName", "|| u - y ||_\infty");
    plot(h, h, "DisplayName", "h");
    plot(h, h.*h, "DisplayName", "h^2");
    legend show

end

end