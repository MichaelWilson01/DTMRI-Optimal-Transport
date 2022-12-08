function C = get_cost_matrix(m0,m1);

[~,~,M] = size(m0);
[~,~,N] = size(m1);

for i = 1:M
    for j = 1:N
        
        C(i,j) = GeodesicBetweenTwoCurves(m0(:,:,i),m1(:,:,j));
        
    end
end
    

