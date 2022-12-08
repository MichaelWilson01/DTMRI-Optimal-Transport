function q = SRVF(f)

t=1:length(f(:,1));

binsize = mean(diff(t));


    for i = 1:length(f(1,:))
        
        df=gradient(f(:,i));
        
        q(:,i) = sign(df).*sqrt(abs(df));
        
%         q(:,i) = gradient(f(:,i), binsize)./sqrt(abs(gradient(f(:,i), binsize))+eps);
        
    end
    
    
end

