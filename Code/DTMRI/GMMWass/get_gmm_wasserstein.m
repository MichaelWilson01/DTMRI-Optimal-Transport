function mw=get_gmm_wasserstein(m0,m1,sigma0,sigma1,pi);

[M,N] = size(pi);
mw=0;

for i = 1:M
    for j = 1:N
        
        mw = mw + pi(i,j)*gaussian_wasserstein(m0(i),m1(j),sigma0{i},sigma1{j});
        
    end
end

