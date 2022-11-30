clear all
clf

N=1000;
T=0:(1/199):1;

for M = 1:6;

    [X, labels] = simulate_feature_curves(N,M,T);
    [X_train, X_test, labels, labels_test] = get_elastic_dist(X,labels);

    figure(1)
    clf
    hold on
    plot(X(labels==0,:)','red')
    plot(X(labels==1,:)','blue')

    pause(.1)
    
    [mdl{M}, mdlInd{M}] = elastic_feature_learning(X,labels);
    
    %test model
%     [X_test, labels_test] = simulate_feature_curves(N,M,T);
    Z = get_aligned_features(X_test);
    mdlAcc(M) = mean(mdl{M}.predict(Z(:,1:mdlInd{M}))==labels_test')

end

% feature model 
%     0.7160    0.7280    0.7220    0.7120    0.6760    0.6980