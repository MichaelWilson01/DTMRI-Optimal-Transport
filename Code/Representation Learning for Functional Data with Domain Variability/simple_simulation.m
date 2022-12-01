clear all
clf

N=100;
d=-.33;
labels((N/2 +1):N)=1;

for M = 3:100;
    
    elastic_distance=zeros(N);
    acc_temp=zeros(1,30);
   
    X=zeros(2*M+1,N);
    
    for i = 1:(2*M+1)
        
        for j = 1:N
            
            if  i==2 && j<(N/2)
                
                X(i,j) = 1 + d + abs(randn/3);
                
            elseif mod(i,2)==0
                
                X(i,j) = 1 + abs(randn/3);
                
            end
            
        end
        
    end
    
% for i = 1:N
%     for j = 1:N
%         
%         elastic_distance(i,j)=norm(X(:,j)-X(:,i));
%         
%     end
% end
% 
% mdl0{M} = fitctree(elastic_distance,labels,'MaxNumSplits',1);
% 
% for a = 1:30
%     acc_temp(a) = 1 - kfoldLoss(crossval(mdl0{M}));
% end
% 
% acc0(M) = mean(acc_temp);
% 
% mdl1{M} = fitctree(X',labels,'MaxNumSplits',1);
% 
% for a = 1:30
%     acc_temp(a) = 1 - kfoldLoss(crossval(mdl1{M}));
% end
% 
% acc1(M) = mean(acc_temp);
    
end

figure(3)
clf
plot(acc0,'LineWidth',3)
hold on
plot(acc1,'LineWidth',3)
xlabel("Total Number of Peaks","FontSize",24)
ylabel("Model Accuracy","FontSize",24)
title({"Elastic Distance vs Feature Learning,",...
    "Model Accuracy as a function of number of features"},...
    'FontSize',28)
legend("Elastic Distance Model","Feature Learning Model","FontSize",18,'Location','Southwest')

