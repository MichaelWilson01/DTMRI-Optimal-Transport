function mu_tilde = exp_inv(mu)

theta = acos(mean(mu));
mu_tilde = (theta/sin(theta))*(mu - cos(theta)*(1/length(mu)));