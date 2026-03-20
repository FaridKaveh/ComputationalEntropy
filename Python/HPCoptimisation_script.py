import pickle
from pathlib import Path
from mpmath import *
from EnergyProtocolOptimization import *
from MultithreadedOptimisation import *


if __name__ == "__main__":
    mp.dps = 70

    n_threads = 8
    m_ls = [6, 7]

    save_dir = Path("/rds/general/user/fk120/home/opt_results")

    for m in m_ls:
        sols = parallelise_random_initialisation(m, n_threads)

        output_file = save_dir / f"random_init_m{m}.pkl"

        with open(output_file, "wb") as f:
            pickle.dump(sols, f)

        print(f"Saved {len(sols)} solutions to {output_file}")
