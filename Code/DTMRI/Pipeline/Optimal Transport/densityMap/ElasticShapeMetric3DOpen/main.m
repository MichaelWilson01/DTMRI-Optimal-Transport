% clear;

    
%     XX = FormSyntheticSpirals(100,25,0);
    
    
    n = size(XX,3);
    N = size(XX,2);
    
    figure(1); clf; hold on;
    set(gca,'fontsize', 18);
    axis equal;
for i=1:n        
%     subplot(5,5,i);
%     plot3(XX(1,:,i),XX(2,:,i),XX(3,:,i),'Linewidth',2);
%     axis equal off;
       
    [q(:,:,i),len1] = curve_to_q(XX(:,:,i));
end
%     pause;

    %% Compute mean shape
    [mu,muX,v,C] = FunMyKarcherMean(q);
    % Display results
    figure(2); clf;
    z = plot3(muX(1,:),muX(2,:),muX(3,:));
    set(z,'LineWidth',3);
    axis equal off;
    set(gca,'fontsize', 18);
    title('Mean shape');

    figure(3); clf; axes('FontSize',20);
    z = plot(C);
    set(z,'LineWidth',3);
    %axis equal;
    grid;
    set(gca,'fontsize', 18);
    title('Cost function during mean computation'); 

%     pause;
    
    %% Display PCA Modes   
    for i = 1:n
        tmp = v(:,:,i);
        vv(:,i) = tmp(:);
    end
    
    muVtmp= mean(vv');
    K = cov(vv');
    [U,S,~] = svd(K);
    sig = sqrt(diag(S));
    
    muV = reshape(muVtmp,size(mu));
    
    tmp = U(:,1);
    vd1 = reshape(tmp,size(mu));
    vd1 = vd1/sqrt(InnerProduct(vd1,vd1));
    
    tmp = U(:,2);
    vd2 = reshape(tmp,size(mu));
    vd2 = vd2/sqrt(InnerProduct(vd2,vd2));
    
    %% Display PCA Components
    figure(100); clf; hold on; 
    for j = 1:9
        tt = 0.2*(j-5)/4;
        for k=1:9
            ttt = 0.2*(k-5)/4;
            
            vd = muV + tt*vd1*sig(1) + ttt*vd2*sig(2);
            
            nv = sqrt(InnerProduct(vd,vd));
            if nv < 0.0001
                qs = mu;
            else
                qs = cos(nv)*mu + sin(nv)*vd/nv;
            end
            Xs = 5*q_to_curve(qs);
            plot3(3*j + Xs(1,:),3*k + Xs(2,:),Xs(3,:),'Linewidth',2);
        end
    end
    axis equal;
    xlabel('First Principal Direction');
    ylabel('Second Principal Direction');
    set(gca,'fontsize', 18);
    title('First two PCA modes');
    
    
    figure(101); clf; 
    plot(sig(1:25),'LineWidth',2);
    set(gca,'fontsize', 18);
    title('Singular values of covariance');

%      pause;

    %% Synthesize new curves
    dd = 10;
    figure(200); clf; hold on; 
    for j = 1:9
        tt = 0.2*(j-5)/4;
        for k=1:9
            ttt = 0.2*(k-5)/4;
            
            cof = sig(1:dd).*randn(dd,1);
            vd = muV + reshape(U(:,1:dd)*cof,size(mu));
            
            %vd = muV + tt*vd1*sig(1) + ttt*vd2*sig(2);
            
            nv = sqrt(InnerProduct(vd,vd));
            if nv < 0.0001
                qs = mu;
            else
                qs = cos(nv)*mu + sin(nv)*vd/nv;
            end
            Xs = 5*q_to_curve(qs);
            plot3(3*j + Xs(1,:),3*k + Xs(2,:),Xs(3,:),'Linewidth',2);
        end
    end
    axis equal;
    set(gca,'fontsize', 18);
    title('Random Shapes from a Gaussian Model on Principal Coefficients');




    