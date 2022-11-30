function [Mdl, mdlInd] = elastic_feature_learning(X,labels)

features = get_aligned_features(X);

[n,m] = size(features);

acc=[];

%getting individual feature informativeness
for i = 1:m
    
    mdl = fitctree(features(:,i),labels,'maxNumSplits',1);
    
    acc(i) = 1-kfoldLoss(crossval(mdl,'leaveout','on'));
        
end

[~,sortIdx] = sort(acc,'descend');


%Forward Selction Testing
for i = 1:m
    
    mdl = fitctree(features(:,sortIdx(1:i)), labels, 'MaxNumSplits',i);
 
    parfor j = 1:36
        acc_temp(j) = 1-kfoldLoss(crossval(mdl));
    end
    
    acc(i) = mean(acc_temp);

end

%Select best model based on forward Selection
mdlInd = find(acc==max(acc));

Mdl = fitctree(features(:,sortIdx(1:mdlInd(1))), labels, 'MaxNumSplits', mdlInd(1));

end