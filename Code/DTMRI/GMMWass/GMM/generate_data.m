function [X, idx] = generate_data(m,sigma,b,N)

X=[];
idx=[];
for i = 1:length(N)
    
    X = [X, exp_map(m(:,i),b(:,:,i)*sigma(:,:,i)*randn(2,N(i)))];
    idx(end+1:end+N(i))=i;
    
end