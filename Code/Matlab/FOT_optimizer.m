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
               
               obj.X = dataShaper(obj,X);
               obj.Y = dataShaper(obj,Y);
               
               obj.U = getBasis(obj,X);
               obj.V = getBasis(obj,Y);
               
               
           end
       end
      function dataMat = dataShaper(obj,functionData)
          if length(size(functionData))==2
          dataMat = functionData;
          elseif length(size(functionData))==3
          [curveDim,timeSamples,numFib] = size(functionData);
          dataMat=reshape(permute(functionData,[3 2 1]), numFib,curveDim*timeSamples)';
          else
              
          end
      end
      function U = getBasis(obj,functionData)
          mu_f=mean(functionData,2);
          f_star = functionData - mu_f;
          C1=cov(f_star');
          [U, ~,~] = svd(C1);
      end
          

   end
   
   
end