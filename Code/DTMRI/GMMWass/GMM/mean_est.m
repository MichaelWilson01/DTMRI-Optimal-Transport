function m_hat = mean_est(X)

mu0 = mean(X,2);
mu0=mu0/norm(mu0);

X_temp = exp_map_inv(mu0,X);
m_hat=exp_map(mu0,mean(X_temp,2));