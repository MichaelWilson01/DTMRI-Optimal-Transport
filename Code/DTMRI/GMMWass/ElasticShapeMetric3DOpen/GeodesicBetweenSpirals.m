clear; 


    T = 150;


    XX = FormSyntheticSpirals(T,2,0);
    X1 = XX(:,:,1)';
    X2 = XX(:,:,2)';

    O = randn(3,3);
    O = orth(O);
    X2 = X2*O;


    figure(11); clf; axes('FontSize',20);
    z = plot3(X1(:,1), X1(:,2), X1(:,3),'r');
    set(z,'LineWidth',3);
    axis equal off;
    
    figure(12); clf; axes('FontSize',20);
    z = plot3(X2(:,1), X2(:,2), X2(:,3),'b');
    set(z,'LineWidth',3);
    axis equal off;
    

    dist = GeodesicBetweenTwoCurves(X1',X2');