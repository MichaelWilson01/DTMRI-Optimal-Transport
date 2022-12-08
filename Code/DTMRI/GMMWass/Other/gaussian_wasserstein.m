function Wg = gaussian_wasserstein(m0,m1,sigma0,sigma1)

for i = 1:N
    for j = 1:M
        
        Wg = get_streamline_dist(m0(:,:,i),m1(:,:,j) + trace(sigma0 + sigma1 - 2*sqrtm(sqrtm(sigma0) * sigma1 * sqrtm(sigma0)));

    end
end

