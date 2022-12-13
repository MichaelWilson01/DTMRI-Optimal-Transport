function [m,sigma,b] = generate_GMM_sphere_manual(m,dim);



% B = gram_schmidt(randn(dim));
B = gram_schmidt([m', randn(dim,dim-1)]);

m=B(:,1);
b=B(:,2:end);

% sigma = diag(sort((pi/32)*(1+rand(1,dim-1)),'descend'));
sigma = (pi/32)*diag([sqrt(2),1]);

