function [alignedFibers, alignedPi] = median_OT3(Fibers,target)

Y= gpuArray(Fibers{target});

[l,m,n] = size(Y);

parfor i = 1:length(Fibers)
    
    i
    
    X = gpuArray(Fibers{i});
        
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

    Pi_temp=gather(FOT.Pi)';
    
    alignedFibers{i} = TX;
    alignedPi{i} = Pi_temp;
%     W(i) = Wasserstein(curve_to_mat(TX),curve_to_mat(gather(Y)),Pi_temp);
    
end  

end

