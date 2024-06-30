function Problem_iii()
    % Approximation explodes when the stability condition
    % dt <= dx ^ 2 / (2 * alpha) is not satistied.
    T_sol = solve_heat_equation(pi, 2, 1, 0, 0, @sin, 50, 500);
end