clear all
load('Data.mat')

[N,M] = size(X);

%Multiple alignment approach
[gam, muF, fn] = Multiple_Alignment_parallel(X')

figure(1)
plot(T,muF)

targetFeatures = islocalmax(muF);
plot(T,muF)
hold on
plot(T(targetFeatures),muF(targetFeatures),'black*')

features = fn(targetFeatures,:)';

[n,m] = size(features);

for i = 1:m
    
    mdl = fitctree(features(:,i),labels,'maxNumSplits',1)
    
    acc(i) = 1-kfoldLoss(crossval(mdl,'leaveout','on'))
    
end


for m = 1:10
    
    Mdl = fitctree(features,labels,'MaxNumSplits',m)
    Acc(m) = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))

end


figure(2)

plot(T,fn(:,labels==1),'blue')
hold on
plot(T,fn(:,labels==0),'red')
plot(T,muF,'black','LineWidth',2)
plot(T(targetFeatures),muF(targetFeatures),'black*','LineWidth',4)




% for m = 1:10
% Mdl = fitctree(features,labels,'MaxNumSplits',length(acc))
% % Mdl = fitcsvm(features,labels)
% 
% Acc(m) = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))
% end

% for i = 1:N
%     
%     %within subject feature extraction
%     features = islocalmax(X(i,:));
%     plot(T,X(i,:))
%     hold on
%     plot(T(features),X(i,features),'r*')
%     
%     %pairwise alignment
%     
%     
%     %across subject feature learning
%     
% end
% 
% %classification