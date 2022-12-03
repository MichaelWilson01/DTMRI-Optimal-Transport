function [Xm, mu] = get_modes_and_measure(pcaCoords,modesX,densX,K)

A = find(sum(modesX)>0);
B=A(A>=K);
K=B(1);

Xm = pcaCoords(modesX(:,K)==1,:);
mu = densX(modesX(:,K)==1,K);%/sum( densX{1}(modesX{1}(:,K)==1,K))
mu = mu/sum(mu);