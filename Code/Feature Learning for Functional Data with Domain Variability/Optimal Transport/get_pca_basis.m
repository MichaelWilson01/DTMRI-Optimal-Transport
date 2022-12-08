function [U, S, mu_f] = get_pca_basis(X)

      mu_f=mean(X,2);
      f_star = X - mu_f;
      C1=cov(f_star');
      [U, S,~] = svd(C1);
          
end