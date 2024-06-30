import math

from FDM_heat import *

if __name__ == "__main__":
    """
    Stability condition dt <= dx ^ 2 / (2 * alpha) needs to be satisfied, 
    otherwise the approximation explodes as time moves on.
    """
    L = math.pi
    t_max = 1
    alpha = 1
    def T0(x):
        return math.sin(x)
    a = T0(0)
    b = T0(L)
    x_mesh = 100
    t_mesh = 100

    solve_heat_equation_plot(L, t_max, alpha, a, b, T0, x_mesh, t_mesh)