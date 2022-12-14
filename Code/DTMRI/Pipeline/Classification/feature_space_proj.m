function features = feature_space_proj(X,alignedFibers,F,J)

K = max(F);

% for i = 1:K
%     
%     muX(:,:,i) = mean(X(:,:,F==i),3);
%     
% end

    for i = 1:length(alignedFibers)
        
        idx_proj{i} = mode(F(knnsearch(curve_to_mat(X)',curve_to_mat(alignedFibers{i})','K',J))');
%         idx_proj{i} = knnsearch(curve_to_mat(muX)',curve_to_mat(alignedFibers{i})');
%         idx_proj = mode(F(knnsearch(curve_to_mat(X)',curve_to_mat(alignedFibers{i})','K',J))');
    
        for j = 1:K

            features(i,j) = sum(idx_proj{i}==j);
%             features(i,j) = sum(idx_proj==j);

        end
    
    end

end
