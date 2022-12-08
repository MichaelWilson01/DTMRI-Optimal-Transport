function MW = gmm_wasserstein(cluster_counts,cluster_cov,Pi)

[M,N] = size(Pi);

for i = 1:M
    for j = 1:N
        
        MW(i,j)=get_gmm_wasserstein(cluster_counts{i},cluster_counts{j},cluster_cov{i},cluster_cov{j},Pi{i,j});
        
    end
end
        
        