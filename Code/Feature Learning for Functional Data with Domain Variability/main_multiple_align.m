clear all
load('Data.mat')

[N,M] = size(X);

%Multiple alignment approach
[gam, muF, fn] = Multiple_Alignment_parallel(X')

figure(1)
plot(T,muF)

targetFeatures = logical(islocalmax(muF)+islocalmax(-muF));
plot(T,muF)
hold on
plot(T(targetFeatures),muF(targetFeatures),'black*')

features = [fn(targetFeatures,:)',vecnorm(fn-muF)'];
% features = [vecnorm(fn-muF)'];

[n,m] = size(features);

for i = 1:m
    
    mdl = fitctree(features(:,i),labels,'maxNumSplits',1);
    
    acc(i) = 1-kfoldLoss(crossval(mdl));
    
end

acc

for m = 1:10
    
    Mdl = fitctree(features,labels,'MaxNumSplits',m);
    Acc(m) = 1-kfoldLoss(crossval(Mdl,'leaveout','on'));
    Acc10(m) = 1-kfoldLoss(crossval(Mdl));

end

Acc
Acc10

figure(2)
clf
f1 = plot(T,fn(:,labels==1),'blue')
hold on
f2 = plot(T,fn(:,labels==0),'red')
f3 = plot(T,muF,'black','LineWidth',2)
f4 = plot(T(targetFeatures),muF(targetFeatures),'black*','LineWidth',15)
title("Aligned Functions",'FontSize',36)
legend([f1(1) f2(1) f3(1) f4(1)],{'Female','Male', 'Mean','Features'},'FontSize',18)


mdlSVM = fitcsvm(features,labels,'KernelFunction','gaussian')
1 - kfoldLoss(crossval(mdlSVM))



% for m = 1:10
% Mdl = fitctree(features,labels,'MaxNumSplits',length(acc))
mdlSVM = fitcsvm(features(:,[9,12]),labels,'KernelFunction','gaussian')
1 - kfoldLoss(crossval(mdlSVM))

x=6:.05:13;
y=-1:.05:3;
[XX,YY] = meshgrid(x,y);
pred = [XX(:),YY(:)];

p = predict(mdlSVM,pred)

figure(3)
clf
hold on
plot(pred(p==1,1),pred(p==1,2),'.','Color',[0,0,0,.1])
plot(features(labels==0,9),features(labels==0,12),'red*','LineWidth',4)
plot(features(labels==1,9),features(labels==1,12),'blue*','LineWidth',4)
legend("Classifier predicts female","Male","Female",'FontSize',24)
xlabel("Peak 9", 'FontSize',24)
ylabel("Peak 12",'FontSize',24)
title("Feature Space Representation, with SVM Classifier", 'FontSize',36)
% xline(8.74259)
% yline(0.70465)




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