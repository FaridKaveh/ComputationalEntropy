import numpy as np
from mpmath import *
from numpy.dtypes import ObjectDType
from scipy.optimize import minimize

from equidistanceSteps import calc_equidistance_steps, check_equidistant_steps


def phi(x: float, n: int) -> float:
    if x == 1:
        return (n - 1) / 2
    else:
        nom = x - n * (x**n) + (n - 1) * (x ** (n + 1))
        denom = (1 - x) * (1 - x**n)

        return nom / denom


def psi(x: float, n: int, delta: float) -> float:
    c_delta = -mp.log(delta)
    return phi(mp.exp(c_delta * (1 - 2 * x)), n)


def varphi(x, n, delta):
    return phi(1 / delta * mp.exp(-x), n)


def cost_fun(x, n, m, delta):
    phi_arr = np.zeros(m)

    for i in range(m):
        phi_arr[i] = varphi(np.sum(x[:i]), n, delta)

    cost = np.sum(x * phi_arr)

    return cost


def get_state_seq(r, protocol):
    state_seq = [r * mp.exp(-np.sum(protocol[:i])) for i in range(len(protocol) + 1)]
    return state_seq


def get_prob_vectors(n, state_seq):
    prob_vecs = np.zeros((n, len(state_seq)))

    for idx, state in enumerate(state_seq):
        vec_n = (1 - state) / (1 - state**n)
        vec = np.array([vec_n * (state ** (n - i)) for i in range(1, n + 1)])

        prob_vecs[:, idx] = vec

    return prob_vecs


def make_fim_heuristic_partition(
    n: int, m: int, delta: float, decimal_points: int = 50, maxdegree: int = 10
) -> np.ndarray:

    # equidistant_partition = np.zeros(m)
    # equidistant_parameters = np.zeros(m + 1)

    failures = 0
    convergence = False
    while not convergence and failures < 3:
        equidistant_parameters = calc_equidistance_steps(
            n, m, delta, decimal_places=decimal_points, maxdegree=maxdegree
        )

        convergence = check_equidistant_steps(
            n,
            m,
            delta,
            equidistant_parameters,
            decimal_places=decimal_points,
            maxdegree=maxdegree + 1,
        )

        failures += 1
        maxdegree += 1

    if not convergence:
        print("make_fim_heuristic_partition: Failed to produce equidistant partion.")
        return None
    else:
        equidistant_partition = np.asarray(
            [
                equidistant_parameters[i + 1] - equidistant_parameters[i]
                for i in range(m)
            ]
        )
    return equidistant_partition


if __name__ == "__main__":
    mp.dps = 500
    maxdegree = 12
    # delta \approx 0.05
    delta = mp.exp(-3)
    c_delta = -mp.log(delta)
    # starting bias
    r0 = 1 / delta

    n = 200
    m_min = 5
    m_max = 100
    step = 5

    protocols = []
    cost_arr = np.zeros(m_max // step)

    cons = {"type": "eq", "fun": lambda x: np.sum(x) + 2 * mp.log(delta)}

    x0_guesses = ["constant"]

    for initial_partition in x0_guesses:
        for m in range(m_min, m_max + 1, step):
            if initial_partition == "decreasing":
                x0 = [(1 / 2) ** i for i in range(1, m)]
                x0.append(1 - sum(x0))
                x0 = np.asarray(x0) * (2 * c_delta)

            elif initial_partition == "increasing":
                x0 = [(1 / 2) ** (m - i) for i in range(1, m)]
                x0.append(1 - sum(x0))
                x0 = np.asarray(x0) * (2 * c_delta)

            elif initial_partition == "constant":
                x0 = make_fim_heuristic_partition(
                    n, m, delta, decimal_points=mp.dps, maxdegree=maxdegree
                )
                if x0 is None:
                    x0 = np.full(m, 2 * c_delta / m)

            else:
                raise ValueError("Undefined partition spacing.")

            my_args = (n, m, delta)
            fun = lambda x: cost_fun(x, *my_args)

            # print(f"n={my_args[0]}, m={my_args[1]}, r0={my_args[2]}, cost={fun(x0)}")

            res = minimize(
                fun,
                x0,
                method="SLSQP",
                jac="3-point",
                constraints=cons,
                tol=1e-9,
                options={"disp": True, "maxiter": 1000},
            )
            print(res.x)
            protocols.append(res.x)
            cost_arr[(m - m_min) // step] = fun(res.x)
            print(f"cost({m})={fun(res.x)}")

        np.save(
            f"/home/farid/Documents/git/ComputationalEntropy/optimisation_data/optimalProtocolCost_fimHeuristic_n{n}_deltaE{mp.log(delta)}_m_min{m_min}_m_max{m_max}_step{step}",
            cost_arr,
        )
        protocols_tosave = np.array(protocols, dtype=ObjectDType)
        np.save(
            f"/home/farid/Documents/git/ComputationalEntropy/optimisation_data/optimalProtocol_fimHeuristic_n{n}_deltaE{mp.log(delta)}_m_min{m_min}_m_max{m_max}_step{step}",
            protocols_tosave,
        )
