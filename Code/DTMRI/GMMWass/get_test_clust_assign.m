function clustAssign = get_test_clust_assign(testFibers,modes,epsOpt)

[~,~,c] = size(modes);
[~,~,C] = size(testFibers);

for i = 1:C

        
    % Calculating fiber distances from cluster modes
    for m = 1:c
    
        NN(m)=get_streamline_dist(testFibers(:,:,i),modes(:,:,m));
%         NN(m)=mean(vecnorm(testFibers(:,:,i)-modes(:,:,m)));
        
    end
    
    %comparing fiber distances from cluster modes to optimal epsilon
    if min(NN)<epsOpt
    
        clustAssign(i)=find(NN==min(NN));
    
    else
        
        clustAssign(i)=0;
    
    end
    
%     i
    
end
        


