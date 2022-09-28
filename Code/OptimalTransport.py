# -*- coding: utf-8 -*-
"""
Created on Sat Sep 24 19:37:55 2022

@author: micha
"""


class FOT_optimizer:
    """
    For finding transport plan from X to Y
    
    X,Y should have shape: (numFunc,timeSteps)
    or (numFunc, numDim, timeSteps) if numDim>1
            
    Inputs:
        - X: numpy array, source functions 
        - Y: numpy array, target functions
        
    Optional Inputs:
        - lr: learning rate for gradient descent
        - eta: regularization for Lambda
        - gamma_h: entropy coefficient for Sinkhorn
         
    """
    
    def __init__(self, X, Y, max_iter = 50,
                 lr=1e-9, eta = 1.0, gamma_h = 5.0):
               
        self.X = self.data_shaper(X)
        self.Y = self.data_shaper(Y)
        
        self.max_iter = max_iter
        
        self.U = self.get_pca_basis(self.X)
        self.V = self.get_pca_basis(self.Y)
        
        self.k_x = self.X.shape[0]
        self.k_y = self.Y.shape[0]
        
        self.Lambda = None
        self.T = None
        self.C = None
        self.Pi = None
        
        self.lr = lr
        self.eta = eta
        self.gamma_h = gamma_h
                   
    # methods for initializing FOT instance
    def data_shaper(self, functionData):
        if len(np.shape(functionData))==3:
            numFunc,numDim,timeSteps = np.shape(functionData)
            return np.reshape(functionData, (numFunc, numDim*timeSteps)).T
        elif len(np.shape(functionData))>3: 
            raise ValueError("Data should have shape (numFunc,timeSteps), or (numFunc, numDim, timeSteps) if numDim>1. Instead, data has shape "+str(np.shape(functionData)))
        else: 
            return functionData.T
       
    def get_pca_basis(self,functionData):
        #Get PCA Basis
        muF = np.mean(functionData,0)
        F_centered = functionData - muF
        C = F_centered@F_centered.T
        U = np.linalg.svd(C)[0]        
        return U
     
    def set_parameters(self, **kwargs):
        """
        Manually update parameter values
             
        """
        for key, value in kwargs.items():
            if key in vars(self):
                print(key + " updated from " + str(getattr(self, key)) + " to " + str(value))
                setattr(self, key, value)
            else:
                print(key + " is not a valid class attribute.")
    
    # methods for optimization
    def optimize_step(self):
        # Calculate Cost as a function of Lambda
        self.C = self.update_cost_matrix(self.V, self.Lambda, self.U, self.X, self.Y)
        # Estimate Pi with Lambda fixed, with sinkhorn
        self.Pi = self.update_pi_sinkhorn(self.C, self.gamma_h)
        # Updata Lambda with Pi fixed
        self.Lambda = self.update_lambda(self.X, self.Y, self.U, self.V,
                                         self.Lambda, self.Pi, self.lr, self.eta) 
    
    def initialize_lambda(self):
        temp = self.V.T @ self.U
        self.Lambda = temp[0:self.k_y,0:self.k_x]  
        
    def reduce_basis(self):##Todo: Reduce U and V, then set Lambda
        pass
    
    def update_cost_matrix(self, V, Lambda, U, X, Y):
        T = V @ Lambda @ U.T
        TX = T@X
        C = np.zeros((TX.shape[1],Y.shape[1]))
        for i in range(TX.shape[1]):
            C[i] = np.mean(np.power(Y.T - TX[:,i],2),1)
        return C
    
    def update_pi_sinkhorn(self, C, gamma_h):
        n_x,n_y = np.shape(C)
        Pi = np.exp(-C/gamma_h)
        for i in range(100):##Update stop condition
            Pi = Pi / (Pi @ np.ones((n_y, 1)))
            Pi = Pi / (np.ones((1, n_x)) @ Pi)
        return Pi
            
    def update_lambda(self, X, Y, U, V, Lambda, Pi, lr, eta):
        x_n = X.shape[1]
        y_n = Y.shape[1]
        k_x = U.shape[1]
        k_y = V.shape[1]
        deltaLambda = np.zeros((k_y, k_x))
        #Todo: parallelize
        for i in range(y_n):            
            y_temp = V.T@Y[:,i]            
            for j in range(x_n):                
                A = U.T@X[:,j]   
                deltaLambda = deltaLambda + Pi[i,j]*(Lambda@A - y_temp)@(A.T)       
        deltaLambda = deltaLambda + 2*eta*Lambda        
        return Lambda - lr*deltaLambda 
               
    
    def optimize(self):
        if FOT.Lambda==None: self.initialize_lambda()     
        #self.reduce_basis()
        for i in range(self.max_iter):
            print(i)
            self.optimize_step()
    
    



#testing stuff
import numpy as np

a=1

numFunc = 200
numDim = 3
timeSteps = 50

X=np.random.rand(numFunc,numDim,timeSteps)
Y=np.random.rand(numFunc,numDim,timeSteps)

# for i in range(numFunc):
#     for j in range(numDim):
#         for k in range(timeSteps):
#             X[i,j,k]=a
#             Y[i,j,k]=a
#             a=a+1

FOT = FOT_optimizer(X,Y,max_iter=10,gamma_h=100.0)
FOT.optimize()

TX = FOT.V @ FOT.Lambda @ FOT.U.T @ FOT.X
Y = FOT.Y
