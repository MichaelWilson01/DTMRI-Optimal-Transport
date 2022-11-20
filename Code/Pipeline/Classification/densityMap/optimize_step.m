function TX = optimize_step(X,Y,mu,nu,T,lr,eta,g);

C = get_cost_matrix(X,Y);

Pi = sinkhorn(C,g,mu,nu);

T = get_map_step(X,Y,T,Pi,lr,eta)

TX = (T*X')';

