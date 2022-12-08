clear all

dim=3;
mixNumComp0=1;
mixNumComp1=1;
N=100;
g=.1;% entropic regularization parameter 

%Generate Mixture Distributions
for i = 1:mixNumComp0
    
    [m0(:,i),sigma0(:,:,i),b0(:,:,i)] = generate_GMM_sphere(dim);
    
end

for i = 1:mixNumComp1
    
    [m1(:,i),sigma1(:,:,i),b1(:,:,i)] = generate_GMM_sphere(dim);
    
end

%Generate Random data
[X, idx] = generate_data(m0,sigma0,b0,[100]);%,100,130])
[Y, idy] = generate_data(m1,sigma1,b1,[100]);%,100,100,100])

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
    
    plot3(m0_hat(1,i),m0_hat(2,i),m0_hat(3,i),'red*','LineWidth',4)
    quiver3(m0_hat(1,i),m0_hat(2,i),m0_hat(3,i),...
        b0_hat(1,1,i)*sigma0_hat(1,1,i)/10,...
        b0_hat(2,1,i)*sigma0_hat(1,1,i)/10,...
        b0_hat(3,1,i)*sigma0_hat(1,1,i)/10,'LineWidth',4)
    
    quiver3(m0_hat(1,i),m0_hat(2,i),m0_hat(3,i),...
        b0_hat(1,2,i)*sigma0_hat(2,2,i)/10,...
        b0_hat(2,2,i)*sigma0_hat(2,2,i)/10,...
        b0_hat(3,2,i)*sigma0_hat(2,2,i)/10,'LineWidth',4)
    
  
end


for i = 1:mixNumComp1
    
    [m1_hat(:,i)] = mean_est(Y(:,idy==i));
    [b1_hat(:,:,i), sigma1_hat(:,:,i)] = pc_est(Y(:,idy==i),m1_hat(:,i));

    plot3(m1_hat(1,i),m1_hat(2,i),m1_hat(3,i),'blue*','LineWidth',4)
    quiver3(m1_hat(1,i),m1_hat(2,i),m1_hat(3,i),...
    b1_hat(1,1,i)*sigma1_hat(1,1,i)/10,...
    b1_hat(2,1,i)*sigma1_hat(1,1,i)/10,...
    b1_hat(3,1,i)*sigma1_hat(1,1,i)/10,'LineWidth',4)

    quiver3(m1_hat(1,i),m1_hat(2,i),m1_hat(3,i),...
    b1_hat(1,2,i)*sigma1_hat(2,2,i)/10,...
    b1_hat(2,2,i)*sigma1_hat(2,2,i)/10,...
    b1_hat(3,2,i)*sigma1_hat(2,2,i)/10,'LineWidth',4)
    
end


%Get Cost Matrix

% C = get_cost_matrix_sphere(m0_hat,m1_hat,sigma0_hat,sigma1_hat,b0_hat,b1_hat);


