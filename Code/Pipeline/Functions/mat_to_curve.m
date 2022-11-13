function Y_hat = mat_to_curve(Y_mat_hat)

[M,N] = size(Y_mat_hat);

% Y_hat = permute(reshape(Y_mat_hat',N,M,3),[3 2 1]);

if M>1

    Y_hat = permute(reshape(Y_mat_hat,M,N/3,3),[3 2 1]);

else
    
    Y_hat = reshape(Y_mat_hat,50,3)';

end

