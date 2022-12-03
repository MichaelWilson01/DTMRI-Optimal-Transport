function [modeIdx, modeDen] = get_modes(pcaCoords)

% parfor subject = 1:length(pcaCoords)
    
    X=pcaCoords;%{subject};

    [N,~] = size(X);

    modeIDXs=[];

    for K = 1:500

    [a,b] = knnsearch(X,X,'K',K);
    D=1./b(:,end);

    for i = 1:N

        modeIDXs(i,K) = D(i)==max(D(a(i,:)));
        D_star(i,K) = D(i);

    end

    end

    A = sum(modeIDXs);

    for K = 2:N

        idTemp = find(A==K);

        if ~isempty(idTemp)
            modeIdx(:,K)=modeIDXs(:,idTemp(1));
            modeDen(:,K)=D_star(:,idTemp(1));
        end

    end

% end
