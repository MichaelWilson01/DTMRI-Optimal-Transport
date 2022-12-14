clear all

dim=3;
mixNum0=4;
mixNum1=4;
g=.1;% entropic regularization parameter 

%Generate Data
[m0,m1,sigma0,sigma1] = generate_GMM_sphere(dim,mixNum0,mixNum1);

% %Sanity check #1: distance should be 0
% m0=m1;
% sigma0=sigma1;

figure(1)
clf
sphere
shading interp
hold on
plot3(m0(1,:),m0(2,:),m0(3,:),'black*','LineWidth',5)
plot3(m1(1,:),m1(2,:),m1(3,:),'red*','LineWidth',5)


%Get Cost Matrix
C = get_cost_matrix(m0,m1,sigma0,sigma1);

%Get Coupling
Pi = sinkhorn(C,g);

%Calculate Mixture Wasserstein
GMW = sum(sum(Pi.*C))



