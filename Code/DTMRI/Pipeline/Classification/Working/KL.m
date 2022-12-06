function KL = KL(X,labels)

mu0=mean(X(labels==0));
var0=var(X(labels==0));

mu1=mean(X(labels==1));
var1=var(X(labels==1));

P = normpdf(X(labels==0),mu0,sqrt(var0));
Q = normpdf(X(labels==1),mu1,sqrt(var1));

P=P/sum(P);
Q=Q/sum(Q);

KL = sum(P.*log(P./Q));