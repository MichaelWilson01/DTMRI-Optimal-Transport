function Pi = sinkhorn(C,g)

[N,n] = size(C);

Pi = exp(-C/g);

for i = 1:100%need to update stop condition
  Pi = Pi./(Pi*(ones(1,n))');
  Pi = Pi'./(Pi'*(ones(1,N))');
  Pi=Pi';
end
