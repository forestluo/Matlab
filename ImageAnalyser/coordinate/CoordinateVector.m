classdef CoordinateVector < SimpleArray
    methods (Access = protected)
        %��������
        function elements = NewElement(object,length)
            %��鳤��
            if length <= 0
                %���ؽ����
                elements = Coordinate.empty;
            else
                %���ش����Ķ���
                elements = repmat(Coordinate.empty,length,1);
            end
        end
    end

    methods (Access = public)
        %�������
        function coordinate = GetCoordinate(object,index)
            %��������
            coordinate = object.GetElement(index);
        end
        %��������
        function object = AddCoordinate(object,coordinate)
            %��������
            object = object.AddElement(coordinate);
        end
        %��������
        function object = SetCoordinate(object,index,coordinate)
            %��������
            object = object.SetElement(index,coordinate);
        end

        %�����е������ͼ��
        function Plot(object)
            %�������е�
            for i = 1 : object.GetLength()
                %��õ�ǰ����
                coordinate = object.GetCoordinate(i);
                %���������
                plot(coordinate.GetX(),coordinate.GetY(),'go'); hold on;
            end
        end
    end
end
