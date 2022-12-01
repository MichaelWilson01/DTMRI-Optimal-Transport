function X_mat = curve_to_mat(X)

[curveDim,timeSamples,numFib] = size(X);

X_mat=reshape(permute(X,[3 2 1]), numFib,curveDim*timeSamples)';