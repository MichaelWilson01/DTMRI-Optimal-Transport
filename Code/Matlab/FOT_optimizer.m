classdef FOT_optimizer
   
   properties
      X
      Y
      
      U
      V
      
      k_x
      k_y
      
      Lambda
      T
      C
      Pi
      
      max_iter
      lr
      eta
      gamma_h
      
   end
   
   
   methods
       function obj = FOT_optimizer(X,Y)   
           %For finding transport plan from X to Y
           %
           %X,Y should have shape: (timeSteps,numFunc)
           %or (numDim, timeSteps, numFunc) if numDim>1
            
           if nargin == 2
               
               [obj.X, obj.k_x] = data_shaper(obj,X);
               [obj.Y, obj.k_y] = data_shaper(obj,Y);
               
               obj.U = get_pca_basis(obj,X);
               obj.V = get_pca_basis(obj,Y);
               
               
               
               
               
           end
       end
       
      function dataMat, k = data_shaper(obj,functionData)
          if length(size(functionData))==2
          dataMat = functionData;
          [k,~] = size(dataMat);
          elseif length(size(functionData))==3
          [curveDim,timeSamples,numFib] = size(functionData);
          dataMat=reshape(permute(functionData,[3 2 1]), numFib,curveDim*timeSamples)';
          [k,~] = size(dataMat);
%           else
%               "Data Error: Data should have shape: (timeSteps,numFunc) or (numDim, timeSteps, numFunc) if numDim>1"
          end
      end
      
      function U = get_pca_basis(obj,functionData)
          mu_f=mean(functionData,2);
          f_star = functionData - mu_f;
          C1=cov(f_star');
          [U, ~,~] = svd(C1);
      end
          

   end
   
   
end