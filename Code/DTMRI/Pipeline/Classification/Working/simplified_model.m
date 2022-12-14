clear all
 
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT.mat','Fibers')
load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT_1_46.mat')
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Fornix_L_1_35.mat')
 
[~,N] = size(alignedFibers);
J=5;
maxK=15;

for i = 31;%1:N
    
    X{i} = alignedFibers{i}{i};
%     X{i} = Fibers{i};
    
    for K = 2:maxK
        
        F{i,K} = feature_space(X{i},K);        
        features{i,K} = feature_space_proj(X{i},alignedFibers{i},F{i,K},J);
        
    end

    i
    
end


 
% % % save(strcat('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_heir_Cingulum_J_',string(J)),'features', 'labels', 'W', 'N', 'maxK')
load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_Cingulum_J_5.mat')
% 
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_Fornix_J_5.mat')
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Fornix_L_1_35.mat','W')
% N=35;
% maxK=5;
% 
% 
% % load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features1.mat')
% % N=46;
% % J=5;
% % maxMNS=10;
% % maxK=15;
% % 
% % load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_Cingulum_J_5.mat','W')


Features=[];
acc=[];

for i = 29;%1:N
    
    for K = 2:maxK
         
        mdl = fitctree(features{i,K}, labels, 'MaxNumSplits',1);
        
%         acc(i,K) = 1-kfoldLoss(crossval(mdl,'leaveout','on'));

        parfor r = 1:30
            acc0(r) = 1-kfoldLoss(crossval(mdl));
        end
        
        acc(i,K) = mean(acc0);%-2*std(acc0);
        
    end
   
    acc
    
%     if max(acc(i,:))>0.55
%     A=find(acc(i,:)==max(acc(i,:)));
    Features = [Features, features{i,:}];
%     K_list(i)=A(1);
%     end
    
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

for i = 1:46

Features=features{31,7}

for m = 1:15
% % for j = 80
% t = templateTree('MaxNumSplits',m);
% % % % % % % t = templateDiscriminant();
% % % % % % % t = templateKNN('NumNeighbors',m);
% Mdl = fitcensemble(Features,labels,'Learners',t, 'NumLearningCycles',10)
% % % Mdl = fitcensemble(Features,labels,'Learners',t, 'OptimizeHyperparameters',{'NumLearningCycles'})


Mdl = fitctree(Features,labels,'MaxNumSplits',m)
Acc_LOO(i,m) = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))
% Acc_10fold(m) = 1-kfoldLoss(crossval(Mdl))
% end
end

end

% parfor m = 1:120
%     
%     Acc_10fold(m) = 1-kfoldLoss(crossval(Mdl))
%     
% end
% 
% Acc_LOO
% mean(Acc_10fold)

% trainAcc = mean(Mdl.predict(Features)==labels')
% looAcc = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))
% kfoldAcc = 1-kfoldLoss(crossval(Mdl))


