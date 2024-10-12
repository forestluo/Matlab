function [distanceCount] = countMinDistance(distance)

    %全局变量
    global pointVector;
    
    %获得数组大小
    pointCount = size(pointVector);

    %设置统计数值
    distanceCount = 0;
    %检索点阵矩阵
    for n = 1 : pointCount
        %获得矢量矩阵
        positionVector = cell2mat(pointVector(n));
        %获得距离数值
        value = positionVector(1,3);
        %检查距离数值
        if value == distance
            %距离统计数值加1
            distanceCount = distanceCount + 1;
        end
    end
end