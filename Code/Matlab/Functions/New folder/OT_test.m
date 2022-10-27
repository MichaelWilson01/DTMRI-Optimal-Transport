function X = median_OT(Fibers,N)

Y0= gpuArray(datasample(Fibers{9},N,3,'Replace',false));
% Y1= gpuArray(datasample(Fibers{32},N,3));
Y1=Y0;

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
        FOT.k_x = 150;
        FOT.k_y=150;

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
        FOT.k_x = 150;
        FOT.k_y=150;

        %Find Optimal Transport plan (with Sinkhorn)
        FOT.optimize()
        
        TX = mat_to_curve(gather(FOT.T * FOT.X)');
        
%         subplot(1,2,2)
%         plot_curve(TX,1,[rand rand rand])
        
    end
    
    alignedFibers{i} = TX;
    
    toc
    
end
        