classdef FOT_optimizer < dynamicprops
   
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
               
               obj.U = get_pca_basis(obj,obj.X);
               obj.V = get_pca_basis(obj,obj.Y);              
               
           end
       end
       
      function [dataMat, k] = data_shaper(obj,functionData)
          if length(size(functionData))==2
          dataMat = functionData;
          [k,~] = size(dataMat);
          elseif length(size(functionData))==3
          [curveDim,timeSamples,numFib] = size(functionData);
          dataMat=reshape(permute(functionData,[3 2 1]), numFib,curveDim*timeSamples)';
          [k,~] = size(dataMat);
          else
              "Data Error: Data should have shape: (timeSteps,numFunc) or (numDim, timeSteps, numFunc) if numDim>1"
          end
      end
      
      function U = get_pca_basis(obj,functionData)
          mu_f=mean(functionData,2);
          f_star = functionData - mu_f;
          C1=cov(f_star');
          [U, ~,~] = svd(C1);
      end
      
      function C = update_cost_matrix(obj,V,Lambda,U,k_x,k_y,X,Y)
          TX = V(:,1:k_y)*Lambda*U(:,1:k_x)'*X;
          [~, xN] = size(TX);
          [~, yN] = size(Y);
          C=zeros(yN,xN);
          for k =1:xN
              C(:,k) = mean((Y - TX(:,k)).^2);
          end
%           obj.C = C;
      end
      
      function Pi = sinkhorn(obj,C,g)
          [N,n] = size(C);
          Pi = exp(-C/g);
          for i = 1:100%need to update stop condition
              Pi = Pi./(Pi*(ones(1,n))');
              Pi = Pi'./(Pi'*(ones(1,N))');
              Pi=Pi';
          end
      end
      
      function Lambda = update_lambda(obj,X,Y,U,V,k_x,k_y,Lambda,Pi,lr,eta)
          A=U(:,1:k_x)'*X;
          B = Lambda*A;
          Y_A=V(:,1:k_y)'*Y;
          deltaLambda=zeros(k_y,k_x);    
          [~, yN] = size(Y);
          for k=1:yN
          deltaLambda = deltaLambda + ((B - Y_A(:,k)).*repmat(Pi(k,:)',1,k_x)')*A';
          end
          deltaLambda = deltaLambda + 2*eta*Lambda;
          Lambda = Lambda -lr*deltaLambda;
      end
        
      
      function optimize_step(obj)
          %Calculate Cost as a function of Lambda
          obj.C = obj.update_cost_matrix(obj.V, obj.Lambda, obj.U, obj.k_x, obj.k_y, obj.X, obj.Y)
          %Estimate Pi with Lambda fixed, with sinkhorn
          obj.Pi = obj.sinkhorn(obj.C, obj.gamma_h)
          %Updata Lambda with Pi fixed
          obj.Lambda = obj.update_lambda(obj.X, obj.Y, obj.U, obj.V, obj.k_x, obj.k_y, obj.Lambda, obj.Pi, obj.lr, obj.eta) 
          obj.T = obj.V * obj.Lambda *obj.U'     
      end
      
      function Lambda = initialize_lambda(obj,U,V)
          Lambda = V'*U;
      end
      
      
      function optimize(obj)
          if isempty(obj.Lambda)
              obj.Lambda = obj.initialize_lambda(obj.U,obj.V)
          end
          %obj.reduce_basis()
          for i = 1:obj.max_iter
              sprintf(strcat("ayy lmfao: ", string(i)))
              obj.optimize_step()      
          end
      end

   end
   
   
end