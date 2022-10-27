X = gpuArray(Fibers{1});
Y = gpuArray(Fibers{9});

[l,m,n] = size(Y);
        
FOT=FOT_optimizer(X,Y);

% Set Parameters
FOT.max_iter=1;
FOT.lr=2e-9;
FOT.gamma_h=1;
FOT.eta=10;
FOT.k_x = l*m;
FOT.k_y=l*m;


 
% Find Optimal Transport plan (with Sinkhorn)
tic
FOT.optimize()
toc

[~,~,nx] = size(X)

idx=datasample(1:nx,500,'Replace',false);
idy=datasample(1:n,500,'Replace',false);

 subplot(1,2,1)
 cla
 plot_curve(Y(:,:,idy),1,'black')
 plot_curve(X(:,:,idx),1,'red')

for i = 1:20
    
 TX = mat_to_curve(gather(FOT.T * FOT.X)');
 
 subplot(1,2,2)
 cla
 plot_curve(Y(:,:,idy),1,'black')
 plot_curve(TX(:,:,idx),1,'red')
 
 pause(.5)
 
 tic
 FOT.optimize_step()
 toc
 
end

