classdef SimpleList
    properties (Access = private)
        %����ͷ
        head;
    end
    
    methods
        %���캯��
        function object = SimpleList()
            %��������ͷ
            object.head = dlnode(int32(0));
        end
     
        %��ó���
        function length = GetLength(object)
            %���س���
            length = object.head.Data;
        end
        %��ñ�����
        function browser = GetBrowser(object)
            %���ɱ�����
            browser = ListBrowser(object.head);
        end
    end
    
    methods
        %ɾ������Ԫ��
        function object = RemoveAll(object)
            %�ָ�����
            object.head.Data = 0;
            %ɾ������Ԫ��
            clearList(object.head);
        end
    end
    
    methods (Access = protected)
        %����һ��Ԫ��
        function object = AddElement(object,element)
            %��������ڵ�
            node = dlnode(element);
            %����ڵ�
            insertAfter(node,object.head);
            %���ӳ���
            object.head.Data = object.head.Data + 1;
        end
    end
end
