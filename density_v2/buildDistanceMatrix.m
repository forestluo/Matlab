function [distanceCount] = buildDistanceMatrix(fileName)
    
    %全局变量
    global pointVector;
    global distanceMatrix;

    %设置缺省数值
    distanceCount = 0;
    %获得数组大小
    pointCount = size(pointVector);
    %打印消息
    fprintf('Corresponding data file(%s) of image !\r\n',fileName);

    %检查文件是否存在
    if exist(fileName,'file')
        %装载数据文件
        load(fileName,'distanceCount','distanceMatrix');
        %打印消息
        fprintf('Point count(%d) and matrix was loaded !\r\n',pointCount);
    else
        %创建数组
        tempMatrix = zeros(pointCount,3);
        %设置距离
        distance = 0;
        %计算距离信息
        for n = 1 : pointCount
            %寻找最小距离点
            value = findMinDistance(distance);
            %检查结果
            if value == distance
                break; %跳出循环
            else
                %设置数值
                distance = value;
                %增加1
                distanceCount = distanceCount + 1;
                %打印信息
                fprintf('Find minimum distance(%f) !\r\n',distance);
            end
            %设置临时矩阵数值
            tempMatrix(n,1) = distance;
            %统计最小距离点个数量
            tempMatrix(n,2) = countMinDistance(distance);
            %设置临时矩阵标志数值
            tempMatrix(n,3) = 1;
        end
        
        %创建数值
        distanceMatrix = zeros(distanceCount,2);
        %拷贝数据
        for n = 1 : distanceCount
            %拷贝距离
            distanceMatrix(n,1) = tempMatrix(n,1);
            %拷贝统计数量
            distanceMatrix(n,2) = tempMatrix(n,2);
        end
        
        %清理变量
        clear tempMatrix;
        %打印消息
        fprintf('Distance matrix(count = %d) was created !\r\n',distanceCount);
        %保存点阵距离矩阵文件
        save(fileName,'distanceCount','distanceMatrix');
    end
end
