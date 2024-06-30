import math

from FDM_heat import *

if __name__ == "__main__":
    L = math.pi
    t_max = (1, 2, 2)
    alpha = 1
    def T0(x):
        return math.sin(x)
    a = T0(0)
    b = T0(L)
    x_mesh = (10, 50, 60)
    t_mesh = (10, 1000, 1000)

    for i in range(3):
        solve_heat_equation_plot(L, t_max[i], alpha, a, b, T0, x_mesh[i], t_mesh[i])