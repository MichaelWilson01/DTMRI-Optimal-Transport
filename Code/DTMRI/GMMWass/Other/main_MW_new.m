clear all

%Parameters
timeSteps=50;
tractName="Cingulum_Parahippocampal_L";

%Load Fiber Data
dataFolder='C:\Users\micha\Desktop\DTMRI Project\matFiles\';
Fibers = get_data(dataFolder,tractName,timeSteps);

%1) get cluster modes - Load clustering data, cluster modes already computed
load(strcat('C:\Users\micha\Desktop\DTMRI Project\Code\KMKM_Hungarian\kmkm\kmkm_cluster_modes\',tractName,'_individual_modes'))






[~,N]=size(Fibers);
%get Fiber counts
parfor i = 1:N
    i
% IDX{i} = get_test_clust_assign(datasample(Fibers{i},1000,3,'replace',false),cluster_modes{i},Inf)
m = min(size(Fibers{i},3),1000);
F{i}=datasample(Fibers{i},m,3,'replace',false);
IDX{i} = get_test_clust_assign(F{i},cluster_modes{i},Inf)

end

%2) calculate covariance matrices for each cluster
[M,W,Sigma] = get_mixture_components(cluster_modes, F, IDX);

%3) calculate gaussian mixture wasserstein
%Get Cost Matrix
[SGMW] = get_cost_matrices(M,W,Sigma)



% Pi = sinkhorn(C,.1)

SGMW = sum(sum(Pi.*C))








MWs = (MW+MW')/2;
[~,sortIdx]=sort(labels);

imagesc(MWs(sortIdx,sortIdx))

save(strcat(tractName,'GMW_results.mat'))