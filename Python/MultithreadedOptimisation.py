from functools import partial
from multiprocessing import Pool
from typing import Any

import numpy as np
from EnergyProtocolOptimization import *
from mpmath import *
from scipy.optimize import minimize


def optimise_partition(n: int, m: int, delta: float) -> tuple[int, int, np.ndarray]:
    """
    Optimise the partition for given values of n and m.

    Uses equal spacing as the initial guess for the optimisation process.

    Parameters
    ----------
    n : int
        Number of computational states.
    m : int
        Number of buffer states, or size of the partition.
    delta : float
        Parameter specifying the allowed error rate.

    Returns
    -------
    tuple[int, int, np.ndarray]
        (n, m, optimisation solution)
    """
    m, n = int(m), int(n)
    r0 = 1 / delta
    c_delta = -np.log(float(delta))

    x0 = np.full(m, 2 * c_delta / m)

    my_args = (n, m, r0)
    fun = lambda x: cost_fun(x, *my_args)

    cons = {"type": "eq", "fun": lambda x: np.sum(x) - 2 * c_delta}

    res = minimize(fun, x0, method="SLSQP", jac="3-point", constraints=cons)

    return (n, m, res.x)


def optimise_partition_random_start(x0: np.ndarray) -> list[tuple]:
    """
    Optimise the partition using a random initial guess.

    Designed for small partition sizes. The partition size m is implicitly
    determined from the shape of x0.

    Parameters
    ----------
    x0 : np.ndarray
        Initial random starting partition. Its shape implicitly defines the
        partition size m.

    Returns
    -------
    list[tuple]
        Description of the optimisation results, first element is whether the algorithm converged,
        second gives the value of the cost function at the optimal point found, the final element is
        the optimal partition.

    Notes
    -----
    This differs from optimise_partition in that it accepts a custom initial
    guess rather than using equal spacing, and is intended for small m values.
    """
    n, m = 10, x0.shape[0]

    delta = np.exp(-3)
    c_delta = -np.log(float(delta))
    r0 = 1 / delta

    my_args = (n, m, r0)

    fun = lambda x: cost_fun(x, *my_args)
    cons = {"type": "eq", "fun": lambda x: np.sum(x) - 2 * c_delta}

    res = minimize(fun, x0, method="SLSQP", jac="3-point", constraints=cons)

    return (res.success, res.fun, res.x)


def parallelise_random_initialisation(m: int, n_threads: int) -> list[tuple]:
    """
    Optimise partitions in parallel using random initialisations.

    Generates 10^(m-1) random initialisation points within the allowed domain and
    optimises the partition from each starting point using a process pool. The
    number of initialisations (10^(m-1)) provides reasonable coverage of the
    (m-1)-dimensional optimisation space.

    Parameters
    ----------
    m : int
        Partition size.
    n_threads : int
        Number of threads to use in the pool.

    Returns
    -------
    list[tuple]
        Optimisation results from all random initialisations.
    """
    mp.dps = 70
    alpha = np.ones(m)
    x0_initialisations = np.random.dirichlet(alpha, size=int(10 ** (m - 1)))

    with Pool(n_threads) as p:
        sols = p.map(optimise_partition_random_start, x0_initialisations)

    return sols


def make_pool(
    n_max: int,
    m_max: int,
    delta: float,
    n_threads: int,
) -> list[tuple[int, int, np.ndarray]]:
    """
    Create and solve a grid of optimisation problems in parallel.

    Generates a grid of optimisation problems with coordinates [n, m], where
    n ranges from 5 to n_max and m ranges from 5 to m_max, both in steps of 5.
    Spawns a process pool to solve each optimisation problem via optimise_partition.

    Parameters
    ----------
    n_max : int
        Maximum value of n in the grid.
    m_max : int
        Maximum value of m in the grid.
    delta : float
        Delta parameter passed to optimise_partition.
    n_threads : int
        Number of processes to spawn in the pool.

    Returns
    -------
    list[tuple[int, int, np.ndarray]]
        Optimisation results for each grid point, where each tuple contains
        (n, m, optimised_partition).
    """
    x_vec = list(range(5, n_max + 1, 5))
    y_vec = list(range(5, m_max + 1, 5))

    grid_x, grid_y = np.meshgrid(x_vec, y_vec, indexing="ij")
    # grid_x, grid_y = np.asarray(grid_x, dtype="int"), np.asarray(grid_y, dtype="int")

    c_delta_vec = np.full(grid_x.shape, delta)

    grid = np.stack((grid_x, grid_y, c_delta_vec), axis=-1)
    grid = grid.reshape(-1, 3)

    with Pool(n_threads) as p:
        optimal_protocols = p.starmap(optimise_partition, grid)

    return optimal_protocols


def get_optimal_partition(
    n: int, m: int, delta: float, decimal_points: int = 50, maxdegree: int = 10
) -> tuple[int, bool, float, np.ndarray]:
    """
    Tuple of returns is (number of steps, optimisation success, value of const_fun, optimal partition)
    """
    my_args = (n, m, delta)

    def _fun(x):
        return cost_fun(x, *my_args)

    # heuristic x0 to initialise the optimisation
    try:
        x0 = make_fim_heuristic_partition(
            n, m, delta, decimal_points=decimal_points, maxdegree=maxdegree
        )
    except RuntimeError:
        x0 = np.full(m, 2 * c_delta / m)

    cons = {"type": "eq", "fun": lambda x: np.sum(x) + 2 * np.log(float(delta))}
    res = minimize(
        _fun,
        x0,
        method="SLSQP",
        jac="3-point",
        constraints=cons,
        tol=1e-9,
        options={"disp": True, "maxiter": 1000},
    )

    return (m, res.success, res.fun, res.x)


def make_pool_v2(
    n_threads: int, n_states: int, m_min: int, m_max: int, delta: float, **kwargs
):

    _fun = partial(get_optimal_partition, n_states, delta=delta, **kwargs)
    protocol_lengths = [_i for _i in range(m_min, m_max + 1, 5)]
    with Pool(n_threads) as p:
        opt_results = p.map(_fun, protocol_lengths)

    return opt_results


if __name__ == "__main__":
    # we need high precision because we have terms like (1-epsilon)^n for n moderately large.
    mp.dps = 70

    n_threads = 4
    n = 20
    m_min = 5
    m_max = 100
    delta = np.exp(-3)

    res = make_pool_v2(
        n_threads, n, m_min, m_max, delta, decimal_points=50, maxdegree=11
    )

    print(res[:5])
    print(res[-5:])

    # print(optimal_protocols)
