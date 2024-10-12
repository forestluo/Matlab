classdef CoordinateVectorContainer < SimpleArray
    methods (Access = protected)
        %创建对象
        function elements = NewElement(object,length)
            %检查长度
            if length <= 0
                %返回结果集
                elements = CoordinateVector.empty;
            else
                %返回创建的对象
                elements = repmat(CoordinateVector.empty,length,1);
            end
        end
    end
    
    methods (Access = public)
        %获得坐标
        function vector = GetVector(object,index)
            %返回坐标
            vector = object.GetElement(index);
        end
        %增加坐标
        function object = AddVector(object,vector)
            %增加坐标
            object = object.AddElement(vector);
        end
        %设置坐标
        function object = SetVector(object,index,vector)
            %设置坐标
            object = object.SetElement(index,vector);
        end

        %将矢量长度绘制在图中
        function Plot(object)
            %执行循环
            for i = 1 : object.GetLength()
                %获得当前坐标
                vector = object.GetVector(i);
                %绘制图形
                plot(vector.GetRadius(),vector.GetLength(),'go'); hold on;
            end
            %设置标题及其他文本标识
            title('矢量长度与取点数对比图'); legend('取点数'); hold off;
        end        
    end
end
