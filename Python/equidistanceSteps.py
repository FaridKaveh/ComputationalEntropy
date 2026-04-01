import mpmath as mp
import numpy as np
from scipy.optimize import fsolve

from geodesic_length import geodesic_length, integrand

"""
Design an (optimal?) control protocol by taking equidistant steps in parameter space according to the Fisher information
metric.
"""


def calc_step_point_scipy(
    start: float,
    n_states: int,
    budget: float,
    delta: float,
    n_steps: int,
    rel_tolerance: float = 1e-4,
    decimal_places: int = 50,
    maxdegree: int = 6,
) -> float:

    def f(x: np.ndarray) -> float:
        x = x[0]
        cost = (
            geodesic_length(
                start, x, n_states, decimal_places=decimal_places, maxdegree=maxdegree
            )
            - budget
        )
        return np.asarray([cost], dtype="float64")

    def df(x: np.ndarray) -> float:
        x = x[0]
        derivative = integrand(x, n_states)
        return np.asarray([derivative], dtype="float64")

    c_delta = -mp.log(delta)
    step_size = 2 * c_delta / n_steps
    sol_guess = np.asarray([start + step_size], dtype="float64")

    sol = fsolve(f, sol_guess, fprime=df, xtol=rel_tolerance)[0]

    return sol


def calc_step_point(
    start: float,
    n_states: int,
    budget: float,
    delta: float,
    n_steps: int,
    rel_tolerance: float = 1e-4,
    decimal_places: int = 50,
    maxdegree: int = 6,
) -> float:
    """
    Numerically inverts the geodesic distance function L(x) = \int_{start}^x g(y) dy to find sol such that L(sol) = budget
    """

    c_delta = -mp.log(delta)
    step_size = (c_delta - start) / n_steps
    sol = start + step_size
    cost = geodesic_length(
        start, sol, n_states, decimal_places=decimal_places, maxdegree=maxdegree
    )

    # first find a point that exceeds the budget
    while cost < budget and sol < c_delta:
        sol += step_size
        cost = geodesic_length(
            start, sol, n_states, decimal_places=decimal_places, maxdegree=maxdegree
        )

    if sol >= c_delta:
        # return if sol is further than your end point
        return float(c_delta)
    else:
        # otherwise do binary search to find the solution to desired accuracy
        high = sol
        low = sol - step_size
        sol = (high + low) / 2
        cost = geodesic_length(
            start, sol, n_states, decimal_places=decimal_places, maxdegree=maxdegree
        )
        while np.abs(cost - budget) / budget > rel_tolerance:
            if cost - budget > 0:
                high = sol
                sol = (high + low) / 2
                cost = geodesic_length(
                    start,
                    sol,
                    n_states,
                    decimal_places=decimal_places,
                    maxdegree=maxdegree,
                )
            else:
                low = sol
                sol = (high + low) / 2
                cost = geodesic_length(
                    start,
                    sol,
                    n_states,
                    decimal_places=decimal_places,
                    maxdegree=maxdegree,
                )

    return float(sol)


def calc_equidistance_steps(
    n_states: int,
    n_steps: int,
    delta: float,
    rel_tolerance: float = 1e-4,
    decimal_places: int = 50,
    maxdegree: int = 6,
    mode: str = "scipy",
) -> np.ndarray:

    equidistant_steps = np.zeros(n_steps + 1, dtype=float)

    c_delta = -mp.log(delta)
    equidistant_steps[0] = -c_delta

    total_length = geodesic_length(
        -c_delta, c_delta, n_states, decimal_places=decimal_places, maxdegree=maxdegree
    )

    step_budget = total_length / n_steps

    if mode == "scipy":
        for i in range(1, n_steps + 1):
            equidistant_steps[i] = calc_step_point_scipy(
                equidistant_steps[i - 1],
                n_states,
                step_budget,
                delta,
                n_steps,
                rel_tolerance=rel_tolerance,
                decimal_places=decimal_places,
                maxdegree=maxdegree,
            )
    elif mode == "my_solver":
        for i in range(1, n_steps + 1):
            equidistant_steps[i] = calc_step_point(
                equidistant_steps[i - 1],
                n_states,
                step_budget,
                delta,
                n_steps,
                rel_tolerance=rel_tolerance,
                decimal_places=decimal_places,
                maxdegree=maxdegree,
            )

    return equidistant_steps


def check_equidistant_steps(
    n_states: int,
    n_steps: int,
    delta: float,
    equidistant_steps_arr: np.ndarray,
    rel_tolerance: float = 1e-2,
    decimal_places: int = 30,
    maxdegree: int = 6,
) -> bool:

    c_delta = -mp.log(delta)
    total_length = geodesic_length(
        -c_delta, c_delta, n_states, decimal_places=decimal_places, maxdegree=maxdegree
    )

    step_budget = total_length / n_steps
    for i in range(1, n_steps + 1):
        step_cost = geodesic_length(
            equidistant_steps_arr[i - 1],
            equidistant_steps_arr[i],
            n_states,
            decimal_places=decimal_places,
            maxdegree=maxdegree,
        )
        relative_error = np.abs(step_cost - step_budget) / step_budget
        if relative_error > rel_tolerance:
            print(f"check_equidistant_steps: Check failed at step {i}.")
            print(
                f"step budget= {step_budget}, step cost={step_cost}, relative error = {relative_error}."
            )
            return False

    return True


if __name__ == "__main__":
    n_states = int(input("number of states, N:"))
    n_steps = int(input("number of steps, K:"))
    steps_arr = calc_equidistance_steps(
        n_states,
        n_steps,
        mp.exp(-3),
        rel_tolerance=1e-6,
        decimal_places=20,
        maxdegree=12,
    )
    print(steps_arr)
