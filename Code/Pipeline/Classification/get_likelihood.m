function [L0,L1] = get_likelihood(testData,group0,group1,K)

    [~,D0] = knnsearch(group0,testData,'K',K);
    [~,D1] = knnsearch(group1,testData,'K',K);
    
    L0=1./D0(:,end);
    L1=1./D1(:,end);


% L0 = mvksdensity(group0,testData,'bandwidth',K);
% L1 = mvksdensity(group1,testData,'bandwidth',K);
    
end
    
    
    
    