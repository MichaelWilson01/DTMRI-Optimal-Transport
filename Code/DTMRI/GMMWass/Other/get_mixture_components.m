function [M,W,Sigma] = get_mixture_components(cluster_modes, Fibers, IDX)

for i = 1:length(Fibers)
   
    for j = 1:length(unique(IDX{i}))
    
        F2=curve_to_mat(Fibers{i}(:,:,IDX{i}==j));
        F2=F2./vecnorm(F2);
        
        
        m=curve_to_mat(cluster_modes{i}(:,:,j));
        M{i}(:,j) = m/norm(m);
        W{i}(j) = sum(IDX{i}==j)/length(Fibers{i});
        
        cluster_fibers = curve_to_mat(Fibers{i}(:,:,IDX{i}==j));
        A = exp_map_inv(M{i}(:,j),cluster_fibers);
        cluster_fibers = A(:,isnan(sum(A))==0);
        
        Sigma{i}(:,:,j) = cov(cluster_fibers');
        
%         if sum(sum(isnan(Sigma{i}(:,:,j))))
%             
%             pause
%             
%         end
    
    end
    
end