function Y = exp_map_inv(p,X)

[~,n] = size(X);

for i = 1:n
    
    q = X(:,i);
    q=q/norm(q);
    
    theta = acos(p'*q);
    
    Y(:,i) = (theta/sin(theta))*(q - cos(theta)*p);
    
end
