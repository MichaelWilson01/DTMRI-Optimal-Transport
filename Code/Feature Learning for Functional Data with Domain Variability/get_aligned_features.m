function features = get_aligned_features(X)

[gam, muF, fn] = Multiple_Alignment_parallel(X');

[numSource,timeSteps] = size(X);
T=0:(1/(timeSteps-1)):1;

targetFeatures = logical(islocalmax(muF)+islocalmax(-muF));

features = fn(targetFeatures,:)';