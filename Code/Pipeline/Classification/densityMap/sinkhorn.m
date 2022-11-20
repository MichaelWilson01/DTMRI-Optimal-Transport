function Pi = sinkhorn(C,g,mu,nu)

[N,n] = size(C);

Pi = exp(-C/g);

for i = 1:100%need to update stop condition
  Pi = Pi./(Pi*(nu));
  Pi = Pi'./(Pi'*(mu));
  Pi=Pi';
end
