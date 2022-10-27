function x = InnerProduct(q1,q2)

N = size(q1,2);

x = sum(sum(q1.*q2))*(1/N);
