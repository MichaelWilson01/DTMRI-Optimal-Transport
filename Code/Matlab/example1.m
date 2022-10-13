clear all
load("test_data2.mat")

%Initialize optimizer with data
FOT=FOT_optimizer(gpuArray(X),gpuArray(Y))

%Set Parameters
FOT.max_iter=1;
FOT.lr=1e-9;
FOT.gamma_h=5;
FOT.eta=1;
FOT.k_x = 150;
FOT.k_y=150;

%Find Optimal Transport plan (with Sinkhorn)
tic
FOT.optimize()
toc

figure(1)
subplot(1,2,1)
plot_curve(X,1,'red')
plot_curve(Y,1,'black')


for i = 1:50
FOT.optimize()
TX = mat_to_curve(gather(FOT.T * FOT.X)');

figure(1)
subplot(1,2,2)
cla
plot_curve(TX,1,'red')
plot_curve(Y,1,'black')

pause(.1)

end