clear all

[alignedFibers,W,labels,med] = load_data_classifier();


parfor i = 1:length(labels)
    
    i
    
    if i ~= med

        %split data
        [trainFibers, testFibers, trainW, testW, trainLabels, testLabels] = split_on_index(alignedFibers, W, labels,i);

        [treeMdl, F, optEps] = feature_space_tree(med, trainFibers, trainW, trainLabels);
        
        crossValMdl=crossVal(treeMdl,F,trainFibers,trainW,trainLabels,med);
        
        testFeatures = get_test_features2(treeMdl,F,testFibers,testW,trainFibers,med);
        
        predictedLabels(i) = crossValMdl.predict(testFeatures);
        
    end    
    
end