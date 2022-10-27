function [correspondence, C] = get_correspondence(X,Y)

C=zeros(length(X(1,1,:)),length(Y(1,1,:)));

for i = 1:length(X(1,1,:))
    for j = 1:length(Y(1,1,:))
        C(i,j) = get_streamline_dist(X(:,:,i),Y(:,:,j));
%         C(i,j) = mean(mean((X(:,:,i)-Y(:,:,j)).^2));
    end
end

correspondence = Hungarian(C);