classdef CoordinateMatrixContainer
    properties (Access = private)
        %长度
        length;
        %坐标组
        matrixes;
    end
    
    methods
        %构造函数
        function object = CoordinateMatrixContainer(length)
            %获得整数
            length = int32(length);
            %检查结果
            if length < 1
                error('CoordinateMatrix的长度必须为正整数');
            end
            %设置长度
            object.length = length;
            %创建数组
            object.matrixes = repmat(CoordinateMatrix.empty,length);
        end
    end

    methods
        %获得数组长度
        function length = GetLength(object)
            %返回数组长度
            length = object.length;
        end
        %获得矩阵
        function matrix = GetMatrix(object,index)
            %获得整数
            index = int32(index);
            %检查数值
            if index < 1 || index > object.length
                error('index超出CoordinateMatrixContainer的范围');
            end
            %返回矩阵
            matrix = object.matrixes(index);
        end
        %设置矩阵
        function object = SetMatrix(object,index,matrix)
            %获得整数
            index = int32(index);
            %检查数值
            if index < 1 || index > object.length
                error('index超出CoordinateMatrixContainer的范围');
            end
            %返回矩阵
            object.matrixes(index) = matrix;
        end

        %将矢量长度绘制在图中
        function Plot(object)
            %执行循环
            for i = 1 : object.GetLength()
                %获得当前坐标
                matrix = object.GetMatrix(i);
                %绘制图形
                plot(matrix.GetRadius(),matrix.GetLength(),'go'); hold on;
            end
            %设置标题及其他文本标识
            title('矢量长度与取点数对比图'); legend('取点数'); hold off;
        end
    end
end