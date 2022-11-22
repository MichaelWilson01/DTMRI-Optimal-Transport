clear all

%Parameters
tractName="Cingulum_Parahippocampal_L";

%1) get cluster modes - Load clustering data, cluster modes already computed
load(strcat('C:\Users\micha\Desktop\DTMRI Project\Code\KMKM_Hungarian\kmkm\kmkm_cluster_modes\',tractName,'_individual_modes'))

labels=[];
labels(51:100)=1;


m1=cluster_modes{1}(:,:,1);
m2=cluster_modes{1}(:,:,2);
m3=cluster_modes{1}(:,:,3);
m4=cluster_modes{1}(:,:,4);
m5=cluster_modes{1}(:,:,5);

mu1=cluster_counts{1}(1);
mu2=cluster_counts{2}(2);
mu3=cluster_counts{3}(3);
mu4=cluster_counts{4}(4);
mu5=cluster_counts{4}(5);

sigma=5;

X=[]

for i = 1:50
    
cluster_counts_star{i}=round([(randn*sigma)+mu1,(randn*sigma)+mu3,(randn*sigma)+mu4])
cluster_modes_star{i} = cluster_modes{1}(:,:,[1,3,4]);

end

for i = 51:100
    
cluster_counts_star{i}=round([(randn*sigma)+mu1,(randn*sigma)+mu2,(randn*sigma)+mu5])
cluster_modes_star{i} = cluster_modes{1}(:,:,[1,2,5]);

end


%3) calculate probablistic coupling
Pi = get_coupling2(cluster_counts_star,1);

%4) calculate gaussian mixture wasserstein
MW = gmm_wasserstein_distance_matrix2(cluster_modes_star,Pi)

MWs = (MW+MW')/2;
[~,sortIdx]=sort(labels);

imagesc(MWs(sortIdx,sortIdx))

