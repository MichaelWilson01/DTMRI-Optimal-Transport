function features = feature_space_project_1d(target, source)

[numSource,timeSteps] = size(source);
T=0:(1/(timeSteps-1)):1;

targetFeatures = logical(islocalmax(target)+islocalmax(-target));


for i = 1:numSource

    gam(i,:) = DynamicProgrammingQ_Adam(SRVF(target')',SRVF(source(i,:)')',0,0);
%     alignedSource(i,:) = interp1(T,source(i,:),gam(i,:));
    alignedSource(i,:) = interp1(gam(i,:),source(i,:),T);
%     elasticDist(i,:) = norm(SRVF(alignedSource(i,:)')-SRVF(target'));

end

features = [alignedSource(:,targetFeatures)'];%; elasticDist'];
% features = [elasticDist'];