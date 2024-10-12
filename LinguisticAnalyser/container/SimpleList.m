classdef SimpleList
    properties (Access = private)
        %链表头
        head;
    end
    
    methods
        %构造函数
        function object = SimpleList()
            %创建链表头
            object.head = dlnode(int32(0));
        end
     
        %获得长度
        function length = GetLength(object)
            %返回长度
            length = object.head.Data;
        end
        %获得遍历器
        function browser = GetBrowser(object)
            %生成遍历器
            browser = ListBrowser(object.head);
        end
    end
    
    methods
        %删除所有元素
        function object = RemoveAll(object)
            %恢复长度
            object.head.Data = 0;
            %删除所有元素
            clearList(object.head);
        end
    end
    
    methods (Access = protected)
        %增加一个元素
        function object = AddElement(object,element)
            %创建链表节点
            node = dlnode(element);
            %插入节点
            insertAfter(node,object.head);
            %增加长度
            object.head.Data = object.head.Data + 1;
        end
    end
end
