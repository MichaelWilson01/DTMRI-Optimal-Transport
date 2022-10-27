function Xn = Group_Action_by_Gamma_Coord(X,gam)

T = size(X,2);
idx = round(gam*T);
idx = min(max(1,idx),T);

Xn = X(:,idx);