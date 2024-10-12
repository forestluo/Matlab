classdef SimpleArray
    properties (Access = private)
        %长度
        length;
        %数组
        elements;
    end
    
    methods
        %构造函数
        function object = SimpleArray(varargin)
            if (nargin == 0)
                %设置长度
                object.length = int32(0);
                %创建数组
                object.elements = object.NewElement(0);
            else
                %获得长度
                length = varargin(1);
                %设置长度
                object.length = length;
                %创建数组
                object.elements = object.NewElement(length);
            end
        end
        
        %获得数组长度
        function length = GetLength(object)
            %返回数组长度
            length = object.length;
        end
        %设置数组长度
        function object = SetLength(object,length)
            %获得整数
            length = int32(length);
            %检查长度
            if object.length ~= length
                %创建新数组
                newElements = ...
                    object.NewElement(length);
                %拷贝数组
                for i = 1 : min(length,object.length)
                    %拷贝数据
                    newElements(i) = object.elements(i);
                end
                %设置新数组
                object.elements = newElements;
            end
            %设置数组长度
            object.length = length;
        end
    end
       
    methods (Access = protected)
        %获得对象
        function element = GetElement(object,index)
            %获得整数
%             index = int32(index);
            %检查范围
%             if index < 1 || index > object.length
%                 error('index超出SimpleArray范围');
%             end
            %返回一个元素
            element = object.elements(index);
        end
        %增加对象
        function object = AddElement(object,element)
            %增加长度
            object.length = object.length + 1;
            %增加元素
            object.objects = [object.objects,element];
        end
        %创建对象
        function elements = NewElement(object,length)
            %检查长度
            if length <= 0
                elements = [];
            else
                %返回创建的对象
                elements = repmat([],length,1);
            end
        end
        %设置对象
        function object = SetElement(object,index,element)
            %获得整数
%             index = int32(index);
            %检查范围
%             if index < 1 || index > object.length
%                 error('index超出SimpleArray范围');
%             end
            %设置对象
            object.elements(index) = element;
        end
    end
end
