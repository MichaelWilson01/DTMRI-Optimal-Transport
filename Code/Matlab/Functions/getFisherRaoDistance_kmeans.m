function dist1 = getFisherRaoDistance_kmeans(correspondence,X_counts,Y_counts)

[X_ind Y_ind] = find(correspondence==1);

% transform to squareroot pdf
X = sqrt(X_counts(X_ind)/sum(X_counts(X_ind)));
X=X'/norm(X);

Y = sqrt(Y_counts(Y_ind)/sum(Y_counts(Y_ind)));
Y=Y'/norm(Y);

dist1 = acos(X'*Y);

