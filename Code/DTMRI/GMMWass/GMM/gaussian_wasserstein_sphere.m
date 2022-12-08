function Wg = gaussian_wasserstein_sphere(m0,m1,sigma0,sigma1,b0,b1)


Vt = parallel_transport(b0,a0,a1);

Wg = acos(round(sum(m0/norm(m0).*m1/norm(m1)),4)) + trace(sigma0_T + sigma1 - 2*sqrtm(sqrtm(sigma0_T) * sigma1 * sqrtm(sigma0_T)));


