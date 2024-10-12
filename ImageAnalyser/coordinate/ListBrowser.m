classdef ListBrowser
    properties (Access = private)
        %链表头
        head;
        %当前位置
        position;
    end
    
    methods
        %构造函数
        function object = ListBrowser(head)
            %设置链表头
            object.head = head;
            %设置当前位置
            object.position = head.Next;
        end
        
        %设置为开头位置
        function object = SetBeginning(object)
            %设置为开始位置
            object.position = object.head.Next;
        end
        %返回当前位置
        function position = GetPosition(object)
            %返回位置
            position = object.position;
        end
        %移动到下一个
        function object = GetNextPosition(object)
            %返回当前位置的数据
            object.position = object.position.Next;
        end
    end 
end