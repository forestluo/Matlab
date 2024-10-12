classdef DensityMatrix
    properties
        %��
        row;
        %��
        column;
        %�ܶȾ���
        densities;
    end
    
    methods (Access = private)
        %���캯��
        function object = DensityMatrix(row,column)
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
            %���ɾ���
            object.densities = repmat(Density.empty,row,column);
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
        %����ܶ�
        function density = GetDensity(object,x,y)
            %�������
            x = int32(x); y = int32(y);
            %��鷶Χ
            if y < 1 || y > object.row ...
                || x < 1 || x > object.column
                error('X�������Y���겻�ڷ�Χ��');
            end
            %�����ܶ�
            density = object.densities(y,x);
        end
        %�����ܶ�
        function object = SetDensity(object,x,y,density)
            %�������
            x = int32(x); y = int32(y);
            %��鷶Χ
            if y < 1 || y > object.row ...
                || x < 1 || x > object.column
                error('X�������Y���겻�ڷ�Χ��');
            end
            %�����ܶ�
            object.densities(y,x) = density;
        end
    end

    methods (Static = true)
        %�����ܶȾ���
        function matrix = GetImageMatrix(image,template)
            %�����
            row = image.GetRow();
            %�����
            column = image.GetColumn();
            %�����ܶȾ���
            matrix = DensityMatrix(row,column);
            %ѭ��
            for y = 1 : row
                %��ʾ
                fprintf('���ڴ���%d��ͼ������...\n',y);
                %ѭ��
                for x = 1 : column
                    %���ʸ��
                    vector = template.GetDensity(x,y,image);
                    %�����ܶ�
                    density = Density(x,y);
                    %����ʸ��
                    density = density.SetVector(vector);
                    %���þ���Ԫ��
                    matrix = matrix.SetDensity(x,y,density);
                end
            end
        end
    end
end
