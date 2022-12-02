load('C:\Users\micha\Documents\GitHub\Optimal-Transport\Code\Other\Data\Cingulum_Parahippocampal_L_OT.mat','Fibers','labels')

minPct=0.95;

pcaCoords = get_pooled_pca_coords(Fibers,minPct);

pcaCoords{1}

X=pcaCoords{1}(:,1:2);

a=1;

% for k = 50:50:500;
for b = 0.1:0.1:10
    
x=[];
y=[];
P=zeros(81);

for i = -40:1:40
    for j = -40:1:40
        
        x(end+1)=i;
        y(end+1)=j;
        
%         [~,d] = knnsearch(X,[i,j],'K',k);
%         P(i+41,j+41) = 1/d(end);
        
        d = ksdensity(X,[i,j],'BandWidth',b);
        P(i+41,j+41) = d;
        
    end
end

% imagesc(P)
mesh(-40:1:40,-40:1:40,P)
pause(.1)
        
F(:,:,a)=P;
numMax(a) = sum(sum(imregionalmax(P)));
        a=a+1;
        
end
        
        
        
        
        
        