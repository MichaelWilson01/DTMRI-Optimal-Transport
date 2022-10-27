clear all
load("newData.mat")

X1 = Fibers{9};
X2 = Fibers{26};

a=1;
b=1;

for K=11

    Z1  = linkage(curve_to_mat(X1)','ward');
    idx1 = cluster(Z1,'maxclust',K);
    
    Z2  = linkage(curve_to_mat(X2)','ward');
    idx2 = cluster(Z2,'maxclust',K);
    
C=parula(K);
    
b=1;

    for J = 20
        


for i = 1:length(Fibers)
    
    idx1_2{i} = mode(idx1(knnsearch(curve_to_mat(X1)',curve_to_mat(alignedFibers{i})','K',J))');
    idx2_2{i} = mode(idx2(knnsearch(curve_to_mat(X2)',curve_to_mat(alignedFibers{i})','K',J))');

end


for i = 1:length(labels)

    for j = 1:K
        
        features1(i,j) = sum(idx1_2{i}==j);

    end
    
    for j = (K+1):(2*K)
        
        features1(i,j) = sum(idx2_2{i}==j);

    end

end

% mdl1 = fitctree([features1],labels,'MaxNumSplits',K,'PruneCriterion','error');%;round(sqrt(K)));
mdl1 = fitctree([features1],labels,'MaxNumSplits',K);

% mdl1 = fitcsvm([features1],labels);


trainAcc(a,b) = mean(mdl1.predict(features1)==labels');

for i = 1:30

CVmdl_1 = crossval(mdl1);
acc1(i) = 1 - kfoldLoss(CVmdl_1)

end

testAcc(a,b)=mean(acc1)

b=b+1;

    end
    a=a+1;
end

acc1=[]

for i = 1:300

CVmdl_1 = crossval(mdl1);
acc1(i) = 1 - kfoldLoss(CVmdl_1)

plot(cumsum(acc1)./(1:length(acc1)))
pause(.1)

end

plot(cumsum(acc1)./(1:length(acc1)))

