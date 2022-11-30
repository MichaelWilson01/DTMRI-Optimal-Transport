clear all
clf

N=100;
T=0:(1/199):1;

for M = 1:8;

    [X, labels] = simulate_feature_curves(N,M,T);
    [X2, labels2] = simulate_feature_curves(N,M,T);
    X = [X;X2];
    labels0 = [labels;labels2];
    [X, Z] = get_elastic_dist(X,labels0);
    labels_test=labels2;

    figure(1)
    clf
    imagesc(X)
%     hold on
%     plot(X(labels==0,:)','red')
%     plot(X(labels==1,:)','blue')

    pause(.1)
    
    [mdl{M}, mdlInd{M}] = elastic_feature_learning(X,labels);
    
    %test model
%     [X_test, labels_test] = simulate_feature_curves(N,M,T);
%     Z = get_aligned_features(X_test)';
    mdlAcc(M) = mean(mdl{M}.predict(Z(mdlInd{M},:)')==labels_test')
    
    chosenModelFeatures{M} = X(mdlInd{M},:)';

end

% feature model 
% 0.6600    0.7700    0.5600    0.6900    0.6600    0.7400    0.6800    0.5900

%elastic distance model

