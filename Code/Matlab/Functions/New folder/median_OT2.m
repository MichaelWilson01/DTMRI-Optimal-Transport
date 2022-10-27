function [X_out, W] = median_OT2(Fibers,labels,N,target)

 targetInd = 1+(target-1)*N:target*N;

Y= gpuArray(Fibers(:,:,targetInd));

[l,m,n] = size(Y);

for i = 1:length(labels)

    subjInd = 1+(i-1)*N:i*N;
    
    X = gpuArray(Fibers(:,:,subjInd));
        
    FOT=FOT_optimizer(X,Y);

    %Set Parameters
    FOT.max_iter=20;
    FOT.lr=2e-9;
    FOT.gamma_h=1;
    FOT.eta=10;
    FOT.k_x = l*m;
    FOT.k_y=l*m;

    %Find Optimal Transport plan (with Sinkhorn)
    FOT.optimize()

    TX = mat_to_curve(gather(FOT.T * FOT.X)');

    alignedFibers{i} = TX;
    W(i) = Wasserstein(curve_to_mat(TX),curve_to_mat(gather(Y)),gather(FOT.Pi)');

    
end  

X_out=[];
for i = 1:length(labels)
X_out = cat(3,X_out,alignedFibers{i});
end