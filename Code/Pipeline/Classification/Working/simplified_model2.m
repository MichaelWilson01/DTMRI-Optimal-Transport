clear all

load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT.mat')

[~,N] = size(alignedFibers);

J=15;

for i = 5:N
    
    X{i} = Fibers{i};
    
    for K = 2:5
        
        F{i,K} = feature_space(X{i},K);
        
        features{i,K} = feature_space_proj(X{i},alignedFibers{i},F{i,K},J);
                
    end
    
    i
    
end

Features=[];

for i = 5:46
    
    for K = 2:5
        
        mdl{i,K} = fitctree(features{i,K}, labels, 'MaxNumSplits',2);
        
        acc(i,K) = 1-kfoldLoss(crossval(mdl{i,K},'leaveout','on'));
        
    end
   
    Features = [Features, features{i,find(acc(i,:)==max(acc(i,:)))}];
    
end

Features= [Features,W']


Mdl = fitctree(Features,labels,'MaxNumSplits',2)
1-kfoldLoss(crossval(Mdl,'leaveout','on'))



