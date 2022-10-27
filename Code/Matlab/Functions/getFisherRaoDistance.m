function dist1 = getFisherRaoDistance(correspondence,X_counts,Y_counts)

[X_ind Y_ind] = find(correspondence==1);

% transform to squareroot pdf
X = sqrt(X_counts(X_ind+1)/sum(X_counts(X_ind+1)));
X=X'/norm(X);

Y = sqrt(Y_counts(Y_ind+1)/sum(Y_counts(Y_ind+1)));
Y=Y'/norm(Y);

dist1 = acos(X'*Y);

