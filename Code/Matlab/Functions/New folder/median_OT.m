function [X, W] = median_OT(Fibers,labels,N,target)

Y0= gpuArray(datasample(Fibers{target},N,3,'Replace',false));
% Y1= gpuArray(datasample(Fibers{32},N,3));
Y1=Y0;

[l,m,n] = size(Y0);

tic

parfor i = 1:length(labels)
    
    tic
    
    X = gpuArray(datasample(Fibers{i},N,3,'Replace',false));
    
    if labels(i) ==0
        
        FOT=FOT_optimizer(X,Y0);

        %Set Parameters
        FOT.max_iter=100;
        FOT.lr=4e-9;
        FOT.gamma_h=1;
        FOT.eta=10;
        FOT.k_x = l*m;
        FOT.k_y=l*m;

        %Find Optimal Transport plan (with Sinkhorn)
        FOT.optimize()
        
        TX = mat_to_curve(gather(FOT.T * FOT.X)');
        
%         subplot(1,2,1)
%         plot_curve(TX,1,[rand rand rand])
        
    else
        
        FOT=FOT_optimizer(X,Y1);

        %Set Parameters
        FOT.max_iter=100;
        FOT.lr=4e-9;
        FOT.gamma_h=1;
        FOT.eta=10;
        FOT.k_x = l*m;
        FOT.k_y=l*m;

        %Find Optimal Transport plan (with Sinkhorn)
        FOT.optimize()
        
        TX = mat_to_curve(gather(FOT.T * FOT.X)');
        
%         subplot(1,2,2)
%         plot_curve(TX,1,[rand rand rand])

        
    end
    
    alignedFibers{i} = TX;
    W(i) = Wasserstein(curve_to_mat(TX),curve_to_mat(gather(Y0)),gather(FOT.Pi)');
    
    toc
    
end
        

X=[];
for i = 1:length(labels)
X = cat(3,X,alignedFibers{i});
end