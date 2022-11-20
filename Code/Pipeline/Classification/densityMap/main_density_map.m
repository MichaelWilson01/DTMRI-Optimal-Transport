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
lr=5e-6;
eta=5;


%2) calculate covariance matrices for each cluster
pcaCoords = get_pooled_pca_coords(Fibers,.99);

Y = pcaCoords{1};
X{1}= pcaCoords{2};

[~,N] = size(Y);

T = eye(N);


nu = estimate_density(Y,K);
mu = estimate_density(X{1},K);

nu_tilde = exp_inv(sqrt(nu));
mu_tilde{1} = exp_inv(sqrt(mu));

for i = 101:200
    
    TX{i} = optimize_step(X{i},Y,mu_tilde{i},nu_tilde,T,lr,eta,g);
    X{i+1} = TX{i};
    mu_tilde{i+1} = exp_inv(sqrt(estimate_density(X{i+1},K)));

    
    figure(1)
    clf
    
    subplot(1,3,1)
    plot(Y(:,1),Y(:,2),'.')
    hold on
    plot(X{1}(:,1),X{1}(:,2),'.')
    
    subplot(1,3,2)
    plot(Y(:,1),Y(:,2),'.')
    hold on
    plot(X{i+1}(:,1),X{i+1}(:,2),'.')
    
    subplot(1,3,3)
    plot(X{1}(:,1),X{1}(:,2),'.')
    hold on
    plot(X{i+1}(:,1),X{i+1}(:,2),'.')
    
    sgtitle(string(i))
    
    pause(.1)
    
end

