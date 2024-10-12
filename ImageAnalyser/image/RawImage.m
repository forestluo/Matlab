classdef RawImage
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
        function object = RawImage(fileName)
            %�����ļ���
            object.fileName = fileName;
            %��ȡͼ��
            object.image = imread(fileName);
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
        %��ʾԭʼͼ��
        function ShowImage(object)
            %��ʾԭʼͼ��
            imshow(object.image,'InitialMagnification','fit');
            %������ʾ����
            title(sprintf('%d��%d',object.row,object.column));
        end
    end
end
