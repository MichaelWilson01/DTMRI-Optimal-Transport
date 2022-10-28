clear all
load("newData2.mat")

X1 = Fibers{9};
X2 = Fibers{30};

a=1;
b=1;

ind=[3];%,4,5,11];

for k= 1%:4
    
    K = ind(k);

%     Z1  = linkage(curve_to_mat(X1)','ward');
%     idx1 = cluster(Z1,'maxclust',K);
idx1 = kmeans(curve_to_mat(X1)',K);
    
%     Z2  = linkage(curve_to_mat(X2)','ward');
%     idx2 = cluster(Z2,'maxclust',K);
idx2 = kmeans(curve_to_mat(X2)',K);


for i =1:K
    
    muX1(:,:,i) = mean(X1(:,:,idx1==i),3);
    muX2(:,:,i) = mean(X2(:,:,idx2==i),3);

end

    
b=1;

    for J = 5:10:25%:10:30
        


for i = 1:length(Fibers)
    
%     idx1_2{i} = mode(idx1(knnsearch(curve_to_mat(X1)',curve_to_mat(alignedFibers{i})','K',J))');
%     idx2_2{i} = mode(idx2(knnsearch(curve_to_mat(X2)',curve_to_mat(alignedFibers3{i})','K',J))');

    idx1_2{i} = knnsearch(curve_to_mat(muX1)',curve_to_mat(alignedFibers{i})');
    idx2_2{i} = knnsearch(curve_to_mat(muX2)',curve_to_mat(alignedFibers3{i})');


end


for i = 1:length(labels)

    for j = 1:K
        
        features(i,j) = sum(idx1_2{i}==j);

    end
    
    features(i,K+1)=W1(i);
    
    for j = (K+2):(2*K+1)
        
        features(i,j) = sum(idx2_2{i}==j);

    end
    
    features(i,2*K+2)=W3(i);

end

% mdl1 = fitctree(features,labels,'MaxNumSplits',round(sqrt(2*(K+1))),'PruneCriterion','error');%;round(sqrt(K)));
% mdl1 = fitctree(features,labels,'MaxNumSplits',round(sqrt(2*(K+1))));

mdl1 = fitcsvm(features,labels);


trainAcc(a,b) = mean(mdl1.predict(features)==labels');

for i = 1:30

CVmdl_1 = crossval(mdl1);
acc1(i) = 1 - kfoldLoss(CVmdl_1);

end

testAcc(a,b)=mean(acc1)

b=b+1;

    end
    a=a+1;
end

% acc1=[]
% 
% for i = 1:300
% 
% CVmdl_1 = crossval(mdl1);
% acc1(i) = 1 - kfoldLoss(CVmdl_1)
% 
% plot(cumsum(acc1)./(1:length(acc1)))
% pause(.1)
% 
% end

% plot(cumsum(acc1)./(1:length(acc1)))

