classdef BitImage
    properties (Access = private)
        %�ļ���
        fileName;
        %ͼ��
        image;
        %����
        row;
        %����
        column;
    end
    
    methods
        %���캯��
        function object = BitImage(fileName)
            %�����ļ���
            object.fileName = fileName;
            %��ȡͼ��
            rawImage = imread(fileName);
            %ת��Ϊ�Ҷ�ͼ��
            rawImage = rgb2gray(rawImage);
            %ת���ɻҶ�ͼ��
            object.image = imbinarize(rawImage);
            %���ͼ��ߴ�
            [object.row,object.column] = size(object.image);
        end
        
        %�������
        function row = GetRow(object)
            %��������
            row = object.row;
        end
        %�������
        function column = GetColumn(object)
            %��������
            column = object.column;
        end
        %���ԭʼͼ��
        function image = GetImage(object)
            %����ԭʼͼ��
            image = object.image;
        end
        %��÷�ɫͼ��
        function image = GetReverse(object)
            %���ط�ɫͼ��
            image = 1 - object.image;
        end
        %�������
        function pixel = GetPixel(object,x,y)
            %��鷶Χ
            if y < 1 || y > object.row ...
                || x < 1 || x > object.column
                %���ڷ�Χ�ڵĵ��԰�ɫ��
                pixel = 1;
            else
                %�ۼ����ͼ��������ֵ
                %��ɫ��Ϊ1����ɫ��Ϊ0
                pixel = object.image(y,x);
            end
        end
        %����Ӿ���
        function matrix = GetMatrix(object,x,y,radius)
            %�����¾���
            %��ɫ��Ϊ1����ɫ��Ϊ0
            newImage = ones(object.row + 2 * radius, ...
                                object.column + 2 * radius);
            %�������¾���
            newImage((1 + radius) : (object.row + radius), ...
                (1 + radius) : (object.column + radius)) = object.image;
            %�����õ��Ӿ���
%             matrix = newImage((y + 1) : (y + 2 * radius + 1), ...
%                                     (x + 1) : (x + 2 * radius + 1));
            matrix = newImage(y : (y + 2 * radius),x : (x + 2 * radius));
        end
        %��ʾԭʼͼ��
        function ShowImage(object)
            %��ʾԭʼͼ��
            imshow(object.image,'InitialMagnification','fit');
            %������ʾ����
            title(sprintf('%d��%d',object.row,object.column));
        end
    end
end
