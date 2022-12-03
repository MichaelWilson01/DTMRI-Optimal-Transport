clear all

% Load Fiber Data
load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT.mat','Fibers');

% Project data into PC's
[pcaCoords,U,muX] = get_pooled_pca_coords(Fibers,.99);

Y=pcaCoords{2};
X=pcaCoords{3};
X0=X;

% mode Selection
K=50;

[modesX, densX] = get_modes(X);
[Xm, mu] = get_modes_and_measure(X,modesX,densX,K);

[modesY, densY] = get_modes(Y);
[Ym, nu] = get_modes_and_measure(Y,modesY,densY,K);

T = optimal_transport(Xm,Ym,mu,nu,U,muX)


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
    plot(X0(:,1),X0(:,2),'.')
    hold on
    plot(Z(:,1),Z(:,2),'.')
    
    figure(2)
    if mod(i,10)==0
    clf
    plot_curve(mat_to_curve((U'*Y'+muX)'),1,'black')
    hold on
    plot_curve(mat_to_curve((U'*X'+muX)'),1,0)
    end
    
    pause(.5)

end

figure(2)
clf
plot_curve(mat_to_curve((U'*Y'+muX)'),1,0)

figure(3)
clf
plot_curve(mat_to_curve((U'*X'+muX)'),1,0)

figure(4)
clf
plot_curve(mat_to_curve((U'*X0'+muX)'),1,0)






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