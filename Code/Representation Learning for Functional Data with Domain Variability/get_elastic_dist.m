function [X_train, X_test, labels, labels_test] = get_elastic_dist(X,labels);

[M,N] = size(X);
T=0:(1/(N-1)):1;

parfor j = 1:(M/2)
    
    target =X(j,:);
        
    for i = 1:M

        gam = DynamicProgrammingQ_Adam(SRVF(target')',SRVF(X(i,:)')',0,0);
        alignedSource = interp1(gam,X(i,:),T);
        elasticDist(j,i) = norm(SRVF(alignedSource')-SRVF(target'));

    end

end

X_train = elasticDist(:,1:(M/2));
X_test = elasticDist(:,((M/2)+1):end);

labels_test = labels(((M/2)+1):end);
labels = labels(1:(M/2));