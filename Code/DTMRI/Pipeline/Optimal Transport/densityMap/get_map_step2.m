function T = get_map_step(X,Y,T,Pi,lr,eta,U,muX)
    [N,m] = size(X);
    [M,n] = size(Y);
    
    deltaT=zeros(m,n);    

    for i = 1:N

        A = (U'*T*X(i,:)'+muX)';

        for j=1:M

            B = (U'*Y(j,:)'+muX)';
            
            [~,Y2] = GeodesicBetweenTwoCurves2(A,B);
            Y2=(U*(curve_to_mat(Y2)-muX))';
            
            deltaT = deltaT + Pi(i,j)*((X(i,:)*T - Y2)'*X(i,:));

        end
    end

      deltaT = deltaT + 2*eta*T;
      T = T -lr*deltaT;

end