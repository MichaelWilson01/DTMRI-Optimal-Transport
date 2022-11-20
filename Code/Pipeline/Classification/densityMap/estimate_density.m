function L = estimate_density(pcaCoords,K)

[~,D] = knnsearch(pcaCoords,pcaCoords,'K',K+1);

L = 1./D(:,end);

L=L/sum(L);

end
