function FR = FR(X,labels)

mu0=mean(X(labels==0));
var0=var(X(labels==0));

mu1=mean(X(labels==1));
var1=var(X(labels==1));

P = normpdf(X,mu0,sqrt(var0));
Q = normpdf(X,mu1,sqrt(var1));

FR=acos(mean(P/norm(P).*Q/norm(Q)));

