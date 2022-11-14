function crossValMdl=crossVal(treeMdl,F,trainFibers,trainW,trainLabels,med)

J=15;

crossValFeatures=[];
temp_features=[];

for i = 1:length(med)

        X = trainFibers{i}{med(i)};
    
    for j = 1:length(trainFibers{i});
        
%         temp_features(j)=treeMdl{i}.predict(feature_space_proj(X,{trainFibers{i}{j}},F{i},J));
        temp_features(j)=treeMdl{i}.predict([feature_space_proj(X,{trainFibers{i}{j}},F{i},J),trainW(:,j)']);
%         temp_features(j,:)=feature_space_proj(X,{trainFibers{i}{j}},F{i},J);
        
    end
    
    crossValFeatures = [crossValFeatures, temp_features'];
%     crossValFeatures = [crossValFeatures, temp_features];
%     temp_features=[];
        
end

crossValFeatures=[crossValFeatures,trainW'];

[~,n]=size(crossValFeatures);

for maxNumSplits = 1:n
    
    mdl{maxNumSplits}=fitctree(crossValFeatures,trainLabels,'MaxNumSplits',maxNumSplits);
    
    CVmdl = crossval(mdl{maxNumSplits},'leaveout','on');
    acc(maxNumSplits) = 1 - kfoldLoss(CVmdl);
    
end

max(acc)
crossValMdl = mdl{find(acc==max(acc))};

