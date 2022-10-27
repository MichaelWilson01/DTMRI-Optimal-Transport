function [cluster_modes, cluster_counts] = get_kmeans_cluster_modes_and_counts(Fibers,K)

for i = 1:length(Fibers)

    X= Fibers{i};
    idx = kmeans(curve_to_mat(X)',K);
    
    for j = 1:K
        cluster_modes_temp(:,:,j) = mean(X(:,:,idx==j),3);
        cluster_counts_temp(j)=sum(idx==j);
    end
    
    cluster_modes{i} = cluster_modes_temp;
    cluster_counts{i} = cluster_counts_temp;
    
    clearvars cluster_modes_temp cluster_counts_temp
    
end