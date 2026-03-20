import numpy as np
import matplotlib.pyplot as plt
from numpy.dtypes import ObjectDType
from EnergyProtocolOptimization import *


delta = np.exp(-3)
n = 10

min_cost = np.load(
    "/home/farid/Documents/NonGitCode/ComputationalEntropy/optimalProtocolCost_10_5_100_5.npy"
)
optimal_protocols = np.array(
    np.load(
        "/home/farid/Documents/NonGitCode/ComputationalEntropy/optimalProtocol_10_5_100_5.npy",
        allow_pickle=True,
    ),
    dtype=ObjectDType,
)


optimal_protocol5, optimal_protocol10 = optimal_protocols[:2]

state_seq5 = get_prob_vectors(n, get_state_seq(1 / delta, optimal_protocol5))
state_seq10 = get_prob_vectors(n, get_state_seq(1 / delta, optimal_protocol10))


min_increment = np.asarray([np.min(protocol) for protocol in optimal_protocols])


def plot_state_sequences(state_seq, title_prefix, ncols=2):
    chain_length = state_seq.shape[1]  # number of distributions (sites on the chain)
    support_size = state_seq.shape[0]  # size of each distribution
    nrows = (chain_length + ncols - 1) // ncols

    fig, axes = plt.subplots(
        nrows, ncols, figsize=(ncols * 4, nrows * 3), squeeze=False
    )

    for i in range(chain_length):
        ax = axes[i // ncols, i % ncols]
        ax.bar(range(support_size), state_seq[:, i])
        ax.set_title(f"N=10, M=10, step={i}")
        ax.set_xticks([])
        ax.set_yticks([])

    # Hide unused axes
    for j in range(chain_length, nrows * ncols):
        axes[j // ncols, j % ncols].axis("off")

    plt.tight_layout()
    plt.show()
