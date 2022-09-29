function [Lambda, Pi, C] = optimal_transport_update(X,Y,Lambda,Theta)

%% Parameters

lr=Theta{1};
eta=Theta{2};
K1=Theta{3};
K2=Theta{4};
g=Theta{5};
U=Theta{6};
V=Theta{7};

[M,N] = size(X);
[yM, yN] = size(Y);

    X_tilde=V(:,1:K2)*Lambda*U(:,1:K1)'*X;
    
    B = registeredCurveSet2(Y);
    A = registeredCurveSet2(X_tilde);
   
%% Calculate Cost Matrix
tic
parfor l = 1:N

        A_star = A(:,:,l);

    for k = 1:yN

%         C(l,k) = mean(vecnorm(A_star - B(:,:,k)));
        C(l,k) = mean(sum((A_star - B(:,:,k)).^2));

    end
    


end
toc

tic
parfor k = 1:yN    
        C2(:,k) = reshape(mean(sum((A-B(:,:,1)).^2,2)),1,200)       
end
toc

tic
for k = 1:yN    
        C3(:,k) = reshape(mean(sum((A-B(:,:,1)).^2,2)),1,200)        
end
toc

%% Calculate Transportation Matrix
Pi = sinkhorn(C,g);


%% Update Lambda with Pi Fixed

deltaLambda=zeros(K2,K1);

parfor k=1:yN
    
    
%     for l = 1:N
%         
%         deltaLambda = deltaLambda + Pi(l,k)*(Lambda*U(:,1:K1)'*X(:,l) - V(:,1:K2)'*(Y(:,k)))*(X(:,l)'*U(:,1:K1)) ;       
%     
%     end
%     tic
    y_temp=V(:,1:K2)'*Y(:,k);
    
    for l = 1:N
        
        A=U(:,1:K1)'*X(:,l);
        
        deltaLambda = deltaLambda + Pi(l,k)*(Lambda*A - y_temp)*(A') ;       
    
    end
%     toc
    
    
end

deltaLambda = deltaLambda + 2*eta*Lambda;

Lambda = Lambda -lr*deltaLambda;% + randn(size(deltaLambda))*.00001;

