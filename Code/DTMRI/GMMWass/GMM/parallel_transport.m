function Vt = parallel_transport(V,a0,a1)

[~,n] = size(V)

for i = 1:n

    v = V(:,i);
    Vt(:,i) = v - (2*(v'*a1)/(norm(a0+a1)^2))*(a0+a1)
    
end

