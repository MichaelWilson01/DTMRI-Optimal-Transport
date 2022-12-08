function [m,sigma,b] = generate_GMM_sphere(dim);

B = gram_schmidt(randn(dim));

m=B(:,1);
b=B(:,2:end);

sigma = diag(sort((pi/32)*(1+rand(1,dim-1)),'descend'));

