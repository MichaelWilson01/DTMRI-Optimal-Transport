# -*- coding: utf-8 -*-
"""
Created on Sat Sep 24 19:37:55 2022

@author: micha
"""


class FOT_optimizer:
    
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
    def get_cost(self):
        pass
    
    def get_pi_sinkhorn(self):
        pass
    
    def get_gradient(self):
        pass
    
    def update_lambda(self):
        pass
    
    

import numpy as np    
        
FOT = FOT_optimizer(np.random.rand(3,3,3),np.random.rand(3,3,3))

print(FOT.eta)
