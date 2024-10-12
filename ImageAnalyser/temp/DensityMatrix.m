classdef DensityMatrix
    properties
        %行
        row;
        %列
        column;
        %密度矩阵
        densities;
    end
    
    methods (Access = private)
        %构造函数
        function object = DensityMatrix(row,column)
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
            %生成矩阵
            object.densities = repmat(Density.empty,row,column);
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
        %获得密度
        function density = GetDensity(object,x,y)
            %获得整数
            x = int32(x); y = int32(y);
            %检查范围
            if y < 1 || y > object.row ...
                || x < 1 || x > object.column
                error('X坐标或者Y坐标不在范围内');
            end
            %返回密度
            density = object.densities(y,x);
        end
        %设置密度
        function object = SetDensity(object,x,y,density)
            %获得整数
            x = int32(x); y = int32(y);
            %检查范围
            if y < 1 || y > object.row ...
                || x < 1 || x > object.column
                error('X坐标或者Y坐标不在范围内');
            end
            %设置密度
            object.densities(y,x) = density;
        end
    end

    methods (Static = true)
        %创建密度矩阵
        function matrix = GetImageMatrix(image,template)
            %获得行
            row = image.GetRow();
            %获得列
            column = image.GetColumn();
            %创建密度矩阵
            matrix = DensityMatrix(row,column);
            %循环
            for y = 1 : row
                %提示
                fprintf('正在处理%d行图像数据...\n',y);
                %循环
                for x = 1 : column
                    %获得矢量
                    vector = template.GetDensity(x,y,image);
                    %创建密度
                    density = Density(x,y);
                    %设置矢量
                    density = density.SetVector(vector);
                    %设置矩阵元素
                    matrix = matrix.SetDensity(x,y,density);
                end
            end
        end
    end
end
