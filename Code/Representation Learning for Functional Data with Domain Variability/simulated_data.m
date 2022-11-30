clear all
clf

M = 1;
N=100;

T=0:(1/99):1;
X=zeros(N,length(T));

w0=[1,1,1];
w1=[1.4,1,1];

for j = 1:M
    
    mu(j) = j/(M+1);
    sigma(j) = (0.1/M);
    
end

for i = 1:N
    
    labels(i) = (i<=(N/2));
    eps(i) = randn;
    
    for j = 1:M
        
        if labels(i)==1 && j==1
        
%             X(i,:) = X(i,:) + ((1+(labels(i)==1)*(1+eps(i)))/(M+1))*normpdf(T,mu(j), sigma(j));
            X(i,:) = X(i,:) + abs(w0(j)*(1+randn/3))*normpdf(T,mu(j), sigma(j));
            
        else
            
%             X(i,:) = X(i,:) + (M - (1+(labels(i)==1)*(1+eps(i)))/(M+1))*normpdf(T,mu(j), sigma(j));
            X(i,:) = X(i,:) + abs(w1(j)*(1+randn/3))*normpdf(T,mu(j), sigma(j));
        
        end
    
    end
    
end



figure(1)
f1 = plot((X(labels==0,:)'), 'red')
hold on
f2 = plot((X(labels==1,:)'), 'blue')
legend([f1(1),f2(1)],'Group 0', 'Group 1', 'FontSize',28)
title("Simulated Data", 'FontSize',36)



figure(2)

features =[];

parfor i =1:N
    
    elastic_features(i,:) = feature_space_project_1d(X(i,:),X);
%     features(i,:) = feature_space_project_1d(mean(X,2)',X);

end

subplot(1,2,1)
imagesc(features)
title("Elastic Distance Matrix", 'FontSize',24)

subplot(1,2,2)
cla
h1 = histogram(A(1,1:50),'BinWidth',2, 'FaceColor','blue', 'FaceAlpha',.8)
hold on
h2 = histogram(A(1,51:100),'BinWidth',2, 'FaceColor','red', 'FaceAlpha',.8)
legend([h1(1),h2(1)],'Group 0', 'Group 1', 'FontSize',18)
title("Histograms for feature 1, by class", 'FontSize',24)

figure(2)

