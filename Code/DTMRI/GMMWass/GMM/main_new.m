clear all

dim=3;
mixNumComp0=2;
mixNumComp1=3;
N=100;
g=.1;% entropic regularization parameter 

%Generate Mixture Distributions
for i = 1:mixNumComp0
    
    [m0(:,i),sigma0(:,:,i),b0(:,:,i)] = generate_GMM_sphere(dim);
%     [m0(:,i),sigma0(:,:,i),b0(:,:,i)] = generate_GMM_sphere_manual([1,1,1],dim);
    
end

for i = 1:mixNumComp1
    
    [m1(:,i),sigma1(:,:,i),b1(:,:,i)] = generate_GMM_sphere(dim);
%     [m1(:,i),sigma1(:,:,i),b1(:,:,i)] = generate_GMM_sphere_manual([1,1,1],dim);
    
end

mu=N*ones(1,mixNumComp0)/(N*mixNumComp0);
nu=N*ones(1,mixNumComp1)/(N*mixNumComp1);

%Generate Random data
[X, idx] = generate_data(m0,sigma0,b0,N*ones(1,mixNumComp0));
[Y, idy] = generate_data(m1,sigma1,b1,N*ones(1,mixNumComp1));

figure(1)
clf
sphere
shading interp
hold on
plot3(X(1,:),X(2,:),X(3,:),'black*','LineWidth',5)
plot3(Y(1,:),Y(2,:),Y(3,:),'red*','LineWidth',5)


for i = 1:mixNumComp0
    
    [m0_hat(:,i)] = mean_est(X(:,idx==i));
    [b0_hat(:,:,i), sigma0_hat(:,:,i)] = pc_est(X(:,idx==i),m0_hat(:,i));  
    
    plot3(m0_hat(1,i),m0_hat(2,i),m0_hat(3,i),'blue*','LineWidth',4)
    quiver3(m0_hat(1,i),m0_hat(2,i),m0_hat(3,i),...
        b0_hat(1,1,i)*sigma0_hat(1,1,i)/5,...
        b0_hat(2,1,i)*sigma0_hat(1,1,i)/5,...
        b0_hat(3,1,i)*sigma0_hat(1,1,i)/5,'LineWidth',4,'Color','blue')
    
    quiver3(m0_hat(1,i),m0_hat(2,i),m0_hat(3,i),...
        b0_hat(1,2,i)*sigma0_hat(2,2,i)/5,...
        b0_hat(2,2,i)*sigma0_hat(2,2,i)/5,...
        b0_hat(3,2,i)*sigma0_hat(2,2,i)/5,'LineWidth',4,'Color','blue')
    
  
end


for i = 1:mixNumComp1
    
    [m1_hat(:,i)] = mean_est(Y(:,idy==i));
    [b1_hat(:,:,i), sigma1_hat(:,:,i)] = pc_est(Y(:,idy==i),m1_hat(:,i));

    plot3(m1_hat(1,i),m1_hat(2,i),m1_hat(3,i),'blue*','LineWidth',4)
    quiver3(m1_hat(1,i),m1_hat(2,i),m1_hat(3,i),...
    b1_hat(1,1,i)*sigma1_hat(1,1,i)/5,...
    b1_hat(2,1,i)*sigma1_hat(1,1,i)/5,...
    b1_hat(3,1,i)*sigma1_hat(1,1,i)/5,'LineWidth',4,'Color','blue')

    quiver3(m1_hat(1,i),m1_hat(2,i),m1_hat(3,i),...
    b1_hat(1,2,i)*sigma1_hat(2,2,i)/5,...
    b1_hat(2,2,i)*sigma1_hat(2,2,i)/5,...
    b1_hat(3,2,i)*sigma1_hat(2,2,i)/5,'LineWidth',4,'Color','blue')
    
end

%Get Cost Matrix



lpp = TransportSetup(C,mu,nu)
[xopt, fval] = linprog(lpp.f, lpp.A, lpp.b, [], [], lpp.lb);
Pi=reshape(xopt,size(C))

% Pi = sinkhorn(C,.1)

SGMW = sum(sum(Pi.*C))

title(string(SGMW),'FontSize',28)
view(90,2)
