clear all
load('Data.mat')

[N,M] = size(X);

for testInd = 1:N
    
trainInd=1:N;
trainInd(testInd)=[];

X_train = X(trainInd,:);
trainLabels = labels(trainInd);
X_test = X(testInd,:);
testLabels = labels(testInd);

[n,~] = size(X_train);

trainFeatures = [];
testFeatures = [];

parfor i = 1:n
    
    target_ind = i;
    source_ind=1:n;
    source_ind(i) =[];
    
    target = X_train(target_ind,:);
    source = X_train;
    testSource=X_test;
    
    Z = feature_space_project_1d(target,source)';
    
    trainFeatures = [trainFeatures, Z];
    testFeatures = [testFeatures, feature_space_project_1d(target,testSource)'];
    
%     mdl = fitctree(Z, trainLabels,'MaxNumSplits',1);    
%     acc(i) = 1 -kfoldLoss(crossval(mdl,'leaveout','on'));
    
end

[~,n] = size(trainFeatures);

parfor i = 1:n
    
    mdl = fitctree(trainFeatures(:,i), trainLabels,'MaxNumSplits',1);
    
    acc(i) = 1 -kfoldLoss(crossval(mdl,'leaveout','on'));
    
end


    [~,sortIdx] = sort(acc,'descend');
  
for m = 1:(N-1)


Mdl = fitcsvm(trainFeatures(:,sortIdx(1:m)), trainLabels, 'KernelFunction','gaussian');
    
    parfor i = 1:30
        
        Acc_temp(i) = 1 - kfoldLoss(crossval(Mdl));
        
    end
    
    Acc(m) = mean(Acc_temp);
    
end

m=find(Acc==max(Acc));

% Mdl = fitctree(trainFeatures,trainLabels,'MaxNumSplits',m(1));
Mdl = fitcsvm(trainFeatures(:,sortIdx(1:m(1))), trainLabels, 'KernelFunction','gaussian');

mdlPrediction(testInd) = Mdl.predict(testFeatures(:,sortIdx(1:m(1))));
Z=double(mdlPrediction==labels(1:testInd));
strcat(string(sum(Z)),"/",string(testInd),"=",string(mean(Z)))

end