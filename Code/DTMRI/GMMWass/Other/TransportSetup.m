function lpp = TransportSetup(C,mu,nu)

    ns = size(C,1);
    nt = size(C,2);
    nx = numel(C);
    
    %f, A ,b, lb
    
    f=C(:);
    
    ind = @(i,j) sub2ind(size(C),i ,j);
    
    A = [];
    b=[];
    c=0;
    
    %Constraints On Source
    for i = 1:ns
        c = c+1;
        for j = 1:nt
            A(c,ind(i,j))=1;
            b(c) = mu(i);
        end
    end
    
    %Contstraints On Target
    for j = 1:nt
        c = c+1;
        for i = 1:ns
            A(c,ind(i,j))=-1;
            b(c) = -nu(j);
        end
    end
    

    lpp.np = ns;
    lpp.nc = nt;
    npp.nx = nx;
    lpp.s = size(C);
    lpp.f = f;
    lpp.A = A;
    lpp.b = b;
    lpp.lb = zeros(nx,1);
    
    
end