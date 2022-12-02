function C = get_cost_matrix(X,Y,U,muX)

[N,~] = size(X);
[M,~] = size(Y);

for i = 1:N

    A = (U'*X(i,:)'+muX)';

    for j = 1:M

        B = (U'*Y(j,:)'+muX)';
            
        C(i,j) = GeodesicBetweenTwoCurves2(A,B);
        
%         C(i,j) = norm(X(i,:)-Y(j,:));
        
    end
end