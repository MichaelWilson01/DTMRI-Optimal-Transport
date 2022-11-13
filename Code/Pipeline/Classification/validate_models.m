function [Mdl, treeMdl, knnMdl] = validate_models(trainFibers, trainLabels, trainW, med)

J=5;

for i = 1:length(med)
    
    X{i}=trainFibers{i}{med(i)};
    
    for K = 2:5
        
        %get feature space
        F{i,K}=feature_space(X{i},K);

        %project into feature_space
        features{i,K} = feature_space_proj(X{i},trainFibers{i},F{i,K},J); %returns NxK matrix of features
        
        for maxNumSplits=1:3
            
            %for each feature space, get model
            mdl{K,maxNumSplits,i} = fitctree([features{i,K},trainW(i,:)'],trainLabels,'MaxNumSplits',maxNumSplits);

            CVmdl = crossval(mdl{K,maxNumSplits,i},'leaveout','on');
%             CVmdl = crossval(mdl{K,maxNumSplits,i});

            acc(K,maxNumSplits,i) = 1 - kfoldLoss(CVmdl);
    
        end
    
    end
      
end

Features=[];

for i = 1:length(med)
    
    [K_ind mns_Ind] = find(acc(:,:,i)==max(max(acc(:,:,i))));
    
%     [opt_K(i),opt_mns(i)]=find(acc(:,:,i)==max(max(acc(:,:,i))));
    opt_K(i) = K_ind(1);
    opt_mns(i) = mns_Ind(1);
    

    Mdl{i,1} = X{i};
    Mdl{i,2} = F{i,opt_K(i)};
    Mdl{i,3} = mdl{opt_K(i),opt_mns(i),i};
    
    Features = [Features, Mdl{i,3}.predict([features{i,opt_K(i)},trainW(i,:)'])];
%     Features = [Features,features{i,opt_K(i)}];
    
end

Features=[Features,trainW'];
[m,n] = size(Features);

%fit tree
treeMdl = fitctree(Features,trainLabels,'MaxNumSplits',sqrt(n));

%fit knn
% knnMdl = fitcknn(Features,trainLabels,'NumNeighbors',floor(sqrt(m)));
knnMdl = fitcsvm(Features,trainLabels)