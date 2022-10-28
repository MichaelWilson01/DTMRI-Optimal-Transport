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

tic
[alignedFibers, alignedPi] = median_OT3(Fibers,9);
toc
tic
[alignedFibers3, alignedPi3] = median_OT3(Fibers,30);
toc

save("Data/newData2.mat")