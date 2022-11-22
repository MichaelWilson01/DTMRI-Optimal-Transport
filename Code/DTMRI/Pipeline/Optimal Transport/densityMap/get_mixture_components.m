function [muX, sigmaX, countsX, idx] = get_mixture_components(pcaCoords,Fibers, kx)

% idx = cluster(linkage(dist(pcaCoords'),'ward'),'maxclust',kx);
idx = kmeans(pcaCoords,kx);

for j = 1:kx
    
    muX(:,:,j) = mean(Fibers(:,:,idx==j),3);
    countsX(j) = sum(idx==j)/length(idx);
    if countsX(j)==1
        sigmaX(:,:,j)=eye(8);
    else
    sigmaX(:,:,j) = cov(pcaCoords(idx==j,:));
    end
    
    
end