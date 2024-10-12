classdef DensityMatrix
    properties (Access = private)
        %��
        row;
        %��
        column;
        %�뾶
        radius;
        %�ܶȾ���
        densities;
    end
    
    methods (Access = private)
        %���캯��
        function object = DensityMatrix(row,column,radius)
            %�������
            radius = int32(radius);
            %�����
            if radius < 3
               error('radius���벻С��3');
            end
            %�������
            row = int32(row);
            column = int32(column);
            %�������
            if row < 1 || column < 1
                error('row��column����Ϊ������');
            end
            %������
            object.row = row;
            %������
            object.column = column;
            %���ð뾶
            object.radius = radius;
            %���ɾ���
            object.densities = zeros(row,column,radius);
        end
    end

    methods
        %�������
        function row = GetRow(object)
            %������
            row = object.row;
        end
        %�������
        function column = GetColumn(object)
            %������
            column = object.column;
        end
        %���ʸ��
        function vector = GetVector(object,x,y)
            %�������
            x = int32(x); y = int32(y);
            %��鷶Χ
            if y < 1 || y > object.row ...
                || x < 1 || x > object.column
                error('X�������Y���겻�ڷ�Χ��');
            end
            %����ʸ��
            vector(1:object.radius) = ...
                object.densities(y,x,1:object.radius);
        end
        %����ʸ��
        function object = SetVector(object,x,y,vector)
            %�������
            x = int32(x); y = int32(y);
            %��鷶Χ
            if y < 1 || y > object.row ...
                || x < 1 || x > object.column
                error('X�������Y���겻�ڷ�Χ��');
            end
            %����ʸ��
            object.densities(y,x,1:object.radius) = vector(1:object.radius);
        end
    end

    methods (Static = true)
        %�����ܶȾ���
        function matrix = GetImageMatrix(image,circles)
            %�����
            row = image.GetRow();
            %�����
            column = image.GetColumn();
            %��÷�ɫͼ��
            reverse = image.GetReverse();
            %��ð뾶
            radius = circles.GetRadius();
            %�����ܶȾ���
            matrix = DensityMatrix(row,column,radius);
            %ִ��ѭ��
            for i = 1 : radius
                %���ģ��
                circle = circles.GetCircle(i);
                %����������������й�һ������
                matrix.densities(:,:,i) = ...
                    conv2(reverse,circle.GetMatrix(),'same') / double(circle.GetLength());
            end
        end
    end
end
