import mpmath
import numpy as np

mpmath.mp.dps = 200


def set_precision(decimal_points: int) -> None:
    mpmath.mp.dps = decimal_points


def partition_func(n: int, mu: float) -> float:
    if mu == 0:
        return n
    else:
        return (1 - mpmath.mp.exp(-n * mu)) / (1 - mpmath.mp.exp(-mu))


def log_partition_func(n: int, mu: float) -> float:
    return mpmath.mp.log(partition_func(n, mu))


def second_cumulant(n: int, mu: float) -> float:

    if mu == 0:
        return 1 / 12 * (n**2 - 1)
    else:
        e = mpmath.mp.exp
        numerator = (
            e(mu)
            + e(mu + 2 * n * mu)
            - e(n * mu) * (n**2)
            - e((2 + n) * mu) * (n**2)
            + 2 * e(mu + n * mu) * (n**2 - 1)
        )

        denominator = ((-1 + e(mu)) ** 2) * ((-1 + e(n * mu)) ** 2)

        return numerator / denominator


def third_cumulant(n: int, mu: float) -> float:

    if mu == 0:
        return 0
    else:
        e = mpmath.mp.exp

        numerator = (
            e(mu)
            + e(2 * mu)
            - e((2 + 3 * n) * mu)
            - e(mu + 3 * n * mu)
            - e(n * mu) * (n**3)
            - e(2 * n * mu) * (n**3)
            + e((3 + n) * mu) * (n**3)
            + e((3 + 2 * n) * mu) * (n**3)
            - 3 * e(2 * (1 + n) * mu) * (-1 + (n**3))
            + 3 * e(mu + n * mu) * (-1 + (n**3))
            - 3 * e((2 + n) * mu) * (1 + (n**3))
            + 3 * e(mu + 2 * n * mu) * (1 + (n**3))
        )

        denominator = ((-1 + e(mu)) ** 3) * ((-1 + e(n * mu)) ** 3)

        return numerator / denominator


def fourth_cumulant(n: int, mu: float) -> float:
    """
    This function was written by Claude. Checked by Farid.

    Computes the fourth cumulant as a function of n and mu.
    Transcribed from Mathematica output.
    """

    if mu == 0:
        return 1 / 120 * (1 - n**4)
    else:
        e = mpmath.mp.exp

        denom = ((e(mu) - 1) ** 4) * ((e(n * mu) - 1) ** 4)

        numerator = (
            # Standalone exponential terms
            e(mu)
            + 4 * e(2 * mu)
            + e(3 * mu)
            + e((3 + 4 * n) * mu)
            + e((1 + 4 * n) * mu)
            + 4 * e((2 + 4 * n) * mu)
            # Terms multiplied by n^4
            - e(n * mu) * n**4
            - 4 * e(2 * n * mu) * n**4
            - e(3 * n * mu) * n**4
            - 4 * e((4 + 2 * n) * mu) * n**4
            - e((4 + n) * mu) * n**4
            - e((4 + 3 * n) * mu) * n**4
            # Terms multiplied by (n^4 - 1)
            - 24 * e(2 * (1 + n) * mu) * (n**4 - 1)
            + 4 * e(3 * (1 + n) * mu) * (n**4 - 1)
            + 4 * e((3 + n) * mu) * (n**4 - 1)
            + 4 * e((1 + n) * mu) * (n**4 - 1)
            + 4 * e((1 + 3 * n) * mu) * (n**4 - 1)
            # Terms multiplied by (8 + 3*n^4) and (3 + 8*n^4)
            - 2 * e((2 + n) * mu) * (8 + 3 * n**4)
            - 2 * e((2 + 3 * n) * mu) * (8 + 3 * n**4)
            + 2 * e((3 + 2 * n) * mu) * (3 + 8 * n**4)
            + 2 * e((1 + 2 * n) * mu) * (3 + 8 * n**4)
        )

        return numerator / denom


def mth_cumulant(n: int, order_m: int, mu: float) -> float:
    """
    returns the m-th cumulant for a chain of length n evaluated at mu.
    """

    if mu == 0:
        return 1 / 12 * (n**2 - 1)

    def f(mu):
        return log_partition_func(n, mu)

    singular = np.abs(mu) < 1e-12
    df = mpmath.diff(f, mu, n=order_m, relative=True, singular=singular)
    # print(f"mu={float(mu):.1e}, df = {float(df):.1e}")
    return df


def mth_order_perturbation(n: int, order_m: int, mu_i: float, mu_f: float) -> float:
    """
    Calculates the mth_order contribution to the entropy production resulting from a parameter
    step mu_i -> mu_f
    """

    m_cumulant = mth_cumulant(n, order_m, mu_i)
    step = mu_f - mu_i

    return m_cumulant * (step**order_m) / mpmath.fac(order_m)


def mth_order_perturbation_sum(n: int, order_m: int, protocol: np.ndarray) -> float:
    """
    Given protocol, calculate the total m-th order contribution to the entropy production of protocol
    """

    summands = np.asarray(
        [
            mth_order_perturbation(n, order_m, protocol[i], protocol[i + 1])
            for i in range(protocol.shape[0] - 1)
        ]
    )

    return np.sum(summands)


def total_entropy_mth_order(n: int, max_order: int, protocol: np.ndarray) -> float:
    """
    Given protocol, calculates the contributions to entropy production up to order max_order throughout protocol.
    max_order must be > 1, because the 0-th and 1st order contribution to the entropy of protocol are zero.
    """
    if max_order < 2:
        print(f"total_entropy_mth_order: {max_order} contribution is zero.")
        return 0

    total_entropy = 0
    for order in range(2, max_order + 1):
        total_entropy += mth_order_perturbation_sum(n, order, protocol)

    return total_entropy


def geodesic_length_v2(
    a: float,
    b: float,
    n: int,
    decimal_places: int = 50,
    maxdegree=6,
    error: bool = False,
) -> mpmath.mpf:

    a_mp = mpmath.mpf(a)
    b_mp = mpmath.mpf(b)

    def f(x):
        second_cumulant = mth_cumulant(n, 2, x)
        return mpmath.sqrt(second_cumulant)

    if error:
        length, error = mpmath.quad(f, [a_mp, b_mp], maxdegree=maxdegree, error=True)

        return length, error
    else:
        length = mpmath.quad(f, [a_mp, b_mp], maxdegree=maxdegree, error=False)
        return length


def t2_lemma_bound(n: int, protocol: np.ndarray) -> float:

    num_steps = protocol.shape[0] - 1
    bound = 0
    for i in range(num_steps):
        weight = mth_cumulant(n, 2, protocol[i])
        weight = mpmath.sqrt(weight)

        bound += weight * (protocol[i + 1] - protocol[i])

    return bound


if __name__ == "__main__":
    set_precision(decimal_points=200)

    print(geodesic_length_v2(-3, 3, 20))
