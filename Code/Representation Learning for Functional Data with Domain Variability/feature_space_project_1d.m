function features = feature_space_project_1d(target, source)

[numSource,timeSteps] = size(source);
T=0:(1/(timeSteps-1)):1;

targetFeatures = islocalmax(target);

parfor i = 1:numSource

    gam(i,:) = DynamicProgrammingQ_Adam(SRVF(target')',SRVF(source(i,:)')',0,0);
    alignedSource(i,:) = interp1(T,source(i,:),gam(i,:));

end

features = alignedSource(:,targetFeatures)';