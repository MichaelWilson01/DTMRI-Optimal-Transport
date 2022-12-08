% time warping method
% 
% clear; close all;

% mex DynamicProgrammingQ.c

function [gam, mean_fn, fn] = Multiple_Alignment(X)

f=X;

t=1:length(f(:,1));

lambda = 0;


binsize = mean(diff(t));
[M, N] = size(f);
f0 =f;

% compute the q-function of the plot 
for i = 1:N
    q(:,i) = gradient(f(:,i), binsize)./sqrt(abs(gradient(f(:,i), binsize))+eps);
end

%%% set initial using the original f space
disp(sprintf('\n Initializing...\n'));
mnq = mean(q,2);
dqq = sqrt(sum((q - mnq*ones(1,N)).^2,1));
[ignore, min_ind] = min(dqq);
mq = q(:,min_ind); 
mf = f(:,min_ind);

parfor k = 1:N
    
    
    q_c = q(:,k,1)'; mq_c = mq';
    gam0 = DynamicProgrammingQ(q_c/norm(q_c),mq_c/norm(mq_c),lambda,0);
    gam(k,:) = (gam0-gam0(1))/(gam0(end)-gam0(1));  % slight change on scale
    
end
gamI = SqrtMeanInverse(gam);
gamI_dev = gradient(gamI, 1/(M-1));
%mq = interp1(t, mq, (t(end)-t(1)).*gamI + t(1))'.*sqrt(gamI_dev');
mf = interp1(t, mf, (t(end)-t(1)).*gamI + t(1))';
mq = gradient(mf, binsize)./sqrt(abs(gradient(mf, binsize))+eps);

% test=(0:1/(length(t)-1):1)';
% mq = gradient(test, binsize)./sqrt(abs(gradient(test, binsize))+eps);

%%% compute mean
disp(sprintf(' Computing Karcher mean of %d functions in SRVF space...\n',N));
ds = inf; 
MaxItr =15;
for r = 1:MaxItr
    disp(sprintf('updating step: r=%d', r)); 
    if r == MaxItr
        disp(sprintf('maximal number of iterations is reached. \n'));
    end   
    
    %%%% Matching Step %%%%
    clear gam gam_dev;
    % use DP to find the optimal warping for each function w.r.t. the mean

    parfor k = 1:N
        
        q_c = q(:,k,1)'; mq_c = mq(:,r)';
        gam0 = DynamicProgrammingQ(q_c/norm(q_c),mq_c/norm(mq_c),lambda,0);
        gam(k,:) = (gam0-gam0(1))/(gam0(end)-gam0(1));  % slight change on scale
        gam_dev(k,:) = gradient(gam(k,:), 1/(M-1));
%        q(:,k,r+1) = interp1(t, q(:,k,1), (t(end)-t(1)).*gam(k,:) + t(1))'.*sqrt(gam_dev(k,:)');
        f2(:,k) = interp1(t, f(:,k,1), (t(end)-t(1)).*gam(k,:) + t(1))';
        q2(:,k) = gradient(f2(:,k), binsize)./sqrt(abs(gradient(f2(:,k), binsize))+eps);
        
    end
    
    f(:,:,r+1)=f2;
    q(:,:,r+1)=q2;
 
       
    ds(r+1) = sum(trapz(t, (mq(:,r)*ones(1,N)-q(:,:,r+1)).^2)) + ...
                lambda*sum(trapz(t, (1-sqrt(gam_dev')).^2));
    
    %%%% Minimization Step %%%%
    % compute the mean of the matched function
    mq(:,r+1) = mean(q(:,:,r+1),2);
    
    qun(r) = norm(mq(:,r+1)-mq(:,r))/norm(mq(:,r));
    if qun(r) < 1e-2 && r >=10
        break;
    end
end

if lambda == 0
    disp(sprintf('additional run for adjustment')); 
    r = r+1;
   
    parfor k = 1:N
       

        q_c = q(:,k,1)'; mq_c = mq(:,r)';
        gam0 = DynamicProgrammingQ(q_c/norm(q_c),mq_c/norm(mq_c),lambda,0);
        gam(k,:) = (gam0-gam0(1))/(gam0(end)-gam0(1));  % slight change on scale
        gam_dev(k,:) = gradient(gam(k,:), 1/(M-1));      
        
    end   
    
    gamI = SqrtMeanInverse(gam);
    gamI_dev = gradient(gamI, 1/(M-1));
    mq(:,r+1) = interp1(t, mq(:,r), (t(end)-t(1)).*gamI + t(1))'.*sqrt(gamI_dev');
    for k = 1:N
        q(:,k,r+1) = interp1(t, q(:,k,r), (t(end)-t(1)).*gamI + t(1))'.*sqrt(gamI_dev');
        f(:,k,r+1) = interp1(t, f(:,k,r), (t(end)-t(1)).*gamI + t(1))';  
    %    q(:,k,r+1) = gradient(f(:,k,r+1), binsize)./sqrt(abs(gradient(f(:,k,r+1), binsize))+eps);
        gam(k,:) = interp1(t, gam(k,:), (t(end)-t(1)).*gamI + t(1));
    end   
%     for k = 1:N
%         q_c = q(:,k,1)'; mq_c = mq(:,r+1)';
%         gam0 = DynamicProgrammingQ(q_c,mq_c,lambda,0);
%         gam(k,:) = (gam0-gam0(1))/(gam0(end)-gam0(1));  % slight change on scale 
%     end       
end

% aligned data
fn = f(:,:,r+1);

mean_fn = mean(fn, 2);

gam=gam';

end