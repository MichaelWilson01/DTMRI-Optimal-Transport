clear all
close all

load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT.mat','Fibers','labels')

maxNumClusters=6;


fullPcaData=[];
fullPcaLabels=[];

for i = 1:length(Fibers)
   
    A=curve_to_mat(Fibers{i});
    
    fullPcaData = [fullPcaData,A];
    fullPcaLabels = [fullPcaLabels; ones(length(A),1)*labels(i)];
    
end

[U_full, S_full, muX]=get_pca_basis(fullPcaData);

% clear fullPcaData;

minPct=0.95;
pctInd = min(find(cumsum(diag(S_full))./sum(diag(S_full))>minPct))
pctObs=sum(diag(S_full(1:pctInd,1:pctInd)))/sum(diag(S_full))

% figure(1)
% clf
% subplot(1,2,1)
% % set(gcf,'Position',[1831 597 561 492])
% plot(cumsum(diag(S_full))./sum(diag(S_full)))
% yline(pctObs)
% xline(pctInd)
% title({"Percent Variation Explained by number of PC's, Full Data"});
% text(pctInd+2,pctObs-.04, {strcat(string(pctInd), " PC's describe ~",string(100*round(pctObs,2)),"% of the variation in the data,"),"across all subjects."})
% 
% pctInd=2;
% pctObs=sum(diag(S_full(1:pctInd,1:pctInd)))/sum(diag(S_full))
% 
% subplot(1,2,2)
% % set(gcf,'Position',[1831 597 561 492])
% plot(cumsum(diag(S_full))./sum(diag(S_full)))
% yline(pctObs)
% xline(pctInd)
% title({"Percent Variation Explained by number of PC's, Full Data"});
% text(pctInd+2,pctObs-.04, {strcat(string(pctInd), " PC's describe ~",string(100*round(pctObs,2)),"% of the variation in the data,"),"across all subjects."})



figure(2)
C=lines(2)
set(gcf,'Position',[1149 305 1396 816])

figure(3)
set(gcf,'Position',[1149 305 1396 816])

pctInd=1;

a=1;
b=1;

for i = 1:length(Fibers)
   
    X=curve_to_mat(Fibers{i});
    
    pcaCoords{i}=(U_full(:,1:pctInd)'*(X-muX))';
    
      
%     if labels(i)==0 && a<=5
% 
%         figure(2)
%         subplot(2,5,a)
%         plot(pcaCoords{i}(:,1),pcaCoords{i}(:,2),'.','Color',C(1,:))
%         title(strcat("Subject ",string(i)), 'FontSize',18)
%         figure(3)
%         subplot(2,5,a)
%         ksdensity(pcaCoords{i})
%         colormap(gca,parula)
%         shading interp
%         title(strcat("Subject ",string(i)), 'FontSize',18)
%         a=a+1;
% 
%     figure(2)
%     sgtitle("Subjects projected into first two PC's, by PTSD status",'FontSize',36)
%     elseif labels(i)==1 && b<=5 
%         
%         figure(2)
%         subplot(2,5,5+b)
%         plot(pcaCoords{i}(:,1),pcaCoords{i}(:,2),'.','Color',C(2,:))
%         title(strcat("Subject ",string(i)), 'FontSize',18)
%         figure(3)
%         subplot(2,5,5+b)
%         f = ksdensity(pcaCoords{i},-60:60)
%         plot(0:1/120:1,f,'Color',C(2,:))
%         colormap(gca,hot)
%         shading interp
%         title(strcat("Subject ",string(i)), 'FontSize',18)
%         b=b+1;
% 
%     figure(3)
%     sgtitle("ksdensity of subjects projected into first two PC's",'FontSize',36)
%     end
%    
%     pause(.1)


if labels(i)==0
figure(10)
hold on
        f = ksdensity(pcaCoords{i},-60:60)
        h1 = plot(0:1/120:1,f,'Color',C(1,:),'LineWidth',2)
else
figure(10)
hold on
        f = ksdensity(pcaCoords{i},-60:60)
        h2 = plot(0:1/120:1,f,'Color',C(2,:),'LineWidth',2)
end

X_a(:,i) = f;
    
%     for K = 5%2:maxNumClusters
%     
%         GMModel_0{i,K} = fitgmdist(pcaCoords{i},K, 'SharedCovariance',true);
% 
%         GMModel_1{i,K} = fitgmdist(pcaCoords{i},K);
%     
%     end

end

legend([h1, h2], "non-PTSD","PTSD",'FontSize',24)

% for K = 2:maxNumClusters
% 
% for i = 1:length(Fibers)
% for j = 1:length(Fibers)
% 
% dist_0(i,j,K) = gmm_dist(GMModel_0{i,K},GMModel_0{j,K})
% dist_1(i,j,K) = gmm_dist(GMModel_0{i,K},GMModel_0{j,K})
% 
% end
% end
% 
% end
% 
% for K = 2:maxNumClusters
% for k = 1:10
% 
%     treeMdl_0{k,K} = fitctree(dist_0(:,:,K),labels,'MaxNumCuts',m)
%     treeMdl_1{k,K} = fitctree(dist_1(:,:,K),labels,'MaxNumCuts',m)
%     knnMdl_0{k,K} = fitcknn(dist_0(:,:,K),labels,'numNeighbors',m)
%     knnMdl_1{k,K} = fitcknn(dist_1(:,:,K),labels,'numNeighbors',m)
% 
% end
% end
