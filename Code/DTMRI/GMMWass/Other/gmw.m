function GMW = gmw(M,W,Sigma)

for i = 1:length(M)
    
    for j = 1:length(M)
        
        GMW(i,j) = get_sphere_mixture_distance(M{i},M{j},W{i},W{j},Sigma{i},Sigma{j});
        
    end
    
end

