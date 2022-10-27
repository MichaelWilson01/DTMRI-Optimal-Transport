clear all

%Parameters
K=10;
timeSteps=50;

%Load Data
dataFolder='C:\Users\micha\Desktop\DTMRI Project\mni_matFiles\';
labelFile='C:\Users\micha\Desktop\DTMRI Project\PTSD_labels.xlsx';
[~, tractName] = get_file_identifiers(dataFolder);
tractName=tractName(3);
[Fibers, subjectNum] = get_data(dataFolder,tractName,timeSteps);
labels = get_labels(subjectNum,labelFile);

%Feature Selection: k-means
[cluster_modes, cluster_counts] = get_kmeans_cluster_modes_and_counts(Fibers,K);

N = length(cluster_counts);
correspondence{N,N}=[];

for i = 1:N
    i
    tic
    parfor j = i+1:N
        
        correspondence{i,j} = get_correspondence(cluster_modes{i},cluster_modes{j});
        
        D(i,j) = getFisherRaoDistance_kmeans(correspondence{i,j},cluster_counts{i},cluster_counts{j});
      
    end
    toc
end

D(N,:)=0;
D=D+D';

save(strcat("standard_mni_kmeans_hungarian_",tractName,"_result.mat"))