function T_sol = solve_heat_equation( ...
    L, ...
    t_max, ...
    alpha, ...
    a, ...
    b, ...
    T0, ...
    x_mesh, ...
    t_mesh...
    )
% Function for solving 1-dimensional heat equation using Finite Difference
% Method. 

% Checking stability condition
    dt = t_max / (t_mesh - 1);
    dx = L / (x_mesh - 1);
    if dt > dx * dx / (2 * alpha)
        warning("Stability condition dt <= dx ^ 2 / (2 * alpha) not satistied. " + ...
            "Approximation might behave in unpredictable manner.")
    end

% Setting initial and boundary condition
    T_sol = zeros(x_mesh, t_mesh);
    X = linspace(0, L, x_mesh);
    for i = 1 : x_mesh
        T_sol(i, 1) = T0(X(i));
    end
    for j = 1 : t_mesh
        T_sol(1, j) = a;
        T_sol(end, j) = b;
    end
    
    % Main calculation
    scaler = alpha * dt / (dx * dx);
    for j = 1 : t_mesh - 1
        for i = 2 : x_mesh - 1
            T_sol(i, j+1) = T_sol(i, j) + scaler * (T_sol(i-1, j) ...
                - 2 * T_sol(i, j) + T_sol(i+1, j));
        end
    end

    % Plotting
    [X, T] = meshgrid(X, linspace(0, t_max, t_mesh));
    mesh(X, T, T_sol.');
    xlabel("x")
    ylabel("t")
    zlabel("T")

end