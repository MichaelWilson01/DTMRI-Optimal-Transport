function [trainFibers, testFibers, trainW, testW, trainLabels, testLabel] = split_on_index(alignedFibers, W, labels,leave_out_indices)

%split data
for i = 1:length(alignedFibers)

    trainFibers{i}=alignedFibers{i};
    trainFibers{i}(leave_out_indices)=[];
    testFibers{i}=alignedFibers{i}(leave_out_indices);
    
end

%split W
trainW = W;
trainW(:,leave_out_indices)=[];
testW=W(:,leave_out_indices);

%split labels
trainLabels = labels;
trainLabels(leave_out_indices)=[];
testLabel = labels(leave_out_indices);



