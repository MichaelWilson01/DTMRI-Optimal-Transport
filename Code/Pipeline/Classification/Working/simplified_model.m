clear all
 
% % load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT.mat','Fibers')
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT_1_46.mat')
% % load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Fornix_L_1_35.mat')
%  
% [~,N] = size(alignedFibers);
% J=5;
% maxK=10;
% 
% for i = 1:N
%     
%     X{i} = alignedFibers{i}{i};
% %     X{i} = Fibers{i};
%     
%     for K = 2:maxK
%         
%         F{i,K} = feature_space(X{i},K);        
%         features{i,K} = feature_space_proj(X{i},alignedFibers{i},F{i,K},J);
%         
%     end
% 
%     i
%     
% end
 
% % save(strcat('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_heir_Cingulum_J_',string(J)),'features', 'labels', 'W', 'N', 'maxK')
load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_Cingulum_J_5.mat')

% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_Fornix_J_5.mat')
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Fornix_L_1_35.mat','W')
% N=35;
% maxK=5;


% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features1.mat')
% N=46;
% J=5;
% maxMNS=10;
% maxK=15;
% 
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_Cingulum_J_5.mat','W')


Features=[];
acc=[];

for i = 1:N
    
    parfor K = 2:maxK
         
        mdl = fitctree(features{i,K}, labels, 'MaxNumSplits',sqrt(K));
        
        acc(i,K) = 1-kfoldLoss(crossval(mdl,'leaveout','on'));
        
    end
   
    acc
    
    A=find(acc(i,:)==max(acc(i,:)));
    Features = [Features, features{i,A(1)}];
    K_list(i)=A(1);
    
end


varName=[];



for i = 1:length(K_list)
    for j = 1:K_list(i)
        
        varName= [varName,strcat("S",string(i),"_C",string(j),"/",string(K_list(i)))];
        
    end
end


Features= [Features,W']
Acc_LOO=[];
Acc_10fold=[];

for m = 1:15

t = templateTree('MaxNumSplits',m);
% % % % t = templateDiscriminant();
% % % % t = templateKNN('NumNeighbors',m);
Mdl = fitcensemble(Features,labels,'Learners',t, 'NumLearningCycles',75)
% Mdl = fitcensemble(Features,labels,'Learners',t, 'OptimizeHyperparameters',{'NumLearningCycles'})


% Mdl = fitctree(Features,labels,'MaxNumSplits',m)
Acc_LOO(m) = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))
% Acc_10fold(m) = 1-kfoldLoss(crossval(Mdl))

end

Acc_LOO
Acc_10fold

% trainAcc = mean(Mdl.predict(Features)==labels')
% looAcc = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))
% kfoldAcc = 1-kfoldLoss(crossval(Mdl))
