function testFeatures=get_test_features2(treeMdl,F,testFibers,testW,trainFibers,med)

J=5;

testFeatures=[];
temp_features=[];

for i = 1:length(med)

        X = trainFibers{i}{med(i)};
    
    for j = 1:length(testFibers{i});
        
        temp_features(j)=treeMdl{i}.predict(feature_space_proj(X,{testFibers{i}{j}},F{i},J));
        
    end
    
    testFeatures = [testFeatures, temp_features'];
    
end

testFeatures=[testFeatures,testW'];