function labels = get_labels(subjectNum,labelFile);

 labelTable = readtable(labelFile);

for i = 1:length(subjectNum)
    
    labels(i)=labelTable.da_ptsd_current(find(labelTable.sid==str2num(subjectNum(i))));
    
end
    
   