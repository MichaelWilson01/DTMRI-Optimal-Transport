clear all
load("matlab4.mat")

targetInd=1+(9-1)*N:9*N;
X2 = Fibers{9};
K=11;

Z  = linkage(curve_to_mat(X2)','ward');
idx = cluster(Z,'maxclust',K);

% idx=kmeans(curve_to_mat(X2)',K);

idx2 = mode(idx(knnsearch(curve_to_mat(X2)',curve_to_mat(X)','K',20))');
C=parula(K);

for i = 1:length(labels)

    subjInd = 1+(i-1)*N:i*N;

    for j = 1:K
        
        X2=X0(:,:,subjInd);
        
        features1(i,j) = sum(idx2(subjInd)==j);

    end
    
    features1(i,j) = Wasserstein_parallel(alignedFibers{i},Fibers{9},alignedPi{i})
    
    for j = K+2:(2*K+1)
        
        X2=X0(:,:,subjInd);
        
        features1(i,j) = sum(idx2(subjInd)==j);

    end

end

mdl1 = fitcsvm([features1,W'],labels)

acc1=[]

for i = 1:300

CVmdl_1 = crossval(mdl1);
acc1(i) = 1 - kfoldLoss(CVmdl_1)


plot(cumsum(acc1)./(1:length(acc1)))
pause(.1)

end

plot(cumsum(acc1)./(1:length(acc1)))

