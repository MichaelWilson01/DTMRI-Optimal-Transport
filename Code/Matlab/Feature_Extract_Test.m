clear all

% Data Folders
dataFolder='C:\Users\micha\Desktop\DTMRI Project\matFiles\';
labelFile='C:\Users\micha\Desktop\DTMRI Project\PTSD_labels.xlsx';

% Parameters
tractName = "Cingulum_Parahippocampal_L"; %which region to analyze
N=400; %number of fibers to sample from each subject
timeSteps=20; %number of time steps per fiber

% Load Data
[Fibers, subjectNum] = get_data(dataFolder,tractName,timeSteps);
labels = get_labels(subjectNum,labelFile);

ind1=[50,52,70,85];
Fibers(ind1)=[];
labels(ind1)=[];

X0=[];
for i = 1:length(Fibers)
    
    X0 = cat(3,X0,datasample(Fibers{i},N,3));
    
end

X0_star=X0;
% X0_star(:,2:end-1,:)=[];

K=10;
W_mat = zeros(length(Fibers));

for i = 9:length(Fibers)
   
tic 
[X, W] = median_OT2(X0_star,labels,N,i);

save("matlab2.mat")

Z  = linkage(curve_to_mat(X)','ward');
idx(:,i) = cluster(Z,'maxclust',K);
W_mat(:,i) = W; 
toc

C=lines(10);

    figure(1)
    clf
    for i = 5%:length(labels)

        subjInd = 1+(i-1)*N:i*N;

        for j = 1:K

            subplot(1,K,j)
            plot_curve(X0(:,:,idx(subjInd)==j),1,C(j,:)')

        end

    end

end
