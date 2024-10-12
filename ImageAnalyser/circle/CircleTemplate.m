classdef CircleTemplate
    properties (Access = private)
        %半径
        radius;
        %矩阵
        matrix;
        %坐标点
        coordinates;
    end
    
    methods
        %构造函数
        function object = CircleTemplate(radius)
            %转换成整数
            radius = int32(radius);
            %检查长度
            if radius <= 0
                error('Circle半径必须是正整数');                
            end            
            %获得坐标点
            [count,coordinates] = ...
                Bresenham.GetCoordinates(radius);
            %设置半径
            object.radius = radius;
            %设置矩阵
            object.matrix = zeros(2 * radius + 1);
            %设置坐标点
            object.coordinates = CoordinateMatrix(count);
            %设置全部坐标点
            for i = 1 : count
                %得到x坐标
                x = coordinates(i,1);
                %得到y坐标
                y = coordinates(i,2);
                %设置坐标点
                object.coordinates = ...
                    object.coordinates.SetCoordinate(i,x,y);
                %设置矩阵
                object.matrix(x + radius + 1,y + radius + 1) = 1;
            end
        end

        %获得半径
        function radius = GetRadius(object)
            %返回半径数值
            radius = object.radius;
        end
        %获得矩阵
        function matrix = GetMatrix(object)
            %返回矩阵
            matrix = object.matrix;
        end
        %获得长度
        function length = GetLength(object)
            %返回长度
            length = object.coordinates.GetLength();
        end
        %获得坐标点
        function [x,y] = GetCoordinate(object,index)
            %返回坐标
            [x,y] = object.coordinates.GetCoordinate(index);
        end
        
        %获得密度
        function result = GetDensity(object,x,y,image)
            %设置初始值
            result = 0;
            %获得整数
            x = int32(x); y = int32(y);
            %获得长度
            length = object.GetLength();
            %执行循环
            for i = 1 : length
                %获得点坐标
                [dx,dy] = object.GetCoordinate(i);
                %累加相关图像像素数值
                %白色点为1，黑色点为0
                result = result + ...
                    image.GetPixel(x + dx,y + dy);
            end
            %归一化处理
            %result = length - result;
            result = 1 - double(result) / double(length);
        end

        %获得密度
        function result = GetFastDensity(object,x,y,image)
            %获得整数
            x = int32(x); y = int32(y);
            %获得长度
            length = object.GetLength();
            %检查范围
            if y < 1 || y > image.GetRow() ...
                || x < 1 || x > image.GetColumn()
                error('坐标值处于图像范围之外');
            end
            %获得矩阵
            submatrix = image.GetMatrix(x,y,object.radius);
            %卷积计算
            submatrix = conv2(submatrix,object.matrix,'same');
            %获得中心点
            %result = length - submatrix(1 + object.radius,1 + object.radius);
            result =  1 - submatrix(1 + object.radius,1 + object.radius) / double(length);
        end
        
        %将所有坐标点绘制在图中
        function Plot(object)
            %绘图
            hold off;
            plot(0,0,'ro');
            rectangle( ...
                'Position', ...
                [-object.radius,-object.radius,2 * object.radius,2 * object.radius], ...
                'Curvature',[1,1]);
            title(sprintf('Bresenham算法：半径%d，点总数%d', ...
                object.radius,object.GetLength()));
            hold on;
            %绘制所有点
            object.coordinates.Plot();
            %设置图例
            legend('圆心','取值点');
            %绘制坐标架
            axis square;
            axis([-object.radius - 1,+object.radius + 1, ...
                -object.radius - 1,+object.radius + 1]);
            %设置坐标轴刻度值
            set(gca,'XTick',-object.radius:1:object.radius);
            set(gca,'YTick',-object.radius:1:object.radius);
            %显示网格
            grid on;
            %关闭保持
            hold off;
        end
    end
end