function Wg = gaussian_wasserstein_sphere(a0,a1,sigma0,sigma1,b0,b1)


Vt = parallel_transport(b0,a0,a1);
sigma0_T = Vt*sigma0*Vt';

S0 = Vt*sigma0*Vt';
S1 = b1*sigma1*b1';

Wg = acos(round(sum(a0/norm(a0).*a1/norm(a1)),4))...
    + real(trace(S0 + S1 - 2*sqrtm(sqrtm(S0) * S1 * sqrtm(S0))));


