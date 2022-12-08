function cluster_cov = get_cluster_cov(pcaCoords,IDX,basis);


[~,N]=size(pcaCoords);

for i = 1:N
    
    idx = IDX{i};
    
    for j = 1:max(idx)
        
        cluster_cov{i}{j} = cov(pcaCoords{i}(idx==j,:));
        
    end
    
end

