classdef Density < Coordinate
    properties (Access = private)
        %�ܶ�ʸ��
        vector;
    end
    
    methods
        %���캯��
        function object = Density(varargin)
            %���ø��๹�캯��
            object = object@Coordinate();
            %����������
            if nargin == 0
                %ȱʡ����
            elseif nargin == 2
                %����X����
                object = object.SetX(varargin{1});
                %����Y����
                object = object.SetY(varargin{2});
            elseif nargin == 3
                %����X����
                object = object.SetX(varargin{1});
                %����Y����
                object = object.SetY(varargin{2});
                %����ʸ��
                object = object.SetVector(varargin{3});
            else
                error('Density���캯����������');
            end
        end
        
        %����ܶ�ʸ��
        function vector = GetVector(object)
            %�����ܶ�ʸ��
            vector = object.vector;
        end
        %����ܶ�ʸ��
        function object = SetVector(object,vector)
            %�����ܶ�ʸ��
            object.vector = vector;
        end
    end
end
