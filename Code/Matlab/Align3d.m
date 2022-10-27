function [X2_out, dist] = Align3d(X1,X2_mat)


N = size(X1,2);
[l,m,n] = size(X2_mat);

    X1_tilde = X1 - repmat(mean(X1')',1,size(X1,2));
    [q1,~] = curve_to_q(X1_tilde);

parfor i1 = 1:n
    
    X2=X2_mat(:,:,i1);

    
%Translational and Rotational Alignment

    X2_tilde = X2 - repmat(mean(X2')',1,size(X2,2));


% Form the q function for representing curves

    [q2,~] = curve_to_q(X2_tilde);
    
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
    
 
%     A = q1*q2n';
%     [U,S,V] = svd(A);
%     
%     if det(A)> 0
%         Ot = U*V';
%     else
%         Ot = U*([V(:,1) V(:,2) -V(:,3)])';
%     end
%     q2n = Ot*q2n;
%     X2_out(:,:,i1) = Ot*X2n;
     
    X2_out(:,:,i1) = X2n;

% dist(i1) = acos(sum(sum(q1.*q2n))/N);
    dist(i1) = sum(sum((X2_out(:,:,i1)-X1).^2));

end
