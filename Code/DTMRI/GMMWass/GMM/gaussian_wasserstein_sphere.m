function Wg = gaussian_wasserstein_sphere(m0,m1,sigma0,sigma1)

% for i = 1:N
%     for j = 1:M
        
        Wg = acos(round(sum(m0/norm(m0).*m1/norm(m1)),4)) + trace(sigma0 + sigma1 - 2*sqrtm(sqrtm(sigma0) * sigma1 * sqrtm(sigma0)));

%     end
% end
