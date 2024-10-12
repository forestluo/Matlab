classdef BitImage
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
        function object = BitImage(fileName)
            %设置文件名
            object.fileName = fileName;
            %读取图像
            rawImage = imread(fileName);
            %转换为灰度图像
            rawImage = rgb2gray(rawImage);
            %转换成灰度图像
            object.image = imbinarize(rawImage);
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
        %获得反色图像
        function image = GetReverse(object)
            %返回反色图像
            image = 1 - object.image;
        end
        %获得像素
        function pixel = GetPixel(object,x,y)
            %检查范围
            if y < 1 || y > object.row ...
                || x < 1 || x > object.column
                %不在范围内的点以白色计
                pixel = 1;
            else
                %累加相关图像像素数值
                %白色点为1，黑色点为0
                pixel = object.image(y,x);
            end
        end
        %获得子矩阵
        function matrix = GetMatrix(object,x,y,radius)
            %创建新矩阵
            %白色点为1，黑色点为0
            newImage = ones(object.row + 2 * radius, ...
                                object.column + 2 * radius);
            %拷贝至新矩阵
            newImage((1 + radius) : (object.row + radius), ...
                (1 + radius) : (object.column + radius)) = object.image;
            %拷贝得到子矩阵
%             matrix = newImage((y + 1) : (y + 2 * radius + 1), ...
%                                     (x + 1) : (x + 2 * radius + 1));
            matrix = newImage(y : (y + 2 * radius),x : (x + 2 * radius));
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
