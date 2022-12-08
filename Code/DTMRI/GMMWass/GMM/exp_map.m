function U = exp_map(p,V)

    [~,n]=size(V);
    
    for i = 1:n
        
        v=V(:,i);
        U(:,i) = cos(norm(v))*p + sin(norm(v))*v/norm(v);
        
    end