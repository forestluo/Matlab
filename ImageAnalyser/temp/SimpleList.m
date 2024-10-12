classdef SimpleList
    properties (Access = public)
        %数据
        data;
        %下一个
        next;
        %上一个
        previous;
    end
    
    methods
        %构造函数
        function object = SimpleList()
            %设置对象
            object.next = object;
            object.previous = object;
        end
        
        %获得下一个对象
        function next = GetNext(object)
            %返回对象
            next = object.next;
        end
        %获得上一个对象
        function previous = GetPrevious(object)
            %返回对象
            previous = object.previous;
        end
        
        %在头部加入数据
        function object = AddHead(object,data)
            %创建新链表
            newObject = ...
                SimpleList();
            %设置数据
            newObject.data = data;
            
            %获得下一个
            nextObject = object.next;
            %设置数据指针
            object.next = newObject;
            newObject.previous = object;
            %设置数据指针
            newObject.next = nextObject;             
            nextObject.previous = newObject;
        end        
        %在尾部加入数据
        function object = AddTail(object,data)
            %创建新链表
            newObject = ...
                SimpleList();
            %设置数据
            newObject.value = data;
            
            %获得下一个
            previousObject = object.previous;
            %设置数据指针
            newObject.next = object;
            object.previous = newObject;
            %设置数据指针
            previousObject.next = newObject;
            newObject.previous = previousObject;             
        end
    end
end
