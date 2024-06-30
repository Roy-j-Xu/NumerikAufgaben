function problem_iii()
a = 1;
l = 2^7;

for i = 1:3
    u = solve_poisson_equation(a, helper.f{i}, helper.g{i}, l);
    subplot(2, 2, i);
    helper.plot_u(u, a);
    title("Equation " + char(i + 96));
end

end