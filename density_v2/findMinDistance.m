function [distance] = findMinDistance(lowerLimit)

    %全局变量
    global pointVector;
    
    %获得数组大小
    pointCount = size(pointVector);

    %标志
    flag = 0;
    %最小距离
    distance = lowerLimit;
    %检索点阵矩阵
    for n = 1 : pointCount
        %获得矢量矩阵
        positionVector = cell2mat(pointVector(n));
        %获得距离数值
        value = positionVector(1,3);
        %获得距离值
        if value > lowerLimit
            %检查标志
            if flag == 0
                %设置标志
                flag = 1;
                %设置初始值
                distance = value;
            else
                %检查数值
                if value < distance
                    distance = value;
                end
            end
        end
    end
end