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

X1 = median_OT(Fibers,labels,N,9);

X0=[];
for i = 1:length(Fibers)
    
    X0 = cat(3,X0,datasample(Fibers{i},N,3));
    
end

Z0  = linkage(curve_to_mat(X0)','ward');
Z1  = linkage(curve_to_mat(X1)','ward');

a = 1;
for K = 2:11
    

idx0 = cluster(Z0,'maxclust',K);
idx1 = cluster(Z1,'maxclust',K);

% idx=idx0;
% for i = 1:10
%    
%     tic
% % get shape means
% mu = get_shape_means(X,idx);
% 
% % get idx based on minimum aligned distances 
% idx = update_indices(X,mu)
% toc
% 
% end

C = lines(K);

features0=[];
features1=[];

for i = 1:length(labels)
    
    subjInd = 1+(i-1)*N:i*N;
    figure(1)
    clf

    for j = 1:K

        features0(i,j) = sum(idx0(subjInd)==j);
        features1(i,j) = sum(idx1(subjInd)==j);

        X2=X(:,:,subjInd);
        subplot(2,K,j)
        plot_curve(X0(:,:,idx0(subjInd)==j),1,C(j,:)')
        subplot(2,K,K+j)
        plot_curve(X1(:,:,idx1(subjInd)==j),1,C(j,:)')
        
    end
    
%     pause(1)

end

% D = dist(features');
% 
% figure(1)
% clf
% Z2 = mdscale(D,2)
% plot(Z2(labels==0,1),Z2(labels==0,2),'.')
% hold on
% plot(Z2(labels==1,1),Z2(labels==1,2),'.')

% mdl = fitcensemble(features,labels,'Method','Bag')
% mdl = fitcsvm(features,labels)
% mdl = fitcknn(features,labels,'NumNeighbors',5)
mdl0 = fitcsvm(features0,labels)
mdl1 = fitcsvm(features1,labels)

% mdl0 = fitcknn(features0,labels,'NumNeighbors',5)
% mdl1 = fitcknn(features1,labels,'NumNeighbors',5)

acc0=[];
acc1=[];
parfor i = 1:30
    
CVmdl_0 = crossval(mdl0);
acc0(i) = 1 - kfoldLoss(CVmdl_0);

CVmdl_1 = crossval(mdl1);
acc1(i) = 1 - kfoldLoss(CVmdl_1);

end

figure(2)
subplot(2,5,a)
cla
plot(cumsum(acc0)./(1:length(acc0)))
hold on
plot(cumsum(acc1)./(1:length(acc1)))
legend("Original Data","OT Data")

pause(.01)

a=a+1

end
