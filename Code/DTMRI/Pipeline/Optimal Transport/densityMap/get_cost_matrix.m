function C = get_cost_matrix(X,Y)

[N,~] = size(X);
[M,~] = size(Y);

parfor i = 1:N
    for j = 1:M
        
        C(i,j) = norm(X(i,:)-Y(j,:));
        
    end
end