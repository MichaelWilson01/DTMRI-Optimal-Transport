function [treeMdl, F, optW] = feature_space_tree(medInd, alignedFibers, W, labels);

minNeighbors = 10;
J=5;%k for knn classifiers, in feature_space_project

[~, sortIdx] = sort(W);

X=alignedFibers{medInd};

for k = 2:5
    
    %get feature space
    F{k}=feature_space(X,k);

    %project into feature_space
    features{k} = feature_space_proj(X,alignedFibers,F{k},J); %returns NxK matrix of features
    
    for maxNumSplits = 1:3

        for i = (minNeighbors+1):length(W)

            mdl_temp{k, maxNumSplits, i} = fitctree(features{k}(sortIdx(1:i),:),labels(sortIdx(1:i)),'MaxNumSplits',maxNumSplits);

            CVmdl = crossval(mdl_temp{k,maxNumSplits,i}, 'leaveout','on');
            acc(k,maxNumSplits,i) = 1 - kfoldLoss(CVmdl);
            
        end

    end
    
end

I=find(acc == max(max(max(acc))));
[kInd, mnsInd, wInd] = ind2sub(size(acc),I);

kInd=kInd(1);
mnsInd=mnsInd(1);
wInd=wInd(1);

treeMdl = mdl_temp{kInd, mnsInd, wInd};
optW = W(sortIdx(wInd));
F = F{kInd};


