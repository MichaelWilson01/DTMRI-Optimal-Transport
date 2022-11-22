function dist = GeodesicBetweenTwoCurves(X1,X2)

%%%% What displays you want to see
Disp_geodesic_between_the_curves = 0;
Disp_registration_between_curves = 0;
Disp_Dynamic_Programming_Results = 0;


        N = size(X1,2);
    
%Translational and Rotational Alignment
    X1 = X1 - repmat(mean(X1')',1,size(X1,2));
    X2 = X2 - repmat(mean(X2')',1,size(X2,2));


% Form the q function for representing curves
    [q1,~] = curve_to_q(X1);
    [q2,~] = curve_to_q(X2);
    
%     figure(1); clf;
%     z = plot3(X1(1,:), X1(2,:), X1(3,:),'r',2+X2(1,:), X2(2,:), X2(3,:),'b-');
%     set(z,'LineWidth',3);
%     axis equal;
%     view([0 90]);
%     axis off;
    
    % Find the optimal coorespondence
    [gam] = DynamicProgrammingQ_Adam(q2,q1,0,0);
%     [gam] = DynamicProgrammingQ_Adam(q2,q1,0,Disp_Dynamic_Programming_Results);
    %gamI = invertGamma(gam);
    %%% Applying optimal re-parameterization to the second curve
    X2n = Group_Action_by_Gamma_Coord(X2,gam);
    q2n = curve_to_q(X2n);
    

    A = q1*q2n';
    [U,S,V] = svd(A);
    
    if det(A)> 0
        Ot = U*V';
    else
        Ot = U*([V(:,1) V(:,2) -V(:,3)])';
    end
    q2n = Ot*q2n;
    X2n = Ot*X2n;

%     InnerProduct(q1-q2,q1-q2)
%     InnerProduct(q1-q2n,q1-q2n)
%     InnerProduct(q1-q2nn,q1-q2nn)
 
    
% % Displaying the correspondence
if(Disp_registration_between_curves)
    figure(3); clf;hold on;
    z = plot3(X1(1,:), X1(2,:), X1(3,:),'r');
    set(z,'LineWidth',4);
    %axis equal;
    
    xsh = 0;
    z = plot3(2+X2n(1,:), xsh+X2n(2,:), X2n(3,:),'b-');
    set(z,'LineWidth',4);
    N = size(X1,2);
    for j=1:N/4
        i = j*4;
        z = plot3([X1(1,i) 2+X2n(1,i)],[X1(2,i) xsh+X2n(2,i)], [X1(3,i) X2n(3,i)], 'k');
        set(z,'LineWidth',1);
    end
    axis on equal off;
    set(gca,'fontsize', 18);


end

%%%% Forming geodesic between the registered curves
N = size(X1,2);
stp = 7;
dist = acos(sum(sum(q1.*q2n))/N);
% sprintf('The distance between the two curves is %0.3f',dist)
    if(Disp_geodesic_between_the_curves)
        for t=1:stp
            s = dist*(t-1)/(stp-1);
            PsiQ(:,:,t) = (sin(dist - s)*q1 + sin(s)*q2n)/sin(dist);
            PsiX(:,:,t) = q_to_curve(PsiQ(:,:,t));
        end
        figure(4); clf; 
        axes('FontSize',20);
        axis equal; hold on;
        for t=1:stp
            z = plot3(0.1*t/stp + PsiX(1,:,t), 0.2*t + PsiX(2,:,t), PsiX(3,:,t)); 
            set(z,'LineWidth',2); %,'color',[(t-1)/10 (t-1)/20 0]);
        end
        %title('Geodesic path from the first curve to the second');
    end
%     axis equal;
%     set(gca,'fontsize', 18);