function C = get_cost_matrix_sphere2(m0,m1,sigma0,sigma1);


[~,M] = size(m0);
[~,N] = size(m1);

for i = 1:M
    for j = 1:N
        
        C(i,j) = gaussian_wasserstein_sphere(m0(:,i),m1(:,j),sigma0(:,:,i),sigma1(:,:,j));
        
    end
end
    

