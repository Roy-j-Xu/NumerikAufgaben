function [M, Ma, N, X, E] = extract_mesh(filename)
% Deserialize mesh data
% Outputs:
%   M   : Number of inner nodes.
%   Ma  : Number of outer nodes.
%   N   : Number of triangular elements.
%   X   : Coordinates of nodes, of shape (2, M + Ma).
%   E   : Nodes contained in each element, of shape (3, N).

meshfile = fopen(filename, "r");

M = sscanf(nextline(), '%i');
Ma = sscanf(nextline(), '%i');

X = zeros(2, M + Ma);
for i = 1 : M + Ma
    X(:, i) = sscanf(nextline(), '%f', [2, 1]);
end

N = sscanf(nextline(), '%i');

E = zeros(3, N);
for i = 1 : N
    E(:, i) = sscanf(nextline(), '%i', [3, 1]);
end

fclose(meshfile);

    function line = nextline()
        line = fgetl(meshfile);
    end
end