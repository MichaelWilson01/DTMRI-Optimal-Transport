clear all

[alignedFibers,W,labels,med] = load_data_classifier();

a=1;

for i = 1:length(labels)
    
    if i ~= med
        
                
        %split data
        [trainFibers, testFibers, trainW, testW, trainLabels, testLabels] = split_on_index(alignedFibers, W, labels,i);

        %validate feature space models on training data
        [Mdl{a}, treeMdl{a}, knnMdl{a}] = validate_models(trainFibers, trainLabels, trainW, med);

        %get features for test data
        test_features = get_test_features(testFibers,testW,Mdl{a});

        %get training accuracy for test subject i
        treeMdl_test(a)=treeMdl{a}.predict([test_features, testW'])==testLabels'
        knnMdl_test(a)=knnMdl{a}.predict([test_features, testW'])==testLabels';
        
        a=a+1;
        
    end
    
end

treeMdl_testAcc=mean(treeMdl_test)
knnMdl_testAcc=mean(knnMdl_test)

