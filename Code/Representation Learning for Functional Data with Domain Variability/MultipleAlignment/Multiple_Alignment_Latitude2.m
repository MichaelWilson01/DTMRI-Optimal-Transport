function [gam_new, mean_fn, fn_new] = Multiple_Alignment_Latitude(X)

[M N] = size(X);

Q=SRVF(X);
I_t=(ones(M,1)/sqrt(M));
T=0:1/(M-1):1;

figure(1)
hold on

for j = 1:M
    
parfor i = 1:N

    Q(:,i)=Q(:,i)/norm(Q(:,i));
    
theta_i = acos(I_t'*Q(:,i));

T_Q(:,i)=(theta_i/sin(theta_i))*(Q(:,i)-cos(theta_i)*I_t);

%calculate norms in tangent space
tangentNorm(i)=norm(T_Q(:,i));

end

%mean norm => mean shape orbit
tangentNormMean(j)=mean(tangentNorm);



% I_t=(ones(M-j,1)/sqrt(M-j));



parfor i = 1:N
    
      normChange=(tangentNormMean(end))/(norm(T_Q(:,i)));
    
      T_Q_mean(:,i)=normChange*(T_Q(:,i)) ;
      
      inShapeOrbit(:,i) = cos(norm(T_Q_mean(:,i)))*I_t + sin(norm(T_Q_mean(:,i)))*(T_Q_mean(:,i))/(norm(T_Q_mean(:,i)));
    
end

    figure(1)
    clf
    plot(Q)

Q=(T_Q);


    
end

parfor i = 1:N

    gam_new(:,i)=DynamicProgrammingQ_Adam(inShapeOrbit(:,1)',inShapeOrbit(:,i)',0,0);
    fn_new(:,i)=interp1(gam_new(:,i),inShapeOrbit(:,i),T);

end

gam_mean=interp1(T,T,mean(gam_new,2));

parfor i = 1:N
   
    gam_star=gam_new(:,i);
    gam_new(:,i)=interp1(gam_mean,gam_star,T);
    fn_new(:,i)=interp1(T,fn_new(:,i),gam_mean);
    
end

mean_fn=mean(fn_new,2);
