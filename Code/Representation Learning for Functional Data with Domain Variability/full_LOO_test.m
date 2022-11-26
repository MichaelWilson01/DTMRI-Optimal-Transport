clear all
load('Data.mat')

[N,M] = size(X);

features_mult = aligned_feature_space_proj(X);

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
    
    trainFeatures = [trainFeatures, feature_space_project_1d(target,source)'];
    testFeatures = [testFeatures, feature_space_project_1d(target,testSource)'];
    
end

% trainFeatures = [trainFeatures, features_mult(trainInd,[9,12])];
% testFeatures = [testFeatures, features_mult(testInd,[9,12])];
    
    
for m = 1:10
Mdl = fitctree(trainFeatures,trainLabels,'MaxNumSplits',m);
% Acc(m) = 1-kfoldLoss(crossval(Mdl,'leaveout','on'));
Acc(m) = 1-kfoldLoss(crossval(Mdl));
end

m=find(Acc==max(Acc));

Mdl = fitctree(trainFeatures,trainLabels,'MaxNumSplits',m(1));

mdlPrediction(testInd) = Mdl.predict(testFeatures);
Z=double(mdlPrediction==labels(1:testInd));
strcat(string(sum(Z)),"/",string(testInd),"=",string(mean(Z)))

end