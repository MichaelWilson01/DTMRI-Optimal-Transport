function F = SRVF_inv_amplitude(Q,fny)
    
    N=length(Q(1,:));
    binsize=1/length(Q);

    for i = 1:N

        sign1=2*((Q(:,i)>0)-.5);
        F(:,i)=cumsum(sign1.*(Q(:,i).^2))+fny(1,i)+Q(1,i).^2;

    end
    
%     F=binsize*F;

end