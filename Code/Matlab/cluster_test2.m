clear all
load("matlab4.mat")

targetInd=1+(9-1)*N:9*N;
X2 = Fibers{9};%X(:,:,targetInd);
K=11;

Z  = linkage(curve_to_mat(X2)','ward');
idx = cluster(Z,'maxclust',K);

% idx=kmeans(curve_to_mat(X2)',K);

% for j = 1:K
% 
%     subplot(2,5,j)
%     cla
%     plot_curve(X(:,:,idx==j),1,'black')
% 
% end


idx2 = mode(idx(knnsearch(curve_to_mat(X2)',curve_to_mat(X)','K',20))');
C=parula(K);

for i = 1:length(labels)

    subjInd = 1+(i-1)*N:i*N;
    
%     subplot(4,2,[5,7])
%     cla
%     subplot(4,2,[6,8])
%     cla

    for j = 1:K
        
        X2=X0(:,:,subjInd);
 
%         subplot(4,6,j)
%         cla
% %         plot_curve(X0(:,:,targetInd(idx==j)),1,'black')
%         plot_curve(Fibers{9}(:,:,idx==j),1,[0 0 0 .05])
%         plot_curve(X2(:,:,idx2(subjInd)==j),1,C(j,:)')
%         
%         subplot(4,2,[5,7])
% %         plot_curve(X0(:,:,targetInd(idx==j)),1,C(j,:)')
%         plot_curve(Fibers{9}(:,:,idx==j),1,C(j,:)')
%         subplot(4,2,[6,8])
%         plot_curve(X2(:,:,idx2(subjInd)==j),1,C(j,:)')
        
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

