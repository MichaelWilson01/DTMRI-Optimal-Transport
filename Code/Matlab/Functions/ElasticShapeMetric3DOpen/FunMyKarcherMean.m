function [mu,muX,v,C] = FunMyKarcherMean(q)

    n = size(q,3);

    mu  = q(:,:,ceil(rand*n));
    muX = q_to_curve(mu);

    % Iterations for computing mean
    stps = 0.5;
    for iter=1:10
        meanv = zeros(size(mu));
        for i=1:n
            v(:,:,i) = FindGeodesicVector(mu,q(:,:,i),0);
            meanv = meanv + v(:,:,i)/(n);

        end
        nv = sqrt(InnerProduct(meanv,meanv))
        mu = cos(stps*nv)*mu + sin(stps*nv)*meanv/(nv);
        C(iter)= nv;

    end
    muX = q_to_curve(mu);

