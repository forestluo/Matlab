classdef Coordinate
    properties (Access = private)
        %����
        x;
        %Y����
        y;
    end
    
    methods
        %���캯��
        function object = Coordinate(varargin)
            %����������
            if nargin == 0
                %����ȱʡ����
                object.x = int32(0);
                object.y = int32(0);
            elseif nargin == 2
                %����X����
                object.x = int32(varargin{1});
                %����Y����
                object.y = int32(varargin{2});
            else
                error('Coordinate���캯����������');
            end
        end
        %�������
        function [x,y] = Get(object)
            %��������
            x = object.x;
            y = object.y;
        end
        %���X����
        function x = GetX(object)
            %����X����
            x = object.x;
        end
        %���Y����
        function y = GetY(object)
            %����Y����
            y = object.y;
        end
        %����X����
        function object = SetX(object,x)
            %����X����
            object.x = x;
        end
        %����Y����
        function object = SetY(object,y)
            %����Y����
            object.y = y;
        end
    end
end