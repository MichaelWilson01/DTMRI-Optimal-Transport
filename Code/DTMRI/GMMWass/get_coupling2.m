function Pi = get_coupling2(cluster_counts,g);

N=length(cluster_counts);
Pi{N,N}=[];

parfor i = 1:N
    for j = 1:N
        
        C = get_cost_matrix2(cluster_counts{i}(2:end),cluster_counts{j}(2:end));
        Pi{i,j} = sinkhorn(C,g);
        
    end
end
    

