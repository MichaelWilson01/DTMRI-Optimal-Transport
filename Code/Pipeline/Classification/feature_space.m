function F = feature_space(X,K)

% Z  = linkage(curve_to_mat(X)','ward');
% F = cluster(Z,'maxclust',K);

F = kmeans(curve_to_mat(X)',K);