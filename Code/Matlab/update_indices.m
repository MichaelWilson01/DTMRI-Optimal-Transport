function idx = update_indices(X,mu)

[~,~,n] = size(mu);

for i = 1:n

[X2_out, dist(i,:)] = Align3d(mu(:,:,i),X);

end

[idx,~]  = find(dist==min(dist));