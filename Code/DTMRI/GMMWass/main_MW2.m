clear all

%Parameters
tractName="Fornix_L";

%1) get cluster modes - Load clustering data, cluster modes already computed
load(strcat('C:\Users\micha\Desktop\DTMRI Project\Code\KMKM_Hungarian\kmkm\kmkm_cluster_modes\',tractName,'_individual_modes'))

%3) calculate probablistic coupling
Pi = get_coupling2(cluster_counts,1);

%4) calculate gaussian mixture wasserstein
MW = gmm_wasserstein_distance_matrix2(cluster_modes,Pi)

MWs = (MW+MW')/2;
[~,sortIdx]=sort(labels);

imagesc(MWs(sortIdx,sortIdx))


figure(2)
Z = mdscale(dist(MW),2)
plot(Z(labels==0,1),Z(labels==0,2),'.')
hold on
plot(Z(labels==1,1),Z(labels==1,2),'.')

save(strcat(tractName,'GMW_results.mat'))