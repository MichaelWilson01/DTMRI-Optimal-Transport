clear all

% Data Folders
dataFolder='C:\Users\micha\Desktop\DTMRI Project\matFiles\';
labelFile='C:\Users\micha\Desktop\DTMRI Project\PTSD_labels.xlsx';

% Parameters
tractName = "Cingulum_Parahippocampal_L"; %which region to analyze
N=200; %number of fibers to sample from each subject
timeSteps=20; %number of time steps per fiber

% Load Data
[Fibers, subjectNum] = get_data(dataFolder,tractName,timeSteps);
labels = get_labels(subjectNum,labelFile);

ind1=[50,52,70,85];
Fibers(ind1)=[];
labels(ind1)=[];

Y0= gpuArray(datasample(Fibers{9},N,3,'Replace',false));
X = gpuArray(datasample(Fibers{1},N,3,'Replace',false));

[l,m,n] = size(Y0);

FOT=FOT_optimizer(X,Y0);

        %Set Parameters
        FOT.max_iter=1;
        FOT.lr=4e-9;
        FOT.gamma_h=1;
        FOT.eta=10;
        FOT.k_x = l*m;
        FOT.k_y=l*m;

        %Find Optimal Transport plan (with Sinkhorn)
        FOT.optimize()

for i = 1:100
    
    FOT.optimize_step()
    figure(1)
    clf
    plot_curve(mat_to_curve(gather(FOT.T * FOT.X)'),1,0)
    pause(.01)

end