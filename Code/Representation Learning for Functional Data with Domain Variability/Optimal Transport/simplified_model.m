clear all
 
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT.mat','Fibers')
load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT_1_46.mat')
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Fornix_L_1_35.mat')
 
[~,N] = size(alignedFibers);
J=15;
maxK=15;

for i = 1:N
    
    X{i} = alignedFibers{i}{i};
%     X{i} = Fibers{i};
    
    for K = 2:maxK
        
        F{i,K} = feature_space(X{i},K);        
        features{i,K} = feature_space_proj(X{i},alignedFibers{i},F{i,K},J);
        
    end

    i
    
end

save('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_NEW_Cingulum')

% clear all
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_NEW_Cingulum')

Features=[];
acc=[];

for i = 1:N
    
    for K = 2:maxK
         
        mdl = fitctree(features{i,K}, labels, 'MaxNumSplits',1);
        
%         acc(i,K) = 1-kfoldLoss(crossval(mdl,'leaveout','on'));

        parfor r = 1:30
            acc0(r) = 1-kfoldLoss(crossval(mdl));
        end
        
        acc(i,K) = mean(acc0);%-2*std(acc0);
        
    end
   
    acc
    
%     if max(acc(i,:))>0.6
    A=find(acc(i,:)==max(acc(i,:)));
    Features = [Features, features{i,A(1)}];
    K_list(i)=A(1);
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

for m = 1:15

Mdl = fitctree(Features,labels,'MaxNumSplits',m)
Acc_LOO(m) = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))

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


