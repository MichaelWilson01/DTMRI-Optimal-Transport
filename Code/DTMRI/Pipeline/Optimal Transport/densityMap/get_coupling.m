function Pi = get_coupling2(countsX,countsY,g);
     
C = get_cost_matrix2(countsX,countsY);
Pi = sinkhorn(C,g);
        
    

