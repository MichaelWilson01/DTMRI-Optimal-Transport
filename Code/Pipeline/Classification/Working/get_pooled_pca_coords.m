function pcaCoords = get_pooled_pca_coords(Fibers,minPct);

fullPcaData=[];

for i = 1:length(Fibers)
   
    A=curve_to_mat(Fibers{i});
    
    fullPcaData = [fullPcaData,A];
    
end

[U_full, S_full, muX]=get_pca_basis(fullPcaData);

% clear fullPcaData;

pctInd = min(find(cumsum(diag(S_full))./sum(diag(S_full))>minPct));
pctObs=sum(diag(S_full(1:pctInd,1:pctInd)))/sum(diag(S_full));


for i = 1:length(Fibers)
   
    X=curve_to_mat(Fibers{i});
    
    pcaCoords{i}=(U_full(:,1:pctInd)'*(X-muX))';
    
end