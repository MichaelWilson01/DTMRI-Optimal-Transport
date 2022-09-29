function dataMat, k = data_shaper(functionData)
    if length(size(functionData))==2
    dataMat = functionData;
    [k,~] = size(dataMat);
    elseif length(size(functionData))==3
    [curveDim,timeSamples,numFib] = size(functionData);
    dataMat=reshape(permute(functionData,[3 2 1]), numFib,curveDim*timeSamples)';
    [k,~] = size(dataMat);
    else
      "Data Error: Data should have shape: (timeSteps,numFunc) or (numDim, timeSteps, numFunc) if numDim>1"
    end
end