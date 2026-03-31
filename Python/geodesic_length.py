"""Code written by Claude. Proceed with Care."""

"""
Numerical evaluation of geodesic length in a 1D Riemannian manifold.

The metric tensor component is:
    g_11(x) = e^x / (e^x - 1)^2 - n^2 * e^(nx) / (e^(nx) - 1)^2

The geodesic length from a to b is:
    L = integral_a^b sqrt(g_11(x)) dx
"""
import mpmath
import numpy as np
from log_partition import mth_cumulant


def set_precision(decimal_places: int = 50) -> None:
    """Set the numerical precision for mpmath calculations."""
    mpmath.mp.dps = decimal_places


def metric_component(x: mpmath.mpf, n: int) -> mpmath.mpf:
    """
    Evaluate the metric tensor component g_11(x).

    Parameters
    ----------
    x : mpf
        The position coordinate.
    n : int
        The natural number parameter in the metric.

    Returns
    -------
    mpf
        The value of g_11(x).

    Notes
    -----
    The metric has a removable singularity at x = 0. Both terms individually
    diverge as 1/x^2, but the leading singularities cancel. The limit is:

        lim_{x -> 0} g_11(x) = (n^2 - 1) / 12

    For small |x|, we use this limiting value to avoid catastrophic cancellation.
    """
    x = mpmath.mpf(x)

    # For very small |x|, use the limiting value to avoid numerical issues
    # The limit as x -> 0 is (n^2 - 1) / 12
    if mpmath.fabs(x) < mpmath.mpf("1e-12"):
        return mpmath.mpf(n**2 - 1) / 12

    # First term: e^x / (e^x - 1)^2
    exp_x = mpmath.exp(x)
    term1 = exp_x / (exp_x - 1) ** 2

    # Second term: n^2 * e^(nx) / (e^(nx) - 1)^2
    exp_nx = mpmath.exp(n * x)
    term2 = (n**2) * exp_nx / (exp_nx - 1) ** 2

    return term1 - term2


def integrand(x: mpmath.mpf, n: int) -> mpmath.mpf:
    """
    Evaluate the integrand sqrt(g_11(x)) for the geodesic length.

    Parameters
    ----------
    x : mpf
        The position coordinate.
    n : int
        The natural number parameter in the metric.

    Returns
    -------
    mpf
        The value of sqrt(g_11(x)).

    Raises
    ------
    ValueError
        If g_11(x) is negative (metric not positive definite at this point).
    """
    g = metric_component(x, n)

    if g < 0:
        raise ValueError(
            f"Metric component g_11({x}) = {g} is negative. "
            "The metric is not positive definite at this point."
        )

    return mpmath.sqrt(g)


def energy_integrand(x: mpmath.mpf, n: int) -> mpmath.mpf:
    """
    Evaluate the integrand sqrt(g_11(x)) for the path energy.

    Parameters
    ----------
    x : mpf
        The position coordinate.
    n : int
        The natural number parameter in the metric.

    Returns
    -------
    mpf
        The value of sqrt(g_11(x)).

    Raises
    ------
    ValueError
        If g_11(x) is negative (metric not positive definite at this point).
    """

    g = metric_component(x, n)

    if g < 0:
        raise ValueError(
            f"Metric component g_11({x}) = {g} is negative. "
            "The metric is not positive definite at this point."
        )

    return g


def geodesic_length(
    a: float,
    b: float,
    n: int,
    decimal_places: int = 50,
    maxdegree=6,
    verbose: bool = False,
    error: bool = False,
) -> mpmath.mpf:
    """
    Compute the geodesic length from x = a to x = b.

    Parameters
    ----------
    a : float
        The starting point.
    b : float
        The ending point.
    n : int
        The natural number parameter in the metric.
    decimal_places : int, optional
        Number of decimal places of precision (default: 50).
    verbose : bool, optional
        Whether to print intermediate information (default: True).

    Returns
    -------
    mpf
        The geodesic length.
    """
    set_precision(decimal_places)

    a_mp = mpmath.mpf(a)
    b_mp = mpmath.mpf(b)

    if verbose:
        print(f"Computing geodesic length from x = {a} to x = {b}")
        print(f"Parameter n = {n}")
        print(f"Precision: {decimal_places} decimal places")
        print()

        # Note about x = 0
        if a < 0 < b:
            limit_val = mpmath.mpf(n**2 - 1) / 12
            print(f"NOTE: The interval contains x = 0 (removable singularity).")
            print(
                f"      Limit as x → 0: g_11(0) = (n² - 1)/12 = {mpmath.nstr(limit_val, 10)}"
            )
            print()

        # Check metric positivity at a few sample points
        print("Checking metric positivity at sample points:")
        sample_points = [a, 0, b] if a < 0 < b else [a, (a + b) / 2, b]
        sample_points = [p for p in sample_points if a <= p <= b]
        for pt in sample_points:
            g_val = metric_component(mpmath.mpf(pt), n)
            if mpmath.isinf(g_val):
                status = "∞ (singularity)"
            elif g_val > 0:
                status = "(POSITIVE)"
            elif g_val == 0:
                status = "= 0 (degenerate)"
            else:
                status = "Warning (NEGATIVE)"
            print(f"  g_11({pt}) = {mpmath.nstr(g_val, 10)} {status}")
        print()

    # Define the integrand as a function of x only
    def f(x):
        return integrand(x, n)

    # Perform the numerical integration
    # Since x=0 is a removable singularity (handled in metric_component),
    # we can integrate directly without splitting
    if verbose:
        print("Performing numerical integration...")

    if error:
        length, error = mpmath.quad(f, [a_mp, b_mp], maxdegree=maxdegree, error=error)
    else:
        length = mpmath.quad(f, [a_mp, b_mp], maxdegree=maxdegree)

    if verbose:
        print(f"\nGeodesic length L = {length}")
        print(
            f"\nTo {min(15, decimal_places)} significant figures: {mpmath.nstr(length, min(15, decimal_places))}"
        )

    if error:
        return length, error
    else:
        return length


def path_energy(
    a: float,
    b: float,
    n: int,
    decimal_places: int = 50,
) -> mpmath.mpf:
    a_mp = mpmath.mpf(a)
    b_mp = mpmath.mpf(b)

    def f(x):
        return integrand(x, n)

    energy = mpmath.quad(f, [a_mp, b_mp])

    return energy


def analyse_metric_positivity(
    a: float, b: float, n: int, num_points: int = 100, decimal_places: int = 30
) -> dict:
    """
    Analyse where the metric is positive definite on an interval.

    Parameters
    ----------
    a : float
        Left endpoint of interval.
    b : float
        Right endpoint of interval.
    n : int
        The natural number parameter.
    num_points : int, optional
        Number of sample points (default: 100).
    decimal_places : int, optional
        Precision for calculations (default: 30).

    Returns
    -------
    dict
        Dictionary with analysis results.
    """
    set_precision(decimal_places)

    points = [
        mpmath.mpf(a) + (mpmath.mpf(b) - mpmath.mpf(a)) * i / (num_points - 1)
        for i in range(num_points)
    ]

    values = [metric_component(x, n) for x in points]

    min_val = min(values)
    max_val = max(values)
    min_idx = values.index(min_val)

    negative_points = [
        (float(points[i]), float(values[i])) for i in range(num_points) if values[i] < 0
    ]

    return {
        "minimum_value": min_val,
        "minimum_location": points[min_idx],
        "maximum_value": max_val,
        "is_positive_definite": len(negative_points) == 0,
        "negative_points": negative_points[:10],  # First 10 if any
        "num_negative": len(negative_points),
    }
