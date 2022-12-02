function [modeIdx, modeDen] = get_modes(pcaCoords)

% parfor subject = 1:length(pcaCoords)
    
    subject=1;
    
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

    for K = 2:20

        idTemp = find(A==K);

        if ~isempty(idTemp)
            modeIdx{subject}(:,K)=modeIDXs(:,idTemp(1));
            modeDen{subject}(:,K)=D_star(:,idTemp(1));
        end

    end

% end
