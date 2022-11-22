function Wg = get_gmm_wasserstein(muX, sigmaX, muY, sigmaY, Pi);

Wg=0;
[~,~,N] = size(m0);
[~,~,M] = size(m1);

for i = 1:N
    for j = 1:M
        
        Wg = Wg + get_streamline_dist(m0(:,:,i),m1(:,:,j)) + trace(sigma0(:,:,i) + sigma1(:,:,j) - 2*sqrtm(sqrtm(sigma0(:,:,i)) * sigma1(:,:,j) * sqrtm(sigma0(:,:,i))));

    end
end

