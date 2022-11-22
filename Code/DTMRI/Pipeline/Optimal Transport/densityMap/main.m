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

N=93;

parfor i = 1:N
    i
    tic
    for j = 1:N

       for kx = 6

            [muX, sigmaX, countsX] = get_mixture_components(pcaCoords{i},Fibers{i}, kx);
            
            for ky = 6
                
                [muY, sigmaY, countsY] = get_mixture_components(pcaCoords{j},Fibers{j}, ky);

                W(i,j) = gmm_wasserstein(muX, sigmaX, countsX, muY, sigmaY, countsY);
               
            end
            
%             (W0./(1:20))./(1:kx)'

        end
        
%         A = (W0./(1:20))./(1:20)';
%         W(i,j) = min(min(A(2:end,2:end)))

    end
    toc
    
    
end
