clear all

dataFolder='C:\Users\micha\Desktop\DTMRI Project\matFiles\';
labelFile='C:\Users\micha\Desktop\DTMRI Project\PTSD_labels.xlsx';

%Parameters
timeSteps=20;
tractName="Cingulum_Parahippocampal_L";

% Load Data
[Fibers, subjectNum] = get_data(dataFolder,tractName,timeSteps);
labels = get_labels(subjectNum,labelFile);

ind1=[50,52,70,85];
Fibers(ind1)=[];
labels(ind1)=[];


N = length(labels);

K=25;

% 2) calculate covariance matrices for each cluster
pcaCoords = get_pooled_pca_coords(Fibers,.99);

predLik=[];

for i = 1:length(labels)
    
%     pcaCoords = get_pooled_pca_coords(alignedFibers{i},.99);
    
    trainCoords0=[];
    trainCoords1=[];
    testCoords=[];
    a=1;
    b=1;
    
    for j = 1:length(labels)
    
        if j ~=i
            
        if labels(j)==0
            
            trainCoords0 = [trainCoords0; pcaCoords{j}];
            train_labels0(a)=labels(j);
            a=a+1;
            
        else
            
            trainCoords1 = [trainCoords1; pcaCoords{j}];
            train_labels1(b)=labels(j);
            b=b+1;
            
        end

        else

            testCoords=pcaCoords{j};
            test_labels=labels(j);

        end
        
    end
    
    trainCoords0_samp=datasample(trainCoords0,100000,'replace',false);
    trainCoords1_samp=datasample(trainCoords1,100000,'replace',false);
    
    tic
    [L0,L1] = get_likelihood(testCoords,trainCoords0,trainCoords1,K);
    toc
    
    predLik(i) = mean(L0>L1)>.5;
%     predLog(i) = mean(log(L0)-log(L1))<0;
    
    mean(predLik==labels(1:i))
    
end   


    
    