clear 
%% Parameters

lr=.000005;
eta=0.02;

K1=101;
K2=101;

g=100;

T=0:.01:1;

numFunc=100;

for i = 1:numFunc
    
X(:,i)=cos((4*pi*(T+rand/20)));
Y(:,i)=sin((4*pi*(T+rand/20)))+T;

end



[gamX, muX, ampX] = Multiple_Alignment(X);
[gamY, muY, ampY] = Multiple_Alignment(Y);

gam_star = DynamicProgrammingQ_Adam(SRVF(muX)',SRVF(muY)',0,0)

for i = 1:numFunc

ampX(:,i) = interp1(T,ampX(:,i),gam_star);
gamX(:,i) = interp1(T,gamX(:,i),gam_star);

end



%Basis Functions (CONS)
% U = getBasis(f1);
% V = getBasis(f2);
U=eye(K1);
V=eye(K2);

%Initialize Lambda to identity
Lambda = eye(K2,K1);

[M1,N1] = size(ampX);
[M2,N2] = size(ampY);



subplot(1,3,1)
plot(ampX)
ylim1=2*(ylim-mean(ylim))+mean(ylim);
ylim(ylim1);

subplot(1,3,3)
plot(ampY)
ylim(ylim1);








for iter = 1:100
   


subplot(1,3,2)
cla
plot(V(:,1:K2)*Lambda*U(:,1:K1)'*ampX)
ylim(ylim1);

pause(.1)

E(iter) = EnergyDistance(V(:,1:K2)*Lambda*U(:,1:K1)'*ampX,ampY)
W(iter) = Wasserstein(ampX,ampY,Pi)

end