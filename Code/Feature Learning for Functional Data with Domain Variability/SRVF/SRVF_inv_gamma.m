function F = SRVF_inv_gamma(Q)
    
    N=length(Q(1,:));
    binsize=1/length(Q);
    
    

    for i = 1:N
        
%         for j = 1:length(Q(:,1))

        F(:,i)=(cumsum((Q(:,i).^2))-cumsum((Q(1,i).^2)))/max(cumsum((Q(:,i).^2))-cumsum((Q(1,i).^2)));
%         F(j,i)=(trapz((Q(1:j,i).^2)));
%         end
        
%         F(:,i)=F(:,i)/F(end,i);
        
    end


end

