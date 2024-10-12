classdef Density < Coordinate
    properties (Access = private)
        %密度矢量
        vector;
    end
    
    methods
        %构造函数
        function object = Density(varargin)
            %调用父类构造函数
            object = object@Coordinate();
            %检查参数个数
            if nargin == 0
                %缺省处理
            elseif nargin == 2
                %设置X坐标
                object = object.SetX(varargin{1});
                %设置Y坐标
                object = object.SetY(varargin{2});
            elseif nargin == 3
                %设置X坐标
                object = object.SetX(varargin{1});
                %设置Y坐标
                object = object.SetY(varargin{2});
                %设置矢量
                object = object.SetVector(varargin{3});
            else
                error('Density构造函数参数有误');
            end
        end
        
        %获得密度矢量
        function vector = GetVector(object)
            %返回密度矢量
            vector = object.vector;
        end
        %获得密度矢量
        function object = SetVector(object,vector)
            %返回密度矢量
            object.vector = vector;
        end
    end
end
