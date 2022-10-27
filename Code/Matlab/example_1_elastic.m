clear all
load("test_data.mat")

X = X-mean(mean(X,3),2);
Y = Y-mean(mean(Y,3),2);

a=1;
deltaW=Inf;
W=[];

TX=X;


while deltaW>0.00001
%Initialize optimizer with data on GPU
FOT=FOT_optimizer_elastic(TX,Y);

%Set Parameters
FOT.max_iter=1;
FOT.lr=2e-7;
FOT.gamma_h=1;
FOT.eta=1;
FOT.k_x = 150;
FOT.k_y=150;

%Find Optimal Transport plan (with Sinkhorn)
tic
FOT.optimize();
toc

TX = mat_to_curve(gather(FOT.T * FOT.X)');

%Initialize optimizer with data on GPU
FOT2=FOT_optimizer(gpuArray(TX),gpuArray(Y));

%Set Parameters
FOT2.max_iter=10;
FOT2.lr=1e-7;
FOT2.gamma_h=1;
FOT2.eta=1;
FOT2.k_x = 150;
FOT2.k_y=150;

FOT2.optimize();

TX = mat_to_curve(gather(FOT2.T * FOT2.X)');

figure(1)
subplot(1,2,2)
cla
plot_curve(TX,1,'red')
plot_curve(Y,1,'black')

pause(.1)

W(a) = Wasserstein(curve_to_mat(TX),curve_to_mat(Y),gather(FOT2.Pi)')
a=a+1;

if a>2
deltaW = W(end-1)-W(end);
end

end
