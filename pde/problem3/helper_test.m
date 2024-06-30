classdef helper_test < matlab.unittest.TestCase
    
    methods(Test)
        % Test methods
        
        function generate_b_test(testCase)
            f = @(X, Y) X + Y;
            g = @(X, Y) X + Y;
            b = helper.generate_b(1, f, g, 4);
            b_correct = [0.5312, 0.5469, 2.0625, 0.5469, 0.0625, 1.5781, ... 
                2.0625 ,1.5781 ,3.5938]';
            e = max(abs(b - b_correct));
            testCase.assertTrue(e < 0.001);
        end

        function generate_A_test(testCase)
            A = helper.generate_A(3);
            A_correct = [ ...
                [4    -1    -1     0]; ...
                [-1    4     0    -1]; ...
                [-1    0     4    -1]; ...
                [0    -1    -1     4] ...
            ];
            testCase.assertEqual(full(A), A_correct)
        end

        function poisson_test(testCase)
            f = @(X, Y) 8*pi*pi*sin(2*pi*X).*cos(2*pi*Y);
            g = @(X, Y) sin(2*pi*X).*cos(2*pi*Y);
            u = solve_poisson_equation(1, f, g, 128);
            helper.plot_u(u, 1)
        end

    end
    
end