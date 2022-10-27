clear all

%Parameters
K=100;
timeSteps=50;

%Load Data
dataFolder='C:\Users\micha\Desktop\DTMRI Project\matFiles\';
labelFile='C:\Users\micha\Desktop\DTMRI Project\PTSD_labels.xlsx';
[~, tractName] = get_file_identifiers(dataFolder);
tractName=tractName(1);
[Fibers, subjectNum] = get_data(dataFolder,tractName,timeSteps);
labels = get_labels(subjectNum,labelFile);

%Feature Selection: k-means
% [cluster_modes, cluster_counts] = get_kmeans_cluster_modes_and_counts(Fibers,K);

N = length(labels);
correspondence{N,N}=[];

for i = 1:N
    i
    tic
    
    muX= zeros(3,50,K);
    
    idx = kmeans(curve_to_mat(Fibers{i})',K);
    
    for i1 = 1:K
        
        muX(:,:,i1) = mean(Fibers{i}(:,:,idx==i1),3);
        
    end
    
    X=gpuArray(muX);
    
    tic
    parfor j = 1:N
        
        muY= zeros(3,50,K);
        
        idx = kmeans(curve_to_mat(Fibers{j})',K);

        for i1 = 1:K

            muY(:,:,i1) = mean(Fibers{j}(:,:,idx==i1),3);

        end

        Y=muY;
        
        %Initialize optimizer with data
        FOT=FOT_optimizer2(X,gpuArray(Y));

        %Set Parameters
        FOT.max_iter=100;
        FOT.lr=4e-9;
        FOT.gamma_h=1;
        FOT.eta=10;
        FOT.k_x = 150;
        FOT.k_y=150;

        %Find Optimal Transport plan (with Sinkhorn)
        FOT.optimize()
        
        TX = mat_to_curve(gather(FOT.T * FOT.X)');
        
        D(i,j) = Wasserstein(curve_to_mat(TX),curve_to_mat(Y),gather(FOT.Pi)'); 
        
    end
    toc
    imagesc(D)
    pause(.3)
end

save(strcat("Optimal_Transport_",tractName,"_result.mat"))