function [subjectNum, tractName] = get_file_identifiers(folder)

A = cellstr(ls(folder));
A = split(A(3:end),'.');

subjectNum = unique(string(A(:,1)));
tractName = unique(string(A(:,2)));