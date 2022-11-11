function F = feature_space(X,K)

F = kmeans(curve_to_mat(X)',K);