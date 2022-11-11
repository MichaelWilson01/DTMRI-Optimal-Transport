clear all
load("Data/Cingulum_Parahippocampal_L_9_30.mat")

tic

alignedFibers{1}=alignedFibers1;
alignedFibers{2}=alignedFibers2;
med=[med1,med2];

W=[W1;W2];

J=5;

Features=[];


for i = 1:2
    
    X{i}=alignedFibers{i}{med(i)};
    
    for K = 2:5
        
        %get feature space
        F{i}=feature_space(X{i},K);

        %project into feature_space
        features{i,K} = feature_space_proj(X{i},alignedFibers{i},F{i},J); %returns NxK matrix of features
        
        for maxNumSplits=1:3
            
            %for each feature space, get model
            mdl{K,maxNumSplits,i} = fitctree([features{i,K},W(i,:)'],labels,'MaxNumSplits',maxNumSplits);

            CVmdl = crossval(mdl{K,maxNumSplits,i},'leaveout','on');
            acc(K,maxNumSplits,i) = 1 - kfoldLoss(CVmdl)
    
        end
    
    end
      
end

[a1,a2]=find(acc(:,:,1)==max(max(acc(:,:,1))));
[b1,b2]=find(acc(:,:,2)==max(max(acc(:,:,2))));

x1=mdl{a1,a2,1}.predict([features{1,a1},W(1,:)'])
x2=mdl{b1,b2,2}.predict([features{2,b1},W(2,:)'])
Features=[x1,x2,W']
[m,n] = size(Features);

%fit tree
mdl_Full_tree = fitctree(Features,labels,'MaxNumSplits',sqrt(n))
CVmdl = crossval(mdl,'leaveout','on');
treeAcc = 1 - kfoldLoss(CVmdl)

%fit knn
mdl_Full_knn = fitcknn(Features,labels,'NumNeighbors',floor(sqrt(m)))
CVmdl = crossval(mdl,'leaveout','on');
knnAcc = 1 - kfoldLoss(CVmdl)

toc
