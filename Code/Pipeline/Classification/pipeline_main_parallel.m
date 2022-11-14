clear all

[alignedFibers,W,labels,med] = load_data_classifier();

a=1;
tic
parfor i = 1:12%length(labels)
    
    i
    
    if i ~= med
                
        %split data
        [trainFibers, testFibers, trainW, testW, trainLabels, testLabels] = split_on_index(alignedFibers, W, labels,i);

        %validate feature space models on training data
        [Mdl, treeMdl, knnMdl] = validate_models(trainFibers, trainLabels, trainW, med);

        %get features for test data
        test_features = get_test_features(testFibers,testW,Mdl);

        %get training accuracy for test subject i
        treeMdl_test(i)=treeMdl.predict([test_features, testW'])==testLabels';
        knnMdl_test(i)=knnMdl.predict([test_features, testW'])==testLabels';
        
        predictedLabels_tree(i)=treeMdl.predict([test_features, testW']);
        predictedLabels_knn(i)=knnMdl.predict([test_features, testW']);
             
%         a=a+1;
%         
%         treeMdl_testAcc=mean(treeMdl_test)
%         knnMdl_testAcc=mean(knnMdl_test)
        
    end
    
end
toc

treeMdl_testAcc=mean(treeMdl_test)
knnMdl_testAcc=mean(knnMdl_test)

