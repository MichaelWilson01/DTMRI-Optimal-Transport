function [treeMdl, FeatureSpace, optEps] = feature_space_tree(med, trainFibers, trainW, labels);

minNeighbors = 10;
maxNeighbors=50;

J=15;%k for knn classifiers, in feature_space_project

for m = 1:length(med)
    
    medInd = med(m);
    alignedFibers=trainFibers{m};
    W =trainW(m,:);

    [~, sortIdx] = sort(W);

    X=alignedFibers{medInd};

    for k = 2:5

        %get feature space
        F{k}=feature_space(X,k);

        %project into feature_space
        features{k} = feature_space_proj(X,alignedFibers,F{k},J); %returns NxK matrix of features
%         features{k} = [feature_space_proj(X,alignedFibers,F{k},J), trainW']; %returns NxK matrix of features

        for maxNumSplits = 1:3

            for i = (minNeighbors):5:maxNeighbors;%

                mdl_temp{k, maxNumSplits, i} = fitctree(features{k}(sortIdx(1:i),:),labels(sortIdx(1:i)),'MaxNumSplits',maxNumSplits);

                CVmdl = crossval(mdl_temp{k,maxNumSplits,i}, 'leaveout','on');
                acc(k,maxNumSplits,i) = 1 - kfoldLoss(CVmdl);

            end

        end

    end

    max(max(max(acc)))
    I=find(acc == max(max(max(acc))));
    [kInd, mnsInd, wInd] = ind2sub(size(acc),I);

    kInd=kInd(1);
    mnsInd=mnsInd(1);
    wInd=wInd(1);

    treeMdl{m} = mdl_temp{kInd, mnsInd, wInd};
    optEps{m} = W(sortIdx(wInd));
    FeatureSpace{m} = F{kInd};

end




