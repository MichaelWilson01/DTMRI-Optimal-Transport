function [SGMW] = get_cost_matrices(M,W,Sigma)

SGMW=zeros(length(M));

for i = 1:(length(M)-1)
    i
    parfor j = (i+1):length(M)
        
%         C{i,j} = get_cost_matrix_sphere2(M{i},M{j},Sigma{i},Sigma{j});
%         
%         lpp = TransportSetup(C{i,j},W{i},W{j});
%         [xopt, fval] = linprog(lpp.f, lpp.A, lpp.b, [], [], lpp.lb);
%         Pi{i,j}=reshape(xopt,size(C{i,j}));
%         
%         SGMW(i,j) = sum(sum(Pi{i,j}.*C{i,j}))
        
        C = get_cost_matrix_sphere2(M{i},M{j},Sigma{i},Sigma{j});
        
        lpp = TransportSetup(C,W{i},W{j});
        [xopt, fval] = linprog(lpp.f, lpp.A, lpp.b, [], [], lpp.lb);
        Pi=reshape(xopt,size(C));
        
%         SGMW(i,j) = sum(sum(Pi.*C))
        
        SGMW_col(j) = sum(sum(Pi.*C));
        
    end
    
    SGMW(i,:) = SGMW_col
    SGMW_col=[];
    
end


