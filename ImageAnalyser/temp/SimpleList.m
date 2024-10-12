classdef SimpleList
    properties (Access = public)
        %����
        data;
        %��һ��
        next;
        %��һ��
        previous;
    end
    
    methods
        %���캯��
        function object = SimpleList()
            %���ö���
            object.next = object;
            object.previous = object;
        end
        
        %�����һ������
        function next = GetNext(object)
            %���ض���
            next = object.next;
        end
        %�����һ������
        function previous = GetPrevious(object)
            %���ض���
            previous = object.previous;
        end
        
        %��ͷ����������
        function object = AddHead(object,data)
            %����������
            newObject = ...
                SimpleList();
            %��������
            newObject.data = data;
            
            %�����һ��
            nextObject = object.next;
            %��������ָ��
            object.next = newObject;
            newObject.previous = object;
            %��������ָ��
            newObject.next = nextObject;             
            nextObject.previous = newObject;
        end        
        %��β����������
        function object = AddTail(object,data)
            %����������
            newObject = ...
                SimpleList();
            %��������
            newObject.value = data;
            
            %�����һ��
            previousObject = object.previous;
            %��������ָ��
            newObject.next = object;
            object.previous = newObject;
            %��������ָ��
            previousObject.next = newObject;
            newObject.previous = previousObject;             
        end
    end
end
