from typing import Callable
import warnings
import numpy as np
import matplotlib.pyplot as plt

def solve_heat_equation(
        L: float,
        t_max: float,
        alpha: float,
        a: float,
        b: float,
        T0: Callable[[float], float],
        x_mesh: int,
        t_mesh: int
        ) -> np.array:
    """
    Function for solving 1-dimensional heat equation with Finite Difference Method.
    
    Parameters
    ----------
        L : float
            Length of rod.
        t_max : float
            Maximum time.
        alpha : float
            Diffusivity constant.
        a : float
            Constant boundary condition at left-hand-side.
        b : float
            Constant boundary condition at right-hand-side.
        T0 : Callable
            A function [0, L] -> R as initial condition.
        x_mesh : int
            Number of meshpoints in x.
        t_mesh : int
            Number of meshpoints in
    
    Returns
    ----------
        T_sol : numpy.array
            Approximation of solution stored in matrix.

    """
    # check stability condition
    dt = t_max / (t_mesh - 1)
    dx = L / (x_mesh - 1)
    if dt > dx * dx / (2 * alpha):
        warnings.warn("Stability condition dt <= dx ^ 2 / (2 * alpha) not satistied. Approximation "
                      "might behave in unpredictable manner.")

    # setting initial and boundary condition
    T_sol = np.zeros((x_mesh, t_mesh))
    X = np.linspace(0, L, x_mesh)
    for i in range(x_mesh):
        T_sol[i, 0] = T0(X[i])
    for j in range(t_mesh):
        T_sol[0, j] = a
        T_sol[-1, j] = b

    # main calculation
    scaler = alpha * dt / (dx * dx)
    for j in range(0, t_mesh - 1):
        for i in range(1, x_mesh - 1):
            T_sol[i, j+1] = T_sol[i, j] + scaler * (T_sol[i-1, j] - 2 * T_sol[i, j] + T_sol[i+1, j])

    return T_sol

def solve_heat_equation_plot(
        L: float,
        t_max: float,
        alpha: float,
        a: float,
        b: float,
        T0: Callable[[float], float],
        x_mesh: int,
        t_mesh: int
        ) -> None:
    """Solve heat equation with `solve_heat_equation` and plot the result."""
    T_sol = solve_heat_equation(L, t_max, alpha, a, b, T0, x_mesh, t_mesh) 
    X, T = np.meshgrid(np.linspace(0, L, x_mesh), np.linspace(0, t_max, t_mesh))
    
    fig, ax = plt.subplots(subplot_kw={"projection": "3d"})
    ax.set_xlabel("x")
    ax.set_ylabel("t")
    ax.set_zlabel("T")
    ax.plot_wireframe(X, T, T_sol.T)
    plt.show()