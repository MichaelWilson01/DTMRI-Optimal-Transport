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
                 lr=1e-9, eta = 1, gamma_h = 5):
               
        self.X = self.data_shaper(X)
        self.Y = self.data_shaper(Y)
        
        self.max_iter = max_iter
        
        self.U = self.get_basis(self.X)
        self.V = self.get_basis(self.Y)
        
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
       
    def get_basis(self,functionData):
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
                print(key + " is not a class attribute.")
    
    # methods for optimization
    def optimize_step(self):
        # Calculate Cost as a function of Lambda
        self.update_cost_matrix()
        # Estimate Pi with Lambda fixed, with sinkhorn
        self.update_pi_sinkhorn()
        # Updata Lambda with Pi fixed
        self.update_lambda()  
    
    def initialize_lambda(self):
        temp = self.V.T @ self.U
        self.Lambda = temp[0:self.k_y,0:self.k_x]  
    
    def update_cost_matrix(self):
        T = self.V @ self.Lambda @ self.U.T
        TX = T@self.X
        C = np.zeros((TX.shape[0],self.Y.shape[0]))
        for a in range(TX.shape[0]):
            C[a] = np.mean(np.power(self.Y - TX[a],2),1)
        self.C = C
    
    def update_pi_sinkhorn(self):
        n_x,n_y = np.shape(self.C)
        Pi = np.exp(-self.C/self.gamma_h)
        for i in range(100):
            Pi = Pi / (Pi @ np.ones(n_y, 1))
            Pi = Pi / (np.ones(1, n_x) @ Pi)
            
    def update_lambda(self):
        pass
    
    def optimize(self):
        if FOT.Lambda==None: self.initialize_lambda()       
        for i in range(self.max_iter):
            self.optimize_step()
    
    
#testing stuff
import numpy as np

a=1

numFunc = 10
numDim = 3
timeSteps = 5

X=np.zeros((numFunc,numDim,timeSteps))
Y=np.zeros((numFunc,numDim,timeSteps))

for i in range(numFunc):
    for j in range(numDim):
        for k in range(timeSteps):
            X[i,j,k]=a
            Y[i,j,k]=a
            a=a+1

FOT = FOT_optimizer(X,Y)