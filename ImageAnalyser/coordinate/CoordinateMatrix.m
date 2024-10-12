classdef CoordinateMatrix
    properties
        %长度
        length;
        %坐标组
        coordinates;
    end
    
    methods
        %构造函数
        function object = CoordinateMatrix(length)
            %获得整数
            length = int32(length);
            %检查结果
            if length < 1
                error('CoordinateMatrix的长度必须为正整数');
            end
            %设置长度
            object.length = length;
            %创建数组
            object.coordinates = zeros(length,2);
        end

        %获得长度
        function length = GetLength(object)
            %返回长度
            length = object.length;
        end
        %获得坐标点
        function [x,y] = GetCoordinate(object,index)
            %获得整数
            index = int32(index);
            %检查结果
            if index < 1 || index > object.length
                error('索引超出CoordinateMatrix的长度范围');
            end
            %返回坐标
            x = object.coordinates(index,1); y = object.coordinates(index,2);
        end
        %设置坐标
        function object = SetCoordinate(object,index,x,y)
            %获得整数
            index = int32(index);
            %检查结果
            if index < 1 || index > object.length
                error('索引超出CoordinateMatrix的长度范围');
            end
            %设置坐标
            object.coordinates(index,1) = x; object.coordinates(index,2) = y;
        end

        %将所有点绘制在图中
        function Plot(object)
            %绘制所有点
            for i = 1 : object.GetLength()
                %获得当前坐标
                [x,y] = object. ...
                    GetCoordinate(i);
                %绘制坐标点
                plot(x,y,'go'); hold on;
            end
        end
    end
end