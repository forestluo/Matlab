classdef CircleTemplate
    properties (Access = private)
        %�뾶
        radius;
        %����
        matrix;
        %�����
        coordinates;
    end
    
    methods
        %���캯��
        function object = CircleTemplate(radius)
            %ת��������
            radius = int32(radius);
            %��鳤��
            if radius <= 0
                error('Circle�뾶������������');                
            end            
            %��������
            [count,coordinates] = ...
                Bresenham.GetCoordinates(radius);
            %���ð뾶
            object.radius = radius;
            %���þ���
            object.matrix = zeros(2 * radius + 1);
            %���������
            object.coordinates = CoordinateMatrix(count);
            %����ȫ�������
            for i = 1 : count
                %�õ�x����
                x = coordinates(i,1);
                %�õ�y����
                y = coordinates(i,2);
                %���������
                object.coordinates = ...
                    object.coordinates.SetCoordinate(i,x,y);
                %���þ���
                object.matrix(x + radius + 1,y + radius + 1) = 1;
            end
        end

        %��ð뾶
        function radius = GetRadius(object)
            %���ذ뾶��ֵ
            radius = object.radius;
        end
        %��þ���
        function matrix = GetMatrix(object)
            %���ؾ���
            matrix = object.matrix;
        end
        %��ó���
        function length = GetLength(object)
            %���س���
            length = object.coordinates.GetLength();
        end
        %��������
        function [x,y] = GetCoordinate(object,index)
            %��������
            [x,y] = object.coordinates.GetCoordinate(index);
        end
        
        %����ܶ�
        function result = GetDensity(object,x,y,image)
            %���ó�ʼֵ
            result = 0;
            %�������
            x = int32(x); y = int32(y);
            %��ó���
            length = object.GetLength();
            %ִ��ѭ��
            for i = 1 : length
                %��õ�����
                [dx,dy] = object.GetCoordinate(i);
                %�ۼ����ͼ��������ֵ
                %��ɫ��Ϊ1����ɫ��Ϊ0
                result = result + ...
                    image.GetPixel(x + dx,y + dy);
            end
            %��һ������
            %result = length - result;
            result = 1 - double(result) / double(length);
        end

        %����ܶ�
        function result = GetFastDensity(object,x,y,image)
            %�������
            x = int32(x); y = int32(y);
            %��ó���
            length = object.GetLength();
            %��鷶Χ
            if y < 1 || y > image.GetRow() ...
                || x < 1 || x > image.GetColumn()
                error('����ֵ����ͼ��Χ֮��');
            end
            %��þ���
            submatrix = image.GetMatrix(x,y,object.radius);
            %�������
            submatrix = conv2(submatrix,object.matrix,'same');
            %������ĵ�
            %result = length - submatrix(1 + object.radius,1 + object.radius);
            result =  1 - submatrix(1 + object.radius,1 + object.radius) / double(length);
        end
        
        %����������������ͼ��
        function Plot(object)
            %��ͼ
            hold off;
            plot(0,0,'ro');
            rectangle( ...
                'Position', ...
                [-object.radius,-object.radius,2 * object.radius,2 * object.radius], ...
                'Curvature',[1,1]);
            title(sprintf('Bresenham�㷨���뾶%d��������%d', ...
                object.radius,object.GetLength()));
            hold on;
            %�������е�
            object.coordinates.Plot();
            %����ͼ��
            legend('Բ��','ȡֵ��');
            %���������
            axis square;
            axis([-object.radius - 1,+object.radius + 1, ...
                -object.radius - 1,+object.radius + 1]);
            %����������̶�ֵ
            set(gca,'XTick',-object.radius:1:object.radius);
            set(gca,'YTick',-object.radius:1:object.radius);
            %��ʾ����
            grid on;
            %�رձ���
            hold off;
        end
    end
end