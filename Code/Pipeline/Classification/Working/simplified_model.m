clear all

load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT_1_46.mat')

[~,N] = size(alignedFibers);

J=5;

maxMNS=10;
maxK=15;

for i = 1:N
    
    X{i} = alignedFibers{i}{i};
    
    for K = 2:maxK
        
        F{i,K} = feature_space(X{i},K);
        
        features{i,K} = feature_space_proj(X{i},alignedFibers{i},F{i,K},J);
                
    end
    
    i
    
end

Features=[];
acc=[];

for i = 1:N
    
    parfor K = 2:maxK
        
%         mdl{i,K} = fitctree(features{i,K}, labels, 'MaxNumSplits',2);
%         
%         acc(i,K) = 1-kfoldLoss(crossval(mdl{i,K},'leaveout','on'));
         
        mdl = fitctree(features{i,K}, labels, 'MaxNumSplits',1);
        
        acc(i,K) = 1-kfoldLoss(crossval(mdl,'leaveout','on'));
        
    end
   
    acc
    
    A=find(acc(i,:)==max(acc(i,:)));
    Features = [Features, features{i,A(1)}];
    K_list(i)=A(1);
    
end

save('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features1','features', 'labels')

Features= [Features,W']


Acc_LOO=[];
Acc_10fold=[];

for m = 4:9%1:15

% t = templateTree('MaxNumSplits',m);
% % t = templateDiscriminant();
% % t = templateKNN('NumNeighbors',m);
% Mdl = fitcensemble(Features,labels,'Learners',t)

Mdl = fitctree(Features,labels,'MaxNumSplits',m)
Acc_LOO(m) = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))
Acc_10fold(m) = 1-kfoldLoss(crossval(Mdl))

end
plot(Acc)

trainAcc = mean(Mdl.predict(Features)==labels')
looAcc = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))
kfoldAcc = 1-kfoldLoss(crossval(Mdl))

