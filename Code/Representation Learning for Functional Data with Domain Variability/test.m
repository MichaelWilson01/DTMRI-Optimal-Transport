clear all
load('Data.mat')

[N,M] = size(X);

Features = [];

parfor i = 1:N
    
    target_ind = i;
    source_ind=1:N;
%     source_ind(i) =[];
    
    target = X(target_ind,:);
    source = X(source_ind,:);

    Z = feature_space_project_1d(target,source)'; 
    
    Features = [Features, Z];
    
    mdl = fitctree(Z, labels, 'MaxNumSplits',1);
    acc(i) = 1 - kfoldLoss(crossval(mdl,'leaveout','on'));
    
end

[~,sortIdx] = sort(acc);

features_mult = aligned_feature_space_proj(X);
Acc=[];

for m = 1:N
    
%     Mdl = fitctree(Features(:,sortIdx(1:m)), labels, 'MaxNumSplits',m)
%     Mdl = fitcsvm([Features(:,sortIdx(1:m)), features_mult(:,[9,12])], labels);
    Mdl = fitcsvm(Features(:,sortIdx(1:m)), labels);
    
    for i = 1:30
        
        Acc_temp(i) = 1 - kfoldLoss(crossval(Mdl));
        
    end
    
    Acc(m) = mean(Acc_temp)
    
end