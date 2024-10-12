function [pointCount] = buildPointVector(fileName)
    
    %全局变量
    global sample;
    global row;
    global column;
    %全局变量
    global pointVector;
    
    %打印消息
    fprintf('Corresponding data file(%s) of image !\r\n',fileName);
    
    %计数器
    pointCount = 0;
    %检查文件是否存在
    if exist(fileName,'file')
        %装载数据文件
        load(fileName,'pointCount','pointVector');
        %打印消息
        fprintf('Point count(%d) and vector was loaded !\r\n',pointCount);
    else
        %对图像求反
        invertedSample = ~sample;
        %初始化数值
        for n = 1 : row
            %执行循环
            for m = 1 : column
                %检查像素颜色
                if invertedSample(m,n) == 1
                    %增加计数器
                    pointCount = pointCount + 1;
                end
            end
        end
        %打印消息
        fprintf('Point vector(count = %d) was created !\r\n',pointCount);
        %初始化像素数组
        pointVector = cell(pointCount);
        %计数器
        pointCount = 0;
        %初始化数值
        for n = 1 : row
            %打印信息
            fprintf('Initialize line(%d) of point vector !\r\n',n);
            %执行循环
            for m = 1 : column
                %检查像素颜色
                if invertedSample(m,n) == 1
                    %增加计数器
                    pointCount = pointCount + 1;
                    %初始化矢量
                    positionVector = zeros(1,3);
                    %X轴坐标
                    positionVector(1,1) = m;
                    %Y轴坐标
                    positionVector(1,2) = n;
                    %距离之和
                    positionVector(1,3) = 0;
                    %设置数组内容
                    pointVector(pointCount) = {positionVector};
                end
            end
        end
        
        %计算距离信息
        for n = 1 : pointCount
            %打印信息
            fprintf('Initialize distance of point(%d) !\r\n',n);
            %获得矢量矩阵
            originalVector = cell2mat(pointVector(n));
            %获得坐标点
            x0 = originalVector(1,1);
            y0 = originalVector(1,2);
            %距离数值
            distance = 0;
            %统计计算距离
            for m = 1 : pointCount
                %获得矢量矩阵
                positionVector = cell2mat(pointVector(m));
                %获得坐标点
                x1 = positionVector(1,1);
                y1 = positionVector(1,2);
                %计算距离
                distance = distance + sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0));
            end
            %设置距离
            originalVector(1,3) = log(distance);
            %重新设置距离矩阵
            pointVector(n) = {originalVector};
        end
        
        %打印消息
        fprintf('Point vector(count = %d) was created !\r\n',pointCount);
        %保存点阵矩阵文件
        save(fileName,'pointCount','pointVector');
    end
end