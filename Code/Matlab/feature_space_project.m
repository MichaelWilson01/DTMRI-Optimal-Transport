function features = feature_space_project(alignedFibers,F,J)

    for i = 1:length(alignedFibers)
        
        idx_proj{i} = mode(idx(knnsearch(curve_to_mat(F)',curve_to_mat(alignedFibers{i})','K',J))');
    
        for j = 1:K

            features(i,j) = sum(idx_proj{i}==j);

        end
    
    end

end
