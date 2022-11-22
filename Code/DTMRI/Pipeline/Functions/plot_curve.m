function f = plotCurve(X,figNum,color)
        
    [L M N] = size(X);

%     f = figure(figNum)
%     figure(figNum)
    hold on

    if color == 0

        for i = 1:N

            plot3(X(1,:,i),X(2,:,i),X(3,:,i))

        end

    else

        for i = 1:N

            plot3(X(1,:,i),X(2,:,i),X(3,:,i),"Color",color)

        end

    end

end