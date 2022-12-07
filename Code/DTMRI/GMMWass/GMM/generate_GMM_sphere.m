function [m0,m1,sigma0,sigma1] = generate_GMM_sphere(dim,mixNum0,mixNum1);

m0=randn(dim,mixNum0);
m0=m0./vecnorm(m0);

m1=randn(dim,mixNum1);
m1=m1./vecnorm(m1);

sigma0=zeros(dim,dim,mixNum0);
sigma1=zeros(dim,dim,mixNum1);

for i = 1:mixNum0

sigma0(:,:,i) = diag(sort(randn(1,dim).^2,'descend'));

end

for i = 1:mixNum1

sigma1(:,:,i) = diag(sort(randn(1,dim).^2,'descend'));

end