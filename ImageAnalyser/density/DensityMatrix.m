classdef DensityMatrix
    properties (Access = private)
        %行
        row;
        %列
        column;
        %半径
        radius;
        %密度矩阵
        densities;
    end
    
    methods (Access = private)
        %构造函数
        function object = DensityMatrix(row,column,radius)
            %获得整数
            radius = int32(radius);
            %检查结果
            if radius < 3
               error('radius必须不小于3');
            end
            %获得整数
            row = int32(row);
            column = int32(column);
            %检查行数
            if row < 1 || column < 1
                error('row或column必须为正整数');
            end
            %设置行
            object.row = row;
            %设置列
            object.column = column;
            %设置半径
            object.radius = radius;
            %生成矩阵
            object.densities = zeros(row,column,radius);
        end
    end

    methods
        %获得行数
        function row = GetRow(object)
            %返回行
            row = object.row;
        end
        %获得列数
        function column = GetColumn(object)
            %返回列
            column = object.column;
        end
        %获得矢量
        function vector = GetVector(object,x,y)
            %获得整数
            x = int32(x); y = int32(y);
            %检查范围
            if y < 1 || y > object.row ...
                || x < 1 || x > object.column
                error('X坐标或者Y坐标不在范围内');
            end
            %创建矢量
            vector(1:object.radius) = ...
                object.densities(y,x,1:object.radius);
        end
        %设置矢量
        function object = SetVector(object,x,y,vector)
            %获得整数
            x = int32(x); y = int32(y);
            %检查范围
            if y < 1 || y > object.row ...
                || x < 1 || x > object.column
                error('X坐标或者Y坐标不在范围内');
            end
            %设置矢量
            object.densities(y,x,1:object.radius) = vector(1:object.radius);
        end
    end

    methods (Static = true)
        %创建密度矩阵
        function matrix = GetImageMatrix(image,circles)
            %获得行
            row = image.GetRow();
            %获得列
            column = image.GetColumn();
            %获得反色图像
            reverse = image.GetReverse();
            %获得半径
            radius = circles.GetRadius();
            %创建密度矩阵
            matrix = DensityMatrix(row,column,radius);
            %执行循环
            for i = 1 : radius
                %获得模板
                circle = circles.GetCircle(i);
                %计算卷积结果，并进行归一化处理
                matrix.densities(:,:,i) = ...
                    conv2(reverse,circle.GetMatrix(),'same') / double(circle.GetLength());
            end
        end
    end
end
