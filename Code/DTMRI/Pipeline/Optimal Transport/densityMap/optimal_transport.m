function [T, X] = optimal_transport(X,Y,mu,nu,U,muX)

[M,~] = size(X);
[~,N] = size(Y);

g=.1;
lr=1e-4;
eta=2;%5;

T{1} =eye(N);

    figure(1)
    clf
      

    X_temp{1}=X;
    X=X_temp;
    
    subplot(1,3,1)
    plot(Y(:,1),Y(:,2),'.')
    hold on
    plot(X{1}(:,1),X{1}(:,2),'.')
    
    
for i = 1:30%200
    i
    [X{i+1},T{i+1}] = optimize_step(X{i},Y,mu{1},nu,T{1},lr,eta,g,U,muX);
    F = @(x)T{i+1}*x;
    for j = 1:M
    sqrtJ(j) = sqrt(norm(jacobianest(F,X{i}(j,:)')));
    end
    mu{i+1} = mu{i}.*sqrtJ';
    
    figure(1)
%     
%     
%     Z=(T{i+1}*X{i}')';
    
    subplot(1,3,2)
    cla
    plot(Y(:,1),Y(:,2),'.')
    hold on
    plot(X{i}(:,1),X{i}(:,2),'.')
    
    subplot(1,3,3)
    cla
    plot(X{1}(:,1),X{1}(:,2),'.')
    hold on
    plot(X{i}(:,1),X{i}(:,2),'.')
    
    figure(2)
    cla
    plot_curve(mat_to_curve((U'*Y'+muX)'),1,'black')
    hold on
    plot_curve(mat_to_curve((U'*X{i}'+muX)'),1,0)
%     
    pause(.5)

end

pause(.1)