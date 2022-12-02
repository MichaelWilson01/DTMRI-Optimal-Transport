% clear all
%  
% % load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT.mat','Fibers')
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT_1_46.mat')
% % load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Fornix_L_1_35.mat')
%  
% [~,N] = size(alignedFibers);
% J=5;
% maxK=15;
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

% save('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_NEW_Cingulum')

% clear all
% load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\features_NEW_Cingulum')

Features=[];
varName=[];

% for i = 1:N
%     
%     i
%     
%     for K = 2:maxK
%          
% %         mdl = fitctree(features{i,K}, labels, 'MaxNumSplits',1);
%         
%         acc0=[];
% 
%         for j = 1:K
% 
%             mdl = fitctree(features{i,K}(:,j), labels, 'MaxNumSplits',1);
%             
%             if (1 - kfoldLoss(crossval(mdl,"leaveout","on")))>0.65
% 
% %             parfor r = 1:36
% %                 acc0(r) = 1-kfoldLoss(crossval(mdl));
% %             end
% % 
% %             if mean(acc0)>0.65
%             
%                 Features = [Features, features{i,K}(:,j)];
%                 varName= [varName,strcat("S",string(i),"_K",string(K),"_C",string(j))];
% 
% %             end
%             
%             end
%                         
%         end
%         
%     end
%     
%     [~,n] = size(Features);
%     n
%     
% end



for i = 16:N
    
    for K = 2:maxK
         
%         mdl = fitctree(features{i,K}, labels, 'MaxNumSplits',1);
%         
%         acc(i,K) = 1-kfoldLoss(crossval(mdl,'leaveout','on'));

%         mdl = fitcdiscr(features{i,K}, labels);

        parfor r = 1:36
            acc0(r) = 1-kfoldLoss(crossval(mdl));
        end
        
        acc(i,K) = mean(acc0);%-2*std(acc0);
        
    end
   
    acc
    
    if max(acc(i,:))>0.60
    A=find(acc(i,:)==max(acc(i,:)));
    
    Features = [Features, features{i,A(1)}];
    varName= [varName,strcat("S",string(i),"_K",string(K),"_C",string(j))];

    K_list(i)=A(1);
    end
    
end





% Features= [Features,W']
Acc_LOO=[];
Acc_10fold=[];

for m = 1:15

% t = templateTree('maxNumSplits',m);
t = templateDiscriminant();
Mdl = fitcensemble(Features,labels,'Learners',t,'NumLearningCycles',50)
% 
% Mdl = fitcensemble(Features,labels,'Method','AdaBoostM1')

% Mdl = fitctree(Features,labels,'MaxNumSplits',m)
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


