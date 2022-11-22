function X1 = FormSyntheticSpirals(T,n,disp)


del = 1/T;


if disp
    figure(1); clf;
end
for r=1:n
   
    % Number of loops
    tau = ceil(1+rand*3);
    rad= 0.75 + 2*(rand);
    
    
    %Size of spiral
    t1 = tau*20; %30 + ceil(rand*60);
    th = 2*pi*[1:t1]'/t1;
    Xp(:,1) = rad*cos(tau*th);
    Xp(:,2) = rad*sin(tau*th);

    % Form the large curve
    X(1:T,1:2) = 0;
    X(1:T,3) = 2*pi*[1:T]/T;

    % Put the spiral in the large curve
    shf = 5+ceil(0.5*rand*T);
    X(shf+1:shf+t1,1:2) = Xp(:,1:2);
    clear Xp;
    
    % Smoothing
    for i=1:30
        Y(1,:)  = X(1,:);
        Y(2:T-1,:) = (X(3:T,:) + 2*X(2:T-1,:) + X(1:T-2,:))/4;
        Y(T,:) = X(T,:);
        X = Y;
    end
    
    if disp
        subplot(3,4,r);
        z = plot3(X(:,1), X(:,2), X(:,3),'r');
        set(z,'LineWidth',3);
        axis equal off;
    end
    
    X1(:,:,r) = X';
end