function lpp = TransportSetup(C,P,D)

    np = size(C,1);
    nc = size(C,2);
    nx = numel(C);
    
    %f, A ,b, lb
    
    d=C(:);
    
    ind = @(i,j) sub2ind(size(C),i ,j)
    
    A = [];
    b=[];
    
    for i = 1:np
        a = zeros(1,nx);
        for j = 1:nc
            a(ind(i,j))=1;
        end
        A = [A;a];
        b = [; P(i)];
    end
    

    lpp.np = np;
    lpp.nc = nc;
    npp.nx = nx;
    lpp.s = size(C);
    lpp.f = f;
    lpp.A = A;
    lpp.b = b;
    
    
    
end