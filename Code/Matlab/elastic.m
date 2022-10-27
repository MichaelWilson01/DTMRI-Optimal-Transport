function D = elastic(target,source)

target=mat_to_curve(target');
source=mat_to_curve(source');

[L,M,N] = size(source);

D=zeros(N,1);

    parfor i = 1:N

        D(i) = get_streamline_dist(target,source(:,:,i));

    end

end