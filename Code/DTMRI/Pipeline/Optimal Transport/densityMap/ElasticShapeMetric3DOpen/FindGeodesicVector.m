function v = FindGeodesicVector(q1,q2,lam)

    
    % Find the optimal coorespondence
    [gam] = DynamicProgrammingQ_Adam(q2/norm(q2),q1/norm(q1),lam,0);
    gam = (gam - gam(1))/(gam(end)-gam(1));

    %%% Applying optimal re-parameterization to the second curve
    X2 = q_to_curve(q2);
    X2n = Group_Action_by_Gamma_Coord(X2,gam);
    q2n = curve_to_q(X2n);


    A = q1*q2n';
    [U,~,V] = svd(A);
    if det(A)> 0
        Ot = U*V';
    else
        Ot = U*([V(:,1) V(:,2) -V(:,3)])';
    end
    X2nn = Ot*X2n;
    q2nn = Ot*q2n;
    
%     InnerProduct(q1-q2,q1-q2)
%     InnerProduct(q1-q2n,q1-q2n)
%     InnerProduct(q1-q2nn,q1-q2nn)
%     pause;


%%%% Geodesic Distance between the registered curves
tmp = InnerProduct(q1,q2nn);
if (abs(tmp)) > 1
    tmp = 1;
end
dist = acos(tmp);
%sprintf('The distance between the two curves is %0.3f',dist)


v = q2nn; % it is same as doing q2n-q1
v = v - InnerProduct(v,q1)*q1;
nv = sqrt(InnerProduct(v,v));
v = dist*v/nv;

