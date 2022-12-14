clear all

% Data Folders
dataFolder='C:\Users\micha\Desktop\DTMRI Project\matFiles\';
labelFile='C:\Users\micha\Desktop\DTMRI Project\PTSD_labels.xlsx';

% Parameters
tractName = "Cingulum_Parahippocampal_L"; %which region to analyze
timeSteps=20; %number of time steps per fiber

% Load Data
[Fibers, subjectNum] = get_data(dataFolder,tractName,timeSteps);
labels = get_labels(subjectNum,labelFile);

ind1=[50,52,70,85];
Fibers(ind1)=[];
labels(ind1)=[];

med1=9;
med2=30;

tic
[alignedFibers1, W1] = median_OT(Fibers,med1);
toc
tic
[alignedFibers2, W2] = median_OT(Fibers,med2);
toc

save(strcat("Other/Data/",tractName,"_9_30.mat"))