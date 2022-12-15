K= 10
idx =  kmeans(Ym,K)
idx2 = mode(idx(knnsearch(Ym,X{1},'K',10)'));
idx3 = mode(idx(knnsearch(Ym,X{end},'K',10)'));

C = lines(K)
figure(2)
clf
subplot(1,3,3)
for i = 1:K
plot_curve(mat_to_curve((U'*Ym(idx==i,:)'+muX)'),1,C(i,:))
end
title("Target Subject, with features",'FontSize',28)
ylim([30,65])
xlim([35,60])

subplot(1,3,2)
for i = 1:K
A=(U'*X{end}(idx3==i,:)'+muX)';
[m,n] =size(A);
if m>1
plot_curve(mat_to_curve(A),1,C(i,:))
end
end
ylim([30,65])
xlim([35,60])
title("Source Subject, after Alignment",'FontSize',28)

subplot(1,3,1)
for i = 1:K
A=(U'*X{1}(idx2==i,:)'+muX)';
[m,n] =size(A);
if m>1
plot_curve(mat_to_curve(A),1,C(i,:))
end
end
ylim([30,65])
xlim([35,60])
title("Source Subject, before Alignment",'FontSize',28)
mean(idx2==idx3)