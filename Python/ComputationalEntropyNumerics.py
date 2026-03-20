from mpmath import mp

# Set working precision (decimal digits)
mp.dps = 80  # adjust if needed

def rate_ratio(M, k):
    # NrateRatio[M_, k_] := N[Exp[-3*k/M]];
    return mp.e ** (-3 * mp.mpf(k) / mp.mpf(M))

def pi_N(n, M, k):
    # NpiN[n_, M_, k_] := If[k != 0, (1 - r)/(1 - r^n), 1/n];
    if k != 0:
        r = rate_ratio(M, k)
        return (1 - r) / (1 - r ** n)
    else:
        return mp.mpf(1) / n

def adjacent_dists_KLD(n, M, k):
    # NadjacentDistsKLD[n_, M_, k_] := -Log[pi_N(n,M,k+1)/pi_N(n,M,k)]
    #   + If[k != 0,
    #        3/M * (r - n*r^n + (n-1)*r^(n+1)) / ((1 - r)*(1 - r^n)),
    #        3*(n - 1)/(2*M)
    #     ];
    term1 = -mp.log(pi_N(n, M, k + 1) / pi_N(n, M, k))
    if k != 0:
        r = rate_ratio(M, k)
        num = r - n * (r ** n) + (n - 1) * (r ** (n + 1))
        den = (1 - r) * (1 - r ** n)
        term2 = (3 / mp.mpf(M)) * (num / den)
    else:
        term2 = 3 * (n - 1) / (2 * mp.mpf(M))
    return term1 + term2

def total_ent_prod(n, M):
    # NtotalEntProd[n_, M_] := Sum[adjacent_dists_KLD[n,M,k], {k, -M, M}];
    s = mp.mpf('0')
    for k in range(-int(M), int(M) + 1):
        s += adjacent_dists_KLD(n, M, k)
    return s

def entropy_sum(n, M):
    # EntropySum[n_, M_] := NSum[If[k != 0, ..., 3*(n - 1)/(2*M)], {k, -M, M}]
    s = mp.mpf('0')
    for k in range(-int(M), int(M) + 1):
        if k != 0:
            r = rate_ratio(M, k)
            num = r - n * (r ** n) + (n - 1) * (r ** (n + 1))
            den = (1 - r) * (1 - r ** n)
            term = (3 / mp.mpf(M)) * (num / den)
        else:
            term = 3 * (n - 1) / (2 * mp.mpf(M))
        s += term
    return s


if __name__ == "__main__":
    n = 10
    Ms = list(range(5, 200, 5))
    Ys = [entropy_sum(n, M) for M in Ms]

    # Convert to float for plotting
    Ys_float = [float(y) for y in Ys]

    import matplotlib.pyplot as plt
    plt.figure()
    plt.plot(Ms, Ys_float)
    plt.xlabel("M")
    plt.ylabel("EntropySum(n=10, M)")
    plt.title("EntropySum vs M (n = 10)")
    # If values span orders of magnitude, a log y-scale can help:
    # plt.yscale('log')
    plt.tight_layout()
    plt.show()
