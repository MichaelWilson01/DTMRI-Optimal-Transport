function features = feature_space_proj(X,alignedFibers,F,J)

K = max(F);

    for i = 1:length(alignedFibers)
        
        idx_proj{i} = mode(F(knnsearch(curve_to_mat(X)',curve_to_mat(alignedFibers{i})','K',J))');
    
        for j = 1:K

            features(i,j) = sum(idx_proj{i}==j);

        end
    
    end

end
