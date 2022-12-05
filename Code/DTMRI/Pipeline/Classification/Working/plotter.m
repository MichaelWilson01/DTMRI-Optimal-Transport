K=50
% idx = kmeans(Y,K);
% idx2 = mode(idx(knnsearch(Y,X{end},'K',5)'));
% idx3 = mode(idx(knnsearch(Y,X{1},'K',5)'));

idx =  (knnsearch(Ym,Y,'K',1)');
idx2 = (knnsearch(Ym,X,'K',1)');
idx3 = (knnsearch(Ym,X0,'K',1)');


C = lines(K)
figure(2)
clf
subplot(1,3,3)
for i = 1:K
plot_curve(mat_to_curve((U'*Y(idx==i,:)'+muX)'),1,C(i,:))
end
title("Target Subject, with features",'FontSize',24)

subplot(1,3,2)
for i = 1:K
    A=(U'*X(idx2==i,:)'+muX)';
    [m,n] =size(A);
    if m>1
        plot_curve(mat_to_curve(A),1,C(i,:))
    end
end
ylim([30,75])
xlim([35,60])
title("Source Subject, after Alignment",'FontSize',24)

subplot(1,3,1)
for i = 1:K
    A=(U'*X0(idx3==i,:)'+muX)';
    [m,n] =size(A);
    if m>1
        plot_curve(mat_to_curve(A),1,C(i,:))
    end
end
ylim([30,75])
xlim([35,60])
title("Source Subject, before Alignment",'FontSize',24)

mean(idx2==idx3)