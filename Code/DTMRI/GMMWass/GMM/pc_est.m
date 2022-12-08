function [b_hat, sigma_hat] = pc_est(X,m_hat)

[m,n] = size(X);

Z = exp_map_inv(m_hat,X);

[U,S,~] = svd(Z*Z');

b_hat = U(:,1:(m-1));
sigma_hat = S(1:(m-1),1:(m-1));
