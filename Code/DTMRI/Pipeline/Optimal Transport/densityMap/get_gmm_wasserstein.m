function Wg = get_gmm_wasserstein(muX, sigmaX, muY, sigmaY, Pi);

Wg=0;
[~,~,N] = size(muX);
[~,~,M] = size(muY);

for i = 1:N
    for j = 1:M
        
        Wg = Wg + Pi(i,j) * (get_streamline_dist(muX(:,:,i),muY(:,:,j)) + trace(sigmaX(:,:,i) + sigmaY(:,:,j) - 2*sqrtm(sqrtm(sigmaX(:,:,i)) * sigmaY(:,:,j) * sqrtm(sigmaX(:,:,i)))));

    end
end

