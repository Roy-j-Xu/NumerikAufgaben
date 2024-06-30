classdef helper
    methods(Static)

        function plot_in_L_shape(func, step_size)
        % Plot function in L-shaped region omega
            helper.plot_in_rect(func, -0.5, 0, 0, 0.5, step_size);
            hold on
            helper.plot_in_rect(func, -0.5, 0.5, -0.5, 0, step_size);
        end

        function plot_in_rect(func, x_min, x_max, y_min, y_max, step_size)
        % Plot function in area [x_min, x_max] x [y_min, y_max]
            [X, Y] = meshgrid(x_min:step_size:x_max, y_min:step_size:y_max);
            Z = func(X, Y);
            mesh(X, Y, Z);
            xlabel("x")
            ylabel("y")
        end

        function xy_func = xy_function(polar_func)
        % Decorates functions that take in polar coordinates and makes them
        % take in Euclidean coordinates instead.
            function z = wrapper(x, y)
                [r, phi] = helper.to_polar(x, y);
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