function [M, Ma, N, X, E] = extract_mesh(filename)
% Deserialize mesh data
% Outputs:
%   M   : Number of inner nodes.
%   Ma  : Number of outer nodes.
%   N   : Number of triangular elements.
%   X   : Coordinates of nodes.
%   E   : Nodes contained in each element.

meshfile = fopen(filename, "r");

M = sscanf(nextline(), '%i');
Ma = sscanf(nextline(), '%i');

X = zeros(M + Ma, 2);
for i = 1 : M + Ma
    X(i, :) = sscanf(nextline(), '%f', [1, 2]);
end

N = sscanf(nextline(), '%i');

E = zeros(N, 3);
for i = 1 : N
    E(i, :) = sscanf(nextline(), '%i', [1, 3]);
end

fclose(meshfile);

    function line = nextline()
        line = fgetl(meshfile);
    end
end