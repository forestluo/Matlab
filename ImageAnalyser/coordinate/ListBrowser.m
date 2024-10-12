classdef ListBrowser
    properties (Access = private)
        %����ͷ
        head;
        %��ǰλ��
        position;
    end
    
    methods
        %���캯��
        function object = ListBrowser(head)
            %��������ͷ
            object.head = head;
            %���õ�ǰλ��
            object.position = head.Next;
        end
        
        %����Ϊ��ͷλ��
        function object = SetBeginning(object)
            %����Ϊ��ʼλ��
            object.position = object.head.Next;
        end
        %���ص�ǰλ��
        function position = GetPosition(object)
            %����λ��
            position = object.position;
        end
        %�ƶ�����һ��
        function object = GetNextPosition(object)
            %���ص�ǰλ�õ�����
            object.position = object.position.Next;
        end
    end 
end