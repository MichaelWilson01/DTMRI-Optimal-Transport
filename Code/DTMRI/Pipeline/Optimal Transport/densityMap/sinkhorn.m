function Pi = sinkhorn(C,g)

[N,n] = size(C);

Pi = exp(-C/g);

for i = 1:100%need to update stop condition
  Pi = Pi./(Pi*(ones(n,1)));
  Pi = Pi'./(Pi'*(ones(N,1)));
  Pi=Pi';
end
