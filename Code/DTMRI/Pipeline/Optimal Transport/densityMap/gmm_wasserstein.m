function W = gmm_wasserstein(muX, sigmaX, countsX, muY, sigmaY, countsY);

Pi = get_coupling(countsX, countsY,2);

W = get_gmm_wasserstein(muX, sigmaX, muY, sigmaY, Pi);