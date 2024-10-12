classdef CoordinateMatrix
    properties
        %����
        length;
        %������
        coordinates;
    end
    
    methods
        %���캯��
        function object = CoordinateMatrix(length)
            %�������
            length = int32(length);
            %�����
            if length < 1
                error('CoordinateMatrix�ĳ��ȱ���Ϊ������');
            end
            %���ó���
            object.length = length;
            %��������
            object.coordinates = zeros(length,2);
        end

        %��ó���
        function length = GetLength(object)
            %���س���
            length = object.length;
        end
        %��������
        function [x,y] = GetCoordinate(object,index)
            %�������
            index = int32(index);
            %�����
            if index < 1 || index > object.length
                error('��������CoordinateMatrix�ĳ��ȷ�Χ');
            end
            %��������
            x = object.coordinates(index,1); y = object.coordinates(index,2);
        end
        %��������
        function object = SetCoordinate(object,index,x,y)
            %�������
            index = int32(index);
            %�����
            if index < 1 || index > object.length
                error('��������CoordinateMatrix�ĳ��ȷ�Χ');
            end
            %��������
            object.coordinates(index,1) = x; object.coordinates(index,2) = y;
        end

        %�����е������ͼ��
        function Plot(object)
            %�������е�
            for i = 1 : object.GetLength()
                %��õ�ǰ����
                [x,y] = object. ...
                    GetCoordinate(i);
                %���������
                plot(x,y,'go'); hold on;
            end
        end
    end
end