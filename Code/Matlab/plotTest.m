figure(1)
clf

i=1

subjInd = 1+(i-1)*N:i*N;

for j = 1:K

    subplot(2,K,j)
    plot_curve(X0(:,:,idx(subjInd)==j),1,C(j,:)')

end

for i = 2:length(labels)

    subjInd = 1+(i-1)*N:i*N;

    for j = 1:K

        subplot(2,K,j+K)
        cla
        plot_curve(X(:,:,idx(subjInd)==j),1,C(j,:)')

    end

end