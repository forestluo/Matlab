classdef CoordinateMatrixContainer
    properties (Access = private)
        %����
        length;
        %������
        matrixes;
    end
    
    methods
        %���캯��
        function object = CoordinateMatrixContainer(length)
            %�������
            length = int32(length);
            %�����
            if length < 1
                error('CoordinateMatrix�ĳ��ȱ���Ϊ������');
            end
            %���ó���
            object.length = length;
            %��������
            object.matrixes = repmat(CoordinateMatrix.empty,length);
        end
    end

    methods
        %������鳤��
        function length = GetLength(object)
            %�������鳤��
            length = object.length;
        end
        %��þ���
        function matrix = GetMatrix(object,index)
            %�������
            index = int32(index);
            %�����ֵ
            if index < 1 || index > object.length
                error('index����CoordinateMatrixContainer�ķ�Χ');
            end
            %���ؾ���
            matrix = object.matrixes(index);
        end
        %���þ���
        function object = SetMatrix(object,index,matrix)
            %�������
            index = int32(index);
            %�����ֵ
            if index < 1 || index > object.length
                error('index����CoordinateMatrixContainer�ķ�Χ');
            end
            %���ؾ���
            object.matrixes(index) = matrix;
        end

        %��ʸ�����Ȼ�����ͼ��
        function Plot(object)
            %ִ��ѭ��
            for i = 1 : object.GetLength()
                %��õ�ǰ����
                matrix = object.GetMatrix(i);
                %����ͼ��
                plot(matrix.GetRadius(),matrix.GetLength(),'go'); hold on;
            end
            %���ñ��⼰�����ı���ʶ
            title('ʸ��������ȡ�����Ա�ͼ'); legend('ȡ����'); hold off;
        end
    end
end