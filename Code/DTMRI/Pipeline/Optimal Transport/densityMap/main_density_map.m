clear all

%Parameters
timeSteps=50;
tractName="Cingulum_Parahippocampal_L";

%Load Fiber Data
dataFolder='C:\Users\micha\Desktop\DTMRI Project\matFiles\';
Fibers = get_data(dataFolder,tractName,timeSteps);

%Parameters
K=15;
g=1;
lr=5e-5;
eta=5;


%2) calculate covariance matrices for each cluster
[pcaCoords,U,muX] = get_pooled_pca_coords(Fibers,.99);

Y = pcaCoords{1};
X{1}= pcaCoords{2};

[~,N] = size(Y);

T{1} = eye(N);


nu = estimate_density(Y,K);
mu = estimate_density(X{1},K);

% nu_tilde = exp_inv(sqrt(nu));
% mu_tilde{1} = exp_inv(sqrt(mu));

nu_tilde = sqrt(nu);
mu_tilde{1} = sqrt(mu);



subplot(3,3,1)
cla
ksdensity(X{1}(:,1:2));
subplot(3,3,3)
cla
ksdensity(Y(:,1:2));

for i = 1:1000
    
    tic
    [TX{i}, T{i+1}] = optimize_step(X{i},Y,mu_tilde{i},nu_tilde,T{1},lr,eta,g);
    toc
    X{i+1} = TX{i};
%     mu_tilde{i+1} = exp_inv(sqrt(estimate_density(X{i+1},K)));
    mu_tilde{i+1} = sqrt(estimate_density(X{i+1},K));

    
%     figure(1)
%     clf
    
%     subplot(1,3,1)
%     plot(Y(:,1),Y(:,2),'.')
%     hold on
%     plot(X{1}(:,1),X{1}(:,2),'.')
    
    subplot(3,3,2)
    cla
    ksdensity(X{i}(:,1:2));
%     plot(Y(:,1),Y(:,2),'.')
%     hold on
%     plot(X{i+1}(:,1),X{i+1}(:,2),'.')
%     
%     subplot(1,3,3)
%     plot(X{1}(:,1),X{1}(:,2),'.')
%     hold on
%     plot(X{i+1}(:,1),X{i+1}(:,2),'.')
    
    sgtitle(string(i))
    
    
    subplot(3,3,4:9)
    cla
    plot_curve(mat_to_curve((U'*Y'+muX)'),1,'black')
    hold on
    plot_curve(mat_to_curve((U'*X{i}'+muX)'),1,0)
    
    pause(.1)
    
end

