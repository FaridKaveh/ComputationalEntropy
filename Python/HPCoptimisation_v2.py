import pickle
from pathlib import Path

import mpmath
import numpy as np
from MultithreadedOptimisation import make_pool_v2

if __name__ == "__main__":
    mpmath.mp.dps = 500
    n_threads = 8

    n_states = 200
    delta = mpmath.exp(-3)
    m_min = 105
    m_max = 250

    # step is not an argument of make_pool_v2 but recording it for future clarity
    step = 5

    _args = (n_threads, n_states, m_min, m_max, delta)
    _kargs = {"decimal_points": 300, "maxdegree": 10}

    save_dir = Path("/rds/general/user/fk120/home/opt_results")
    output_file = (
        save_dir / f"optimisation_N{n_states}_step{step}_deltaE{np.log(float(delta))}"
    )

    res = make_pool_v2(*_args, **_kargs)

    with open(output_file, "wb") as f:
        pickle.dump(res, f)
