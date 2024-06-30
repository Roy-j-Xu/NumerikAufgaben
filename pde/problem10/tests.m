classdef tests < matlab.unittest.TestCase

    methods (Test)

        function plot_mesh_test(testCase)
            [~, ~, ~, X, E] = extract_mesh("test_mesh.txt");
            plot_mesh(X, E);
        end

        % function plot_mesh_test_prob1(testCase)
        %     [~, ~, ~, X, E] = extract_mesh("sheet10_prob1_mesh.txt");
        %     plot_mesh(X, E);
        % end

    end

end