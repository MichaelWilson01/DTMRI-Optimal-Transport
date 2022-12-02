clear all

% Load Fiber Data
load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT.mat','Fibers');

% Project data into PC's
[pcaCoords,U,muX] = get_pooled_pca_coords(Fibers,.99);

% 
[modeIdx, modeDen] = get_modes(pcaCoords{1});
Xm = pcaCoords{1}(modeIdx{1}(:,20)==1,:);
mu = modeDen{1}(modeIdx{1}(:,20)==1,20)/sum( modeDen{1}(modeIdx{1}(:,20)==1,20))
mu = mu/sum(mu);

[modeIdx, modeDen] = get_modes(pcaCoords{2});
Ym = pcaCoords{2}(modeIdx{1}(:,20)==1,:);
nu = modeDen{1}(modeIdx{1}(:,20)==1,20)/sum( modeDen{1}(modeIdx{1}(:,20)==1,20))
nu=nu/sum(nu);

T = optimal_transport(Xm,Ym,mu,nu,U,muX)

X=pcaCoords{1};
Y=pcaCoords{2};

    figure(1)
    clf
    subplot(1,3,1)
    plot(Y(:,1),Y(:,2),'.')
    hold on
    plot(X(:,1),X(:,2),'.')
    

for i = 1:200
    i
    
    Z=(T{i+1}*X')';
    Zm=(T{i+1}*Xm')';
    X=Z;
    Xm=Zm;

    figure(1)
    subplot(1,3,2)
    cla
    plot(Y(:,1),Y(:,2),'.')
    hold on
    plot(Z(:,1),Z(:,2),'.')
    plot(Ym(:,1),Ym(:,2),'black*','LineWidth',4)
    plot(Xm(:,1),Xm(:,2),'red*','LineWidth',4)
    
    subplot(1,3,3)
    cla
    plot(X(:,1),X(:,2),'.')
    hold on
    plot(Z(:,1),Z(:,2),'.')
    
    figure(2)
    if mod(i,10)==0
    clf
    plot_curve(mat_to_curve((U'*Y'+muX)'),1,'black')
    hold on
    plot_curve(mat_to_curve((U'*X0'+muX)'),1,0)
    end
    
    pause(2)

end









% for i = 1:200
%     i
%     
%     Z2=(T{i+1}*X2')';
%     Z=(T{i+1}*X')';
%     X2=Z2;
%     X=Z;
%     
%     subplot(1,3,2)
%     cla
%     plot(Y2(:,1),Y2(:,2),'.')
%     plot(Y(:,1),Y(:,2),'black*','LineWidth',4)
%     hold on
%     plot(Z2(:,1),Z2(:,2),'.')
%     plot(X(:,1),X(:,2),'red*','LineWidth',4)
%     
%     subplot(1,3,3)
%     cla
%     plot(X2(:,1),X2(:,2),'.')
%     hold on
%     plot(Z2(:,1),Z2(:,2),'.')
%     
% %     figure(2)
% %     clf
% %     plot_curve(mat_to_curve((U'*Y2'+muX)'),1,'black')
% %     hold on
% %     plot_curve(mat_to_curve((U'*Z2'+muX)'),1,0)
%     
%     pause(.5)
% 
% end