function Problem_ii()
    L = pi;
    t_max = [1, 2, 2];
    alpha = 1;
    a = 0;
    b = 0;
    x_mesh = [10, 50, 60];
    t_mesh = [10, 1000, 1000];
    for i = 1:3
        subplot(2, 2, i)
        solve_heat_equation(L, t_max(i), alpha, a, b, @sin, x_mesh(i), t_mesh(i));
        title( ...
            "t\_max = " + t_max(i) + ", " + ...
            "x\_mesh = " + x_mesh(i) + ", " + ...
            "t\_mesh = " + t_mesh(i));
    end
end