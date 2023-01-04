function MW = gmm_wasserstein_distance_matrix2(cluster_modes,Pi)

[M,N] = size(Pi);
MW=zeros(M,N);

parfor i = 1:M
    i
    for j = 1:N
        
        MW(i,j)=get_gmm_wasserstein2(cluster_modes{i},cluster_modes{j},Pi{i,j});
        
    end
end
        
        