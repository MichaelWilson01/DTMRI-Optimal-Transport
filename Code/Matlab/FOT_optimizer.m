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
           if nargin == 2
               
               obj.X = X;
               obj.Y = Y;
               
               obj.U = getBasis3(obj,X);
               obj.V = getBasis3(obj,Y);
               
               
           end
       end
      function U = getBasis3(obj, functionData)
          mu_f=mean(functionData,2);
          f_star = functionData - mu_f;
          C1=cov(f_star');
          [U, ~,~] = svd(C1);
      end
          

   end
   
   
end