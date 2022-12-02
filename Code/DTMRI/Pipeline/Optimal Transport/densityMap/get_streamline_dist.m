function dist1 = get_streamline_dist(fibers1,fibers2)

%         A = mean(vecnorm(fibers1-fibers2));
%         B = mean(vecnorm(fibers1-fliplr(fibers2)));
%         
%         if A<B
%     
            dist1 = GeodesicBetweenTwoCurves(fibers1,fibers2);
            
%         else
%             
%             dist1 = GeodesicBetweenTwoCurves(fibers1,fliplr(fibers2));
%             
%         end
        
end