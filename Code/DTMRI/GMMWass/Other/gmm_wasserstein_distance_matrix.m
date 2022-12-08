function MW = gmm_wasserstein_distance_matrix(cluster_counts,cluster_cov,Pi)

[M,N] = size(Pi);
MW=zeros(M,N);

parfor i = 1:M
    i
    for j = 1:N
        
        MW(i,j)=get_gmm_wasserstein(cluster_counts{i},cluster_counts{j},cluster_cov{i},cluster_cov{j},Pi{i,j});
        
    end
end
        
        