# -*- coding: utf-8 -*-
"""
Created on Sat Sep 24 19:37:55 2022

@author: micha
"""


class FOT_optimizer:
    """
    For finding transport plan from X to Y
    
    X,Y should have shape: (timeSteps, numFunc) 
    or (timeSteps, numFunc, numDim) if numDim>1
            
    Inputs:
        - X: numpy array, source functions 
        - Y: numpy array, target functions
        
    Optional Inputs:
        - lr: learning rate for gradient descent
        - eta: regularization for Lambda
        - gamma_h: entropy coefficient for Sinkhorn
         
    """
    
    def __init__(self, X, Y, 
                 lr=1e-9, eta = 1, gamma_h = 5):
        
        self.X = X
        self.Y = Y
        
        self.U = self.get_basis(self.X)
        self.V = self.get_basis(self.Y)
        
        self.k_x = self.X.shape[1]
        self.k_y = self.Y.shape[1]
        
        self.lr = lr
        self.eta = eta
        self.gamma_h = gamma_h
        
        
    
    # methods for initializing FOT instance
    def get_basis(self,functionalData):
        pass
    
    def initialize_lambda(self):
        pass
    
    
    # set parameters for optimization manually
    def set_parameters(self, **kwargs):
        for key, value in kwargs.items():
            if key in vars(self):
                print(key + " updated from " + str(getattr(self, key)) + " to " + str(value))
                setattr(self, key, value)
            else:
                print(key + " not a parameter.")
    
    
    # optimization
    def optimize(self):
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
        
FOT = FOT_optimizer(np.random.rand(50,100,3),np.random.rand(50,100,3))

print(FOT.k_x)
FOT.set_parameters(k_x=75, k_z = 30)
print(FOT.k_x)

