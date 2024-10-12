classdef CoordinateVector < SimpleArray
    methods (Access = protected)
        %创建对象
        function elements = NewElement(object,length)
            %检查长度
            if length <= 0
                %返回结果集
                elements = Coordinate.empty;
            else
                %返回创建的对象
                elements = repmat(Coordinate.empty,length,1);
            end
        end
    end

    methods (Access = public)
        %获得坐标
        function coordinate = GetCoordinate(object,index)
            %返回坐标
            coordinate = object.GetElement(index);
        end
        %增加坐标
        function object = AddCoordinate(object,coordinate)
            %增加坐标
            object = object.AddElement(coordinate);
        end
        %设置坐标
        function object = SetCoordinate(object,index,coordinate)
            %设置坐标
            object = object.SetElement(index,coordinate);
        end

        %将所有点绘制在图中
        function Plot(object)
            %绘制所有点
            for i = 1 : object.GetLength()
                %获得当前坐标
                coordinate = object.GetCoordinate(i);
                %绘制坐标点
                plot(coordinate.GetX(),coordinate.GetY(),'go'); hold on;
            end
        end
    end
end
