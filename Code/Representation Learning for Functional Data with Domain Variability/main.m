clear all
load('Data.mat')

[N,M] = size(X);

Features = [];

for i = 1:N
    
    target_ind = i;
    source_ind=1:N;
    source_ind(i) =[];
    
    target = X(target_ind,:);
    source = X;
    
    Features = [Features, feature_space_project_1d(target,source)'];
    
end
    
    
for m = 1:10
Mdl = fitctree(Features,labels,'MaxNumSplits',m)
Acc(m) = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))
end