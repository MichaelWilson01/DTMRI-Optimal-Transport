function [TX, T] = optimize_step(X,Y,mu,nu,T,lr,eta,g,U,muX);

C = get_cost_matrix(X,Y);
% C = get_cost_matrix((T*X')',Y);
% C = get_cost_matrix4(X,Y,U,muX);

% Pi = sinkhorn(C,g);
Pi = sinkhorn2(C,g,mu,nu);

T = get_map_step(X,Y,T,Pi,lr,eta);
% T = get_map_step2(X,Y,T,Pi,lr,eta,U,muX);

TX = (T*X')';

