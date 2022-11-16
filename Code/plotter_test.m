view(Mdl,'Mode','graph')

figure(1)
plot(Features(labels==0,179),Features(labels==0,404),'.')
hold on
plot(Features(labels==1,179),Features(labels==1,404),'.')
xline(254)
yline(82)


figure(2)
C=lines(5)
plot_curve(alignedFibers{7}{7}(:,:,F{7,5}==1),1,C(1,:))
plot_curve(alignedFibers{7}{7}(:,:,F{7,5}==2),1,C(2,:))
plot_curve(alignedFibers{7}{7}(:,:,F{7,5}==3),1,C(3,:))
plot_curve(alignedFibers{7}{7}(:,:,F{7,5}==4),1,C(4,:))
plot_curve(alignedFibers{7}{7}(:,:,F{7,5}==5),1,C(5,:))



C=lines(6)
plot_curve(alignedFibers{22}{22}(:,:,F{22,6}==1),1,C(1,:))
plot_curve(alignedFibers{22}{22}(:,:,F{22,6}==2),1,C(2,:))
plot_curve(alignedFibers{22}{22}(:,:,F{22,6}==3),1,C(3,:))
plot_curve(alignedFibers{22}{22}(:,:,F{22,6}==4),1,C(4,:))
plot_curve(alignedFibers{22}{22}(:,:,F{22,6}==5),1,C(5,:))
plot_curve(alignedFibers{22}{22}(:,:,F{22,6}==6),1,C(6,:))

figure(3)

trainAcc = mean(Mdl.predict(Features)==labels')
looAcc = 1-kfoldLoss(crossval(Mdl,'leaveout','on'))

for i = 1:500
Z(i)=1-kfoldLoss(crossval(Mdl));
end

histogram(Z)
xline(looAcc)
xline(trainAcc,'red')
xlim([0 1])
legend("10-fold MCCV Acc", "LOO CV Acc", "Train Acc",'Location','northwest')