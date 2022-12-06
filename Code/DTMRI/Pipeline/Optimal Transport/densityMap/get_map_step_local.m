function [T, X_new] = get_map_step_local(X,Y,T,Pi,lr,eta)
    [N,m] = size(X);
    [M,n] = size(Y);
    
    deltaT=zeros(m,n,N,M);    

    parfor i = 1:N
%         i
        for j=1:M            
            deltaT(:,:,i,j) = Pi(i,j)*((X(i,:)*T - Y(j,:))'*X(i,:));
        end
    end

    X_new=zeros(size(X));
    T(:,:,N)=0;
    
    parfor a = 1:N
%         a
        [xNeb,xDist] = knnsearch(X,X(a,:),'K',15);
        [yNeb, yDist] = knnsearch(Y,X(a,:),'K',15);
        T(:,:,a)=eye(n);
        for i = 1:N
        if sum(i==xNeb)==1
            for j= 1:M
            if sum(j==yNeb)==1
                T(:,:,a) = T(:,:,a) - lr*deltaT(:,:,i,j);
                X_new(a,:) = (T(:,:,a)*X(a,:)')';
            end
            end
        end
        end
    end
           
    
%       deltaT = deltaT + 2*eta*T;
%       T = T -lr*deltaT;

end