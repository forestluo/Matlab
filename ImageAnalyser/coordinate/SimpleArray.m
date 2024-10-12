classdef SimpleArray
    properties (Access = private)
        %����
        length;
        %����
        elements;
    end
    
    methods
        %���캯��
        function object = SimpleArray(varargin)
            if (nargin == 0)
                %���ó���
                object.length = int32(0);
                %��������
                object.elements = object.NewElement(0);
            else
                %��ó���
                length = varargin(1);
                %���ó���
                object.length = length;
                %��������
                object.elements = object.NewElement(length);
            end
        end
        
        %������鳤��
        function length = GetLength(object)
            %�������鳤��
            length = object.length;
        end
        %�������鳤��
        function object = SetLength(object,length)
            %�������
            length = int32(length);
            %��鳤��
            if object.length ~= length
                %����������
                newElements = ...
                    object.NewElement(length);
                %��������
                for i = 1 : min(length,object.length)
                    %��������
                    newElements(i) = object.elements(i);
                end
                %����������
                object.elements = newElements;
            end
            %�������鳤��
            object.length = length;
        end
    end
       
    methods (Access = protected)
        %��ö���
        function element = GetElement(object,index)
            %�������
%             index = int32(index);
            %��鷶Χ
%             if index < 1 || index > object.length
%                 error('index����SimpleArray��Χ');
%             end
            %����һ��Ԫ��
            element = object.elements(index);
        end
        %���Ӷ���
        function object = AddElement(object,element)
            %���ӳ���
            object.length = object.length + 1;
            %����Ԫ��
            object.objects = [object.objects,element];
        end
        %��������
        function elements = NewElement(object,length)
            %��鳤��
            if length <= 0
                elements = [];
            else
                %���ش����Ķ���
                elements = repmat([],length,1);
            end
        end
        %���ö���
        function object = SetElement(object,index,element)
            %�������
%             index = int32(index);
            %��鷶Χ
%             if index < 1 || index > object.length
%                 error('index����SimpleArray��Χ');
%             end
            %���ö���
            object.elements(index) = element;
        end
    end
end
