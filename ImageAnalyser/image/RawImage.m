classdef RawImage
    properties (Access = private)
        %文件名
        fileName;
        %图像
        image;
        %行数
        row;
        %列数
        column;
    end
    
    methods
        %构造函数
        function object = RawImage(fileName)
            %设置文件名
            object.fileName = fileName;
            %读取图像
            object.image = imread(fileName);
            %获得图像尺寸
            [object.row,object.column] = size(object.image);
        end
        
        %获得行数
        function row = GetRow(object)
            %返回行数
            row = object.row;
        end
        %获得列数
        function column = GetColumn(object)
            %返回列数
            column = object.column;
        end
        %获得原始图像
        function image = GetImage(object)
            %返回原始图像
            image = object.image;
        end
        %显示原始图像
        function ShowImage(object)
            %显示原始图像
            imshow(object.image,'InitialMagnification','fit');
            %设置显示标题
            title(sprintf('%d×%d',object.row,object.column));
        end
    end
end
