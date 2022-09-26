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
        
        self.U = self.get_basis(self.X)
        self.V = self.get_basis(self.Y)
        
        self.k_x = self.X.shape[1]
        self.k_y = self.Y.shape[1]
        
        self.Lambda = None
        
        self.max_iter = max_iter
        
        self.lr = lr
        self.eta = eta
        self.gamma_h = gamma_h
               
    
    # methods for initializing FOT instance
    def data_shaper(self, functionData):
        if len(np.shape(functionData))==3:
            numFunc,numDim,timeSteps = np.shape(functionData)
            return np.reshape(functionData, (numFunc, numDim*timeSteps))
        elif len(np.shape(functionData))>3: 
            raise ValueError("Data should have shape (numFunc,timeSteps), or (numFunc, numDim, timeSteps) if numDim>1. Instead, data has shape "+str(np.shape(functionData)))
        else: 
            return functionData
    
    
    def get_basis(self,functionData):
        
        #Get PCA Basis
        muF = np.mean(functionData,0)
        F_centered = functionData - muF
        C = F_centered.T@F_centered
        U = np.linalg.svd(C)[0]
        
        return U
        #return basis_vectors, data_coord

        
    # set parameters for optimization manually
    def set_parameters(self, **kwargs):
        for key, value in kwargs.items():
            if key in vars(self):
                print(key + " updated from " + str(getattr(self, key)) + " to " + str(value))
                setattr(self, key, value)
            else:
                print(key + " is not a model parameter.")
    
    
    # optimization
    def optimize(self):
        if FOT.Lambda==None:
            print(self.Lambda)
            self.initialize_lambda()
            print(self.Lambda)
        pass
    
    # methods for optimization    
    def initialize_lambda(self):
        temp = self.V.T@self.U
        self.Lambda = temp[0:self.k_y,0:self.k_x]  
    
    def get_cost_matrix(self,X_tilde,Y):
        C = np.zeros(self.X.shape[0],self.Y.shape[0])
        for func in FOT.X:
            C[a] = np.mean((FOT.Y - func)**2,1)
            a=a+1
        return C
    
    def get_pi_sinkhorn(self):
        pass
    
    def get_gradient(self):
        pass
    
    def update_lambda(self):
        pass
    
    

import numpy as np

a=1

numFunc = 6
numDim = 2
timeSteps = 3

X=np.zeros((numFunc,numDim,timeSteps))
Y=np.zeros((numFunc,numDim,timeSteps))

for i in range(numFunc):
    for j in range(numDim):
        for k in range(timeSteps):
            X[i,j,k]=a
            Y[i,j,k]=a
            a=a+1

FOT = FOT_optimizer(X,Y)