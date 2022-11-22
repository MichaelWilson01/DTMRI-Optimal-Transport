% clear all
% 
% dataFolder='C:\Users\micha\Desktop\DTMRI Project\matFiles\';
% labelFile='C:\Users\micha\Desktop\DTMRI Project\PTSD_labels.xlsx';
% 
% %Parameters
% timeSteps=20;
% tractName="Cingulum_Parahippocampal_L";
% 
% % Load Data
% [Fibers, subjectNum] = get_data(dataFolder,tractName,timeSteps);
% labels = get_labels(subjectNum,labelFile);
% 
% ind1=[50,52,70,85];
% Fibers(ind1)=[];
% labels(ind1)=[];


load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT_1_46.mat')

N = length(Fibers);


%2) calculate covariance matrices for each cluster
pcaCoords = get_pooled_pca_coords(alignedFibers{9},.99);

K=25;


for i = 1:N
    
[~,D_temp] = knnsearch(pcaCoords{i}(:,1:2),pcaCoords{i}(:,1:2),'K',K)

D{i}=D_temp(:,K);

x = pcaCoords{i}(:,1);
y = pcaCoords{i}(:,2);
z = 1./D{i};

xv = linspace(-60, 60, 120);
yv = linspace(-40, 40, 80);
[X,Y] = meshgrid(xv, yv);
Z = griddata(x,y,z,X,Y);
Z(isnan(Z))=0;

figure(2)
surf(X, Y, Z);

PDF(:,:,i) = Z;%/mean(mean(Z));

end

for i = 1:N
    for j = 1:N
distMat(i,j) = real(acos(mean(mean(sqrt(PDF(:,:,i)).*sqrt(PDF(:,:,j))))));
    end
end

imagesc(distMat)


