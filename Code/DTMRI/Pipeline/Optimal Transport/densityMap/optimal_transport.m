function T = optimal_transport(X,Y,mu,nu,U,muX)

[~,N] = size(Y);

g=.1;
lr=1e-6;
eta=2;%5;

T{1} =eye(N);

    figure(1)
    clf
      
    subplot(1,3,1)
    plot(Y(:,1),Y(:,2),'.')
    hold on
    plot(X(:,1),X(:,2),'.')
    
    X_temp{1}=X;
    X=X_temp;
    
for i = 1:200
    i
    [X{i+1},T{i+1}] = optimize_step(X{i},Y,mu,nu,T{1},lr,eta,g,U,muX);
    
    
%     figure(1)
%     
%     
%     Z=(T{i+1}*X')';
%     
%     subplot(1,3,2)
%     cla
%     plot(Y(:,1),Y(:,2),'.')
%     hold on
%     plot(Z(:,1),Z(:,2),'.')
%     
%     subplot(1,3,3)
%     cla
%     plot(X(:,1),X(:,2),'.')
%     hold on
%     plot(Z(:,1),Z(:,2),'.')
%     
%     figure(2)
%     cla
%     plot_curve(mat_to_curve((U'*Y'+muX)'),1,'black')
%     hold on
%     plot_curve(mat_to_curve((U'*T{i+1}*X'+muX)'),1,0)
%     
%     pause(.5)

end