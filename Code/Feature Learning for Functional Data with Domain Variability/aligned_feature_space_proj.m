function features_mult = aligned_feature_space_proj(X)

[N,M] = size(X);

%Multiple alignment approach
[gam, muF, fn] = Multiple_Alignment_parallel(X')

targetFeatures = logical(islocalmax(muF)+islocalmax(-muF));

features_mult = fn(targetFeatures,:)';