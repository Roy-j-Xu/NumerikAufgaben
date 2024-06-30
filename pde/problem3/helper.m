classdef helper
    methods(Static)

        function plot_u(u, a)
            L = size(u, 1);
            [X, Y] = meshgrid(linspace(0, a, L), linspace(0, a, L));
            mesh(X, Y, u)
        end

        function norm = norm_inf(a, u, y)
        % Calculate || u - y ||_inf on [0, a] x [0, a] with L grid points. 
        % y can be either a function or an approximation. 
        % 
        % For this function to work, u must be a matrix. y can be either a 
        % function or a matrix.
            if isa(y, "function_handle")
                L = size(u, 1);
                [X, Y] = meshgrid(linspace(0, a, L), linspace(0, a, L));
                norm = max(abs(u - y(X, Y)), [], "all");
            else
                norm = helper.norm_inf_for_matricies(y, u);
            end
        end

        function norm = norm_inf_for_matricies(u1, u2)
        % Given u1 u2 two discrete data of functions on the same square
        % region, try to fit one into another in order to approximate the
        % inf-distance of the two functions.
        %
        % Let l_i = size(u_i). In order for this function to work, we must
        % have either l1 | l2 or l2 | l1.
            l1 = size(u1, 1) - 1;
            l2 = size(u2, 1) - 1;
            if l1 < l2
                norm = helper.norm_inf_for_matricies(u2, u1);
                return
            end
            if rem(l1, l2) == 0
                skip = l1 / l2;
                norm = max(abs(u1(1:skip:end, 1:skip:end) - u2), [], "all");
            else
                error("Data not compatible.")
            end
        end

    end

    properties(Constant)
        % Functions used in problem (iii) and (iv).
        f = {@(X, Y) ones( max(size(X), size(Y)) ), ...
             @(X, Y) 8*pi*pi*sin(2*pi*X).*cos(2*pi*Y), ...
             @(X, Y) ones( max(size(X), size(Y)) )};

        g = {@(X, Y) (1 - (X-0.5).*(X-0.5) - (Y-0.5).*(Y-0.5))/4, ...
             @(X, Y) sin(2*pi*X).*cos(2*pi*Y), ...
             @(X, Y) zeros( max(size(X), size(Y)) )};
    end
end

