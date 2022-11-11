function test_features = get_test_features(testFibers,testW,Mdl)

J=5;
[N,~]=size(Mdl);

for j = 1:length(testFibers{1})
    
    for i = 1:N
        
        X=Mdl{i,1};
        F=Mdl{i,2};
        mdl=Mdl{i,3};
        
        test_features(j,i)=mdl.predict([feature_space_proj(X,{testFibers{i}{j}},F,J),testW(i)']);
        
    end
    
end