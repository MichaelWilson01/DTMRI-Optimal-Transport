function [gam, mean_fn, fn] = Multiple_Alignment_New(X)

    [M N] =size(X);
    T=0:1/(M-1):1;

    %Map data to sphere
    for i = 1:N

        g(:,i)=X(:,i)/norm(X(:,i));

    end

    %point to ExpMapInv into tangent space of - any point would work
    mu_g=mean(g,2);

    %Map points on sphere to tangent space of FR mean in L2
    Z=ExpMapInv2(g,mu_g);

    %Calculate mean in tangent space
    Z_bar=mean(Z,2);

    %Map mean back to sphere
    test1=ExpMap2(Z_bar, mu_g);
    g_bar_pseudo_elastic=test1/norm(test1);

    %Prepare to calculate true mean shape orbit
    g_srvf=SRVF(g);

    g_bar_srvf=SRVF(g_bar_pseudo_elastic);

    %Calculate true mean shape orbit - still need to center in orbit

    parfor i = 1:N

    gam(:,i)=DynamicProgrammingQ_Adam(g_bar_srvf',g_srvf(:,i)',0,0);

    fn(:,i)=interp1(gam(:,i),X(:,i),T);

    end
    
    mean_fn=mean(fn,2);
    
    
end