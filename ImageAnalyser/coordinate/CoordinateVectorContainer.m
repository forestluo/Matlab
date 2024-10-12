classdef CoordinateVectorContainer < SimpleArray
    methods (Access = protected)
        %��������
        function elements = NewElement(object,length)
            %��鳤��
            if length <= 0
                %���ؽ����
                elements = CoordinateVector.empty;
            else
                %���ش����Ķ���
                elements = repmat(CoordinateVector.empty,length,1);
            end
        end
    end
    
    methods (Access = public)
        %�������
        function vector = GetVector(object,index)
            %��������
            vector = object.GetElement(index);
        end
        %��������
        function object = AddVector(object,vector)
            %��������
            object = object.AddElement(vector);
        end
        %��������
        function object = SetVector(object,index,vector)
            %��������
            object = object.SetElement(index,vector);
        end

        %��ʸ�����Ȼ�����ͼ��
        function Plot(object)
            %ִ��ѭ��
            for i = 1 : object.GetLength()
                %��õ�ǰ����
                vector = object.GetVector(i);
                %����ͼ��
                plot(vector.GetRadius(),vector.GetLength(),'go'); hold on;
            end
            %���ñ��⼰�����ı���ʶ
            title('ʸ��������ȡ�����Ա�ͼ'); legend('ȡ����'); hold off;
        end        
    end
end
