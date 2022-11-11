clear all
load("Data/Cingulum_Parahippocampal_L_9_30.mat")
% load("newData2.mat")

rng=0;

X1 = Fibers{med1};
X2 = Fibers{med2};

a=1;
b=1;

ind=[3];%,4,5,11];

for K=3%:10%:4

    features=[];
    
    a=1;

    idx1 = kmeans(curve_to_mat(X1)',K);
    idx2 = kmeans(curve_to_mat(X2)',K);

for i =1:K
    
    muX1(:,:,i) = mean(X1(:,:,idx1==i),3);
    muX2(:,:,i) = mean(X2(:,:,idx2==i),3);

end

for J = 5%:5:25

for i = 1:length(Fibers)
    
%     idx1_2{i} = knnsearch(curve_to_mat(muX1)',curve_to_mat(alignedFibers1{i})');
%     idx2_2{i} = knnsearch(curve_to_mat(muX2)',curve_to_mat(alignedFibers2{i})');

    idx1_2{i} = mode(idx1(knnsearch(curve_to_mat(X1)',curve_to_mat(alignedFibers1{i})','K',J))');
    idx2_2{i} = mode(idx2(knnsearch(curve_to_mat(X2)',curve_to_mat(alignedFibers2{i})','K',J))');

end


for i = 1:length(labels)

    for j = 1:K
        
        features(i,j) = sum(idx1_2{i}==j);

    end
    
    features(i,K+1)=W1(i);
    
    for j = (K+2):(2*K+1)
        
        features(i,j) = sum(idx2_2{i}==j);

    end
    
    features(i,2*K+2)=W2(i);

end

mdl1 = fitctree(features,labels,'MaxNumSplits',round(sqrt(2*(K+1))));

trainAcc(a,b) = mean(mdl1.predict(features)==labels');

CVmdl_1 = crossval(mdl1,'leaveout','on');
acc1(b,a) = 1 - kfoldLoss(CVmdl_1)

a=a+1;

end

b=b+1;

end

acc1=[]
for i = 1:300

CVmdl_1 = crossval(mdl1);
acc1(i) = 1 - kfoldLoss(CVmdl_1)

plot(cumsum(acc1)./(1:length(acc1)))
pause(.1)

end

plot(cumsum(acc1)./(1:length(acc1)))

