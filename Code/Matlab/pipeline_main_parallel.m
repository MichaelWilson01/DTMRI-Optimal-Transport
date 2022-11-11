clear all

[alignedFibers,W,labels,med] = load_data_classifier();

i=1;

parfor i = 1:length(labels)
    
    if i ~= med
                
        %split data
        [trainFibers, testFibers, trainW, testW, trainLabels, testLabels] = split_on_index(alignedFibers, W, labels,i);

        %validate feature space models on training data
        [Mdl{i}, treeMdl{i}, knnMdl{i}] = validate_models(trainFibers, trainLabels, trainW, med);

        %get features for test data
        test_features = get_test_features(testFibers,testW,Mdl{i});

        %get training accuracy for test subject i
        treeMdl_test(i)=treeMdl{i}.predict([test_features, testW'])==testLabels'
        knnMdl_test(i)=knnMdl{i}.predict([test_features, testW'])==testLabels';
        
    end
    
end

treeMdl_test(med)=[];

treeMdl_testAcc=mean(treeMdl_test)
knnMdl_testAcc=mean(knnMdl_test)
