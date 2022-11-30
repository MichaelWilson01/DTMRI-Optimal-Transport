clear all
load('Data.mat')

%for multimodal shape

% for i = 1:39
%     X2(i,:) = (2+randn)*sin(8*pi*T+2*rand)+cos((6+randn)*pi*T) + 8 + 2*randn;
% end
% for i = 40:93
%     X2(i,:) = sin((6+randn)*pi*T)+(2+randn)*cos(8*pi*T+2*rand) + 8 +2*randn;
% end

X2 = -X;

X=[X;X2];
labels = [labels,(labels==0)];

plot(X')

[N,M] = size(X);



for testInd = 1:N
    
trainInd=1:N;
trainInd(testInd)=[];

X_train = X(trainInd,:);
trainLabels = labels(trainInd);
X_test = X(testInd,:);
testLabels = labels(testInd);

[n,~] = size(X_train);

%Multiple alignment approach
[gam, muF, fn] = Multiple_Alignment_parallel(X_train');

trainFeatures = [];
testFeatures = [];

features_train = feature_space_project_1d(muF',X_train)';
features_test = feature_space_project_1d(muF',X_test)';

[n,m] = size(features_train);

acc=[];

for i = 1:m
    
    mdl = fitctree(features_train(:,i),trainLabels,'maxNumSplits',1);
    
%     parfor j = 1:36
%         acc_temp(j) = 1-kfoldLoss(crossval(mdl));
%     end
%     
%     acc(i) = mean(acc_temp);
    
    acc(i) = 1-kfoldLoss(crossval(mdl,'leaveout','on'));
    
end

[~,sortIdx] = sort(acc,'descend');

for i = 1:m
    
    mdl = fitcsvm(features_train(:,sortIdx(1:i)), trainLabels, 'KernelFunction','gaussian');
 
    parfor j = 1:36
        acc_temp(j) = 1-kfoldLoss(crossval(mdl));
    end
    
    acc(i) = mean(acc_temp);

end


mdlInd = find(acc==max(acc));
mdlInd_cell{testInd} = sortIdx(1:mdlInd);

Mdl = fitcsvm(features_train(:,sortIdx(1:mdlInd(1))), trainLabels, 'KernelFunction','gaussian');

mdlPrediction(testInd) = Mdl.predict(features_test(:,sortIdx(1:mdlInd(1))));
Z=double(mdlPrediction==labels(1:testInd));
strcat(string(sum(Z)),"/",string(testInd),"=",string(mean(Z)))

end