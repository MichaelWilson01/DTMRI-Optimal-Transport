function mu = get_shape_means(X,idx)

    for i = 1:max(idx)

        disp(" ")
        fprintf(strcat("Calculating Cluster mean ",string(i)," of ",string(max(idx)), "..."))

        group1 = X(:,:,idx==i);

    for j = 1:length(group1(1,1,:))
        Q(:,:,j) = curve_to_q(group1(:,:,j));
    end

        [~, mu(:,:,i)] = multiple_curve_shape_mean(Q);

    end

    disp(" ")

end