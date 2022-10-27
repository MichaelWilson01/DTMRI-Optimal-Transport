clear all
load("matlab4.mat")

X2 = Fibers{9};
a=1;
b=1;

for K=11:20;

    Z  = linkage(curve_to_mat(X2)','ward');
    idx = cluster(Z,'maxclust',K);
    
C=parula(K);
    
b=1;

    for J = 10:10:40
        


for i = 1:length(Fibers)
    
    idx2{i} = mode(idx(knnsearch(curve_to_mat(X2)',curve_to_mat(alignedFibers{i})','K',J))');

end


for i = 1:length(labels)

%     subjInd = 1+(i-1)*N:i*N;
%     
%     subplot(4,2,[5,7])
%     cla
%     subplot(4,2,[6,8])
%     cla

    for j = 1:K
        
% %         X2=X0(:,:,subjInd);
%         X2=alignedFibers{i};
%  
%         subplot(4,6,j)
%         cla
% %         plot_curve(X0(:,:,targetInd(idx==j)),1,'black')
%         plot_curve(datasample(Fibers{9}(:,:,idx==j),500,3),1,[0 0 0 .05])
%         plot_curve(datasample(X2(:,:,idx2{i}==j),500,3),1,C(j,:)')
%         
%         subplot(4,2,[5,7])
% %         plot_curve(X0(:,:,targetInd(idx==j)),1,C(j,:)')
%         plot_curve(datasample(Fibers{9}(:,:,idx==j),500,3),1,C(j,:)')
%         subplot(4,2,[6,8])
%         plot_curve(datasample(X2(:,:,idx2{i}==j),500,3),1,C(j,:)')
        
        features1(i,j) = sum(idx2{i}==j);

    end

end

% mdl1 = fitctree([features1],labels,'MaxNumSplits',K,'PruneCriterion','error');%;round(sqrt(K)));
% mdl1 = fitctree([features1],labels,'MaxNumSplits',round(sqrt(K)));

mdl1 = fitcsvm([features1],labels);


trainAcc(a,b) = mean(mdl1.predict(features1)==labels');

for i = 1:20

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

