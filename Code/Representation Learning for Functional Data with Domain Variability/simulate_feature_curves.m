function [X, labels] = simulate_feature_curves(N,M,T)

X=zeros(N,length(T));


w0=[1,ones(1,M-1)];
w1=[1.4,ones(1,M-1)];

for j = 1:M
    
    mu(j) = j/(M+1);
    sigma(j) = (0.1/M);
    
end

for i = 1:N
    
    labels(i) = (i<=(N/2));
    eps(i) = randn;
    
    for j = 1:M
        
        if labels(i)==1 && j==1
        
%             X(i,:) = X(i,:) + ((1+(labels(i)==1)*(1+eps(i)))/(M+1))*normpdf(T,mu(j), sigma(j));
            X(i,:) = X(i,:) + abs(w0(j)*(1+randn/3))*normpdf(T,mu(j), sigma(j));
            
        else
            
%             X(i,:) = X(i,:) + (M - (1+(labels(i)==1)*(1+eps(i)))/(M+1))*normpdf(T,mu(j), sigma(j));
            X(i,:) = X(i,:) + abs(w1(j)*(1+randn/3))*normpdf(T,mu(j), sigma(j));
        
        end
    
    end
    
end
