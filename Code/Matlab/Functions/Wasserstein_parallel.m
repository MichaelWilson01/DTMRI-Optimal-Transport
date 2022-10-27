function W = Wasserstein_parallel(Tf1,f2,Pi)

[m, n] = size(Tf1);
[M, N] = size(f2);

W=0;

Tf1 = mat_to_curve(Tf1');
f2  = mat_to_curve(f2');

parfor i = 1:n
    
    for j =1:N
        
        W=W+mean(vecnorm(Tf1(:,:,i)-f2(:,:,j)))*Pi(i,j)/(n*N);
        
    end
    
end

