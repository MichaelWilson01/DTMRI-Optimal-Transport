function T = get_map_step(X,Y,T,Pi,lr,eta)
    [N,m] = size(X);
    [M,n] = size(Y);
    
    deltaT=zeros(m,n);    

    parfor i = 1:N
        for j=1:M            
            deltaT = deltaT + Pi(i,j)*((X(i,:)*T - Y(j,:))'*X(i,:));
        end
    end

      deltaT = deltaT + 2*eta*T;
      T = T -lr*deltaT;

end