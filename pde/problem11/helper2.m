classdef helper2
    % This helper class deals with integrals on the right-hand side.
    
    methods(Static)

        function b_tildes = calculate_elem_bs(N, X, E, f)
        % Computes b_tilde for each element, returns an array of b_tilde,
        % in the form of 2-tensor of shape (3, N).
        % b_tildes(:,)
            [b1, b2] = helper1.reference_matrices(X, E);
            dets = helper1.calculate_dets(b1, b2);

            b_tildes = zeros(3, N);
            for elem = 1:N
                nodes = E(:, elem);
                % Here, using notations on (9.20), we have
                % N_i(eta^(k)) = delta_ik. 
                % So we only add the terms where i = k.
                for i = 1:3
                    node = nodes(i);
                    b_tildes(i, elem) = b_tildes(i, elem) + ...
                        f(X(1, node), X(2, node)) * dets(elem);
                end
            end
            % Multiply by w_k = 1/6.
            b_tildes = b_tildes / 6;
        end

        function b = calculate_b(M, Ma, N, X, E, f)
        % Calculate b_tilde for each element, then assemble them into a
        % complete vector b.
            b_tildes = helper2.calculate_elem_bs(N, X, E, f);

            b = zeros(1, M + Ma);
            for elem = 1 : N
                nodes = E(:, elem);
                for i = 1:3
                    b(nodes(i)) = b(nodes(i)) + b_tildes(i, elem);
                end
            end
        end

    end
    
end

