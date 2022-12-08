function F = SRVF_inv(Q)
    
    N=length(Q(1,:));
    binsize=1/length(Q);

    for i = 1:N

        F(:,i)=cumsum((Q(:,i).^2));

    end


end