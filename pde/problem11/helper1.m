classdef helper1
    % This helper class deals with stiffness matrix.
    methods(Static)

        function [b1, b2] = reference_matrices(X, E)
        % Given grid data, output the reference matrices B for all elements.
        % Instead of outputing a list of matrices, this function output an
        % array of b1 and b2, where B = (b1^t, b2^t).
        % bi(:, n) represents the b_i of the n-th element.
            b1 = X(:, E(2, :)) - X(:, E(1, :));
            b2 = X(:, E(3, :)) - X(:, E(1, :));
        end

        function dets = calculate_dets(b1, b2)
        % Calculate an array of |det B| given an array of b1 and b2.
        % dets(n) stores the value of |det B_Tn|, where Tn is the n-th
        % element.
            dets = abs( b1(1, :).*b2(2, :) - b2(1, :).*b1(2, :) );
        end

        function gammas = calculate_gammas(N, X, E)
        % Calculate all gamma for all elements.
        % gammas(i, n) represents gamma_i of the n-th element.
            [b1, b2] = helper1.reference_matrices(X, E);
            dets = helper1.calculate_dets(b1, b2);

            gammas = zeros(3, N);
            gammas(1, :) = dot(b2, b2);
            gammas(2, :) = - dot(b1, b2);
            gammas(3, :) = dot(b1, b1);
            gammas = gammas ./ dets;
        end

        function A_tildeTs = elem_stiffness_matrices(N, X, E)
        % Calculate local stiffness matrices for all elements, returns an
        % array of 3x3 matrices, in the form of 3-tensor of shape (3, 3, N).
        % A_tildeTs(:, :, n) represents the n-th local stiffness matrix.
            gammas = helper1.calculate_gammas(N, X, E);

            A_tildeTs = zeros(3, 3, N);
            for i = 1 : N
                A_tildeTs(:, :, i) = ...
                    gammas(1, i) * helper1.S1 + ...
                    gammas(2, i) * helper1.S2 + ...
                    gammas(3, i) * helper1.S3;
            end
        end

        function A = stiffness_matrix(M, Ma, N, X, E)
        % Calculate local stiffness matrices, then assemble them into the 
        % complete stiffness matrix.
            A_tildeTs = helper1.elem_stiffness_matrices(N, X, E);

            A = spalloc(M + Ma, M + Ma, N * 9);
            for elem = 1 : N
                nodes = E(:, elem);
                A_tildeT = A_tildeTs(:, :, elem);
                for i = 1:3
                    for j = 1:3
                        A(nodes(i), nodes(j)) = ...
                            A(nodes(i), nodes(j)) + A_tildeT(i, j);
                    end
                end
            end

        end
        
    end

    properties(Constant)
        S1 = [1, -1, 0; -1, 1, 0; 0, 0, 0] / 2;
        S2 = [2, -1, -1; -1, 0, 1; -1, 1, 0] / 2;
        S3 = [1, 0, -1; 0, 0, 0; -1, 0, 1] / 2;
    end
end

