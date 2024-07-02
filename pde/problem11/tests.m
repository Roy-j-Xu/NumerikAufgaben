classdef tests < matlab.unittest.TestCase

    methods(Test)

        function solve_poisson_equation_test1(testCase)
        % Problem (iv)
            f = @(x, y) 1;
            g = @(x, y) 0;

            [u, N, X, E] = solve_poisson_equation("equidist.txt", f, g);

            subplot(1, 2, 1);
            plot_solution(u, N, X, E);
            title("(iv)");
        end

        function solve_poisson_equation_test2(testCase)
        % Problem (v)
            f = @(x, y) 0;
            g_polar = @(r, phi) r.^(2/3) .* sin( (2*phi - pi)/3 );
            g = tests.xy_function(g_polar);

            [u, N, X, E] = solve_poisson_equation("L-shape.txt", f, g);

            subplot(1, 2, 2);
            plot_solution(u, N, X, E);
            title("(v)");
        end

    end


    methods(Static)
    % Helper functions from homework 2

        function xy_func = xy_function(polar_func)
        % Decorates functions that take in polar coordinates and makes them
        % take in Euclidean coordinates instead.
            function z = wrapper(x, y)
                [r, phi] = tests.to_polar(x, y);
                z = polar_func(r, phi);
            end
            xy_func = @wrapper;
        end
        
        function [r, phi] = to_polar(x, y)
        % Transformation from Euclidean to polar coordinates
            r = sqrt(x.*x + y.*y);
            % atan2(0, 0) = 0
            phi = atan2(y, x);
            % Make sure phi is in [pi/2, 2*pi]
            phi(phi <= 0) = phi(phi <= 0) + 2*pi;
        end
    end


end