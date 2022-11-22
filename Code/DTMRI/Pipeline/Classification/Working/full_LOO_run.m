for j = 1:89
        
    features_train=features;
    W_train = W;
    ind = 1:89;
    ind(j)=[];
    
    if j<=46
        
        features_train(j,:)=[];
        W_train(j,:)=[];
        
    end
    
    W_j=W_train(:,j);
    W_train(:,j)=[];
    
    
    Features=[];
    acc=[];
            
    labels_train = labels;
    labels_train(j)=[];
    
    test_label = labels(j)
    test_features=[];


for i = 1:length(features_train)

    
    parfor K = 2:maxK
         
        X=features_train{i,K};
        X(j,:)=[];        
        
        mdl = fitctree(X, labels_train, 'MaxNumSplits',1);
        
        acc(i,K) = 1-kfoldLoss(crossval(mdl,'leaveout','on'));
        
    end
   
%     acc
    
    
    A=find(acc(i,:)==max(acc(i,:)));
    
    Z=features_train{i,A(1)};
    Z(i,:)=[];
    
    Features = [Features, Z];
    test_features = [test_features, features{ind(i),A(1)}(j,:)];
    K_list(i)=A(1);
    
end

Features = [Features, W_train'];
test_features = [test_features, W_j']

t = templateTree('MaxNumSplits',1);
Mdl = fitcensemble(Features,labels_train,'Learners',t, 'NumLearningCycles',50)

LOO_acc(j) = Mdl.predict(test_features)==test_label

end

mean(LOO_acc)