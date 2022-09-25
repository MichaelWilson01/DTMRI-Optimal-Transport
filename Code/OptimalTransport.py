# -*- coding: utf-8 -*-
"""
Created on Sat Sep 24 19:37:55 2022

@author: micha
"""


class FOT_optimizer:
    """
    Initializes FOT instance
    
    data should have shape: (timeSteps, numFunc) 
    or (timeSteps, numFunc, numDim) if numDim>1
            
    Inputs:
        - source: set of functions to be transported, 
        - target: set of functions being transported to
        
    Optional Inputs:
        - lr: learning rate for gradient descent
        - eta: regularization for Lambda
        - gamma_h: entropy coefficient for Sinkhorn
         
    """
    
    def __init__(self, source, target, 
                 lr=1e-9, eta = 1, gamma_h = 5):
        
        self.X = source
        self.Y = target
        
        self.U = self.get_basis(self.X)
        self.V = self.get_basis(self.Y)
        
        self.k_x = self.X.shape[2]
        self.k_y = self.Y.shape[2]
        
        self.lr = lr
        self.eta = eta
        self.gamma_h = gamma_h
        
        
    
    # methods for initializing FOT instance
    def get_basis(self,functionalData):
        pass
    
    def initialize_lambda(self):
        pass
    
    
    # set parameters for optimization manually
    def set_parameters(self):
        pass
    
    
    # optimization
    def optimize(self,X,Y):
        pass
    
    # steps of optimization
    def get_cost_matrix(self):
        #return costMatrix
        pass
    
    def get_pi_sinkhorn(self):
        pass
    
    def get_gradient(self):
        pass
    
    def update_lambda(self):
        pass
    
    

import numpy as np    
        
FOT = FOT_optimizer(np.random.rand(3,3,3),np.random.rand(3,3,3))

print(FOT.lr)
print(FOT.eta)
print(FOT.gamma_h)
print(FOT.X)
print(FOT.Y)
print(FOT.U)
print(FOT.V)


