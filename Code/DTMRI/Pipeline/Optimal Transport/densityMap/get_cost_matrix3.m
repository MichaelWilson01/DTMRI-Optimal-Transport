function C = get_cost_matrix3(X,Y,U,muX)

[N,~] = size(X);
[M,~] = size(Y);

A=mat_to_curve((U'*X'+muX)');
B=mat_to_curve((U'*Y'+muX)');


parfor i = 1:N
    
    for j = 1:M
        
        C(i,j) = get_streamline_dist(A(:,:,i),B(:,:,j));
        
    end
end