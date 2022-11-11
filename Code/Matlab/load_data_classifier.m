function [alignedFibers,W,labels,med] = load_data_classifier()

load("Data/Cingulum_Parahippocampal_L_9_30.mat")

alignedFibers{1,:}=alignedFibers1;
alignedFibers{2,:}=alignedFibers2;
med=[med1,med2];
W=[W1;W2];
