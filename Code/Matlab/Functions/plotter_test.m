clear all

load("kmkm_hungarian_Fornix_L_result.mat")
% load("standard_kmeans_hungarian_Cingulum_Parahippocampal_L_result.mat")

for i = 15:(length(cluster_modes)-1)
    
    x = cluster_modes{i};
    
    for j = i+11:length(cluster_modes)
        
        y = cluster_modes{j};
        
        [X_ind, Y_ind] = find(correspondence{i,j}==1);
        
        for i = 1:length(X_ind)
            
            if mean(mean(y(:,:,Y_ind(i))-x(:,:,X_ind(i))).^2)>mean(mean(fliplr(y(:,:,Y_ind(i)))-x(:,:,X_ind(i))).^2)
                y(:,:,Y_ind(i))=fliplr(y(:,:,Y_ind(i)));
            end
            
        end
        
        for t=0:.01:1

            A = t*y(:,:,Y_ind) + (1-t)*x(:,:,X_ind);
            
            figure(1)
            clf
            plot_curve(A,1,[t,0,(1-t)]);
            xlim([30 70])
            ylim([50 100]-30)
            zlim([0 50])
            
            pause(.01)
            
        end
        
        pause(1)
        
    end
    
end