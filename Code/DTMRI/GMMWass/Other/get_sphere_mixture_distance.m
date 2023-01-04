function GMW = get_sphere_mixture_distance(m0,m1,w0,w1,Sigma0,Sigma1);
        
for i = 1:length(m0)

    for j = 1:length(m1)

        W2(i,j) = sphere_wasserstein(m0(:,i),m1(:,j),Sigma0(:,:,i),Sigma1(:,:,j))

    end

end

Pi = get_coupling(w0,w1)

GMW = sum(sum(W2.*Pi));
    