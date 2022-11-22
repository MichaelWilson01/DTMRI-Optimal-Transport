function Pi = get_coupling2(cluster_counts,g);

N=length(cluster_modes);
Pi{N}=[];

parfor i = 1:N
    for j = 1:N
        
        C = get_cost_matrix2(cluster_counts{i},cluster_counts{j});
        Pi{i,j} = sinkhorn(C,g);
        
    end
end
    