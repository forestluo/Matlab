classdef Coordinate
    properties (Access = private)
        %坐标
        x;
        %Y坐标
        y;
    end
    
    methods
        %构造函数
        function object = Coordinate(varargin)
            %检查参数个数
            if nargin == 0
                %设置缺省坐标
                object.x = int32(0);
                object.y = int32(0);
            elseif nargin == 2
                %设置X坐标
                object.x = int32(varargin{1});
                %设置Y坐标
                object.y = int32(varargin{2});
            else
                error('Coordinate构造函数参数有误');
            end
        end
        %获得坐标
        function [x,y] = Get(object)
            %返回坐标
            x = object.x;
            y = object.y;
        end
        %获得X坐标
        function x = GetX(object)
            %返回X坐标
            x = object.x;
        end
        %获得Y坐标
        function y = GetY(object)
            %返回Y坐标
            y = object.y;
        end
        %设置X坐标
        function object = SetX(object,x)
            %设置X坐标
            object.x = x;
        end
        %设置Y坐标
        function object = SetY(object,y)
            %设置Y坐标
            object.y = y;
        end
    end
end