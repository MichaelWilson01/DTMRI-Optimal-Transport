function [X_train, X_test, labels, labels_test] = get_elastic_dist(X,labels);

[M,N] = size(X);

for j = 1:(M/2)
    
    target =X(:,j);
    
for i = 1:N
       
    gam(i,:) = DynamicProgrammingQ_Adam(SRVF(target')',SRVF(X(i,:)')',0,0);
    alignedSource(i,:) = interp1(gam(i,:),source(i,:),T);
    elasticDist(i,:) = norm(SRVF(alignedSource(i,:)')-SRVF(X(i,:)'));
    
end

end
X_train = elasticDist(:,1:N);
X_test = elasticDist(:,N+1:end)

labels_test = labels(N+1:end);
labels = labels(1:N);