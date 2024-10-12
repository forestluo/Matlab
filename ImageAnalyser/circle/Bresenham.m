classdef Bresenham
    methods (Static = true)
        %���Bresenham�㷨��ʸ��
        function [count,coordinates] = GetCoordinates(radius)
            %������
            count = 0;
            %��������
            coordinates = zeros(8 * radius,2);

            %ִ��Breseham�㷨
            x = 0;
            y = radius;
            %���(0,R),��һ���е�(1,R-0.5)
            %delta = 1 * 1 + (R - 0.5) * (R - 0.5) - R * R = 1.25 - R
            %deltaֻ�����������㣬����С�����ֿ�ʡ��
            delta = 3 - 2 * radius;
            %ִ��ѭ��
            while y >= x
                %���
                if x == 0
                    %���������
                    count = count + 1;
                    coordinates(count,1) = 0;coordinates(count,2) = y;
                    count = count + 1;
                    coordinates(count,1) = y;coordinates(count,2) = 0;
                    count = count + 1;
                    coordinates(count,1) = 0;coordinates(count,2) = -y;
                    count = count + 1;
                    coordinates(count,1) = -y;coordinates(count,2) = 0;
                elseif y == x
                    %���������
                    count = count + 1;
                    coordinates(count,1) = x;coordinates(count,2) = y;
                    count = count + 1;
                    coordinates(count,1) = x;coordinates(count,2) = -y;
                    count = count + 1;
                    coordinates(count,1) = -x;coordinates(count,2) = y;
                    count = count + 1;
                    coordinates(count,1) = -x;coordinates(count,2) = -y;
                else
                    %���������
                    count = count + 1;
                    coordinates(count,1) = x;coordinates(count,2) = y;
                    count = count + 1;
                    coordinates(count,1) = y;coordinates(count,2) = x;
                    count = count + 1;
                    coordinates(count,1) = x;coordinates(count,2) = -y;
                    count = count + 1;
                    coordinates(count,1) = y;coordinates(count,2) = -x;
                    count = count + 1;
                    coordinates(count,1) = -x;coordinates(count,2) = y;
                    count = count + 1;
                    coordinates(count,1) = -y;coordinates(count,2) = x;
                    count = count + 1;
                    coordinates(count,1) = -x;coordinates(count,2) = -y;
                    count = count + 1;
                    coordinates(count,1) = -y;coordinates(count,2) = -x;
                end
                %������
                if delta < 0
                    delta = delta + 4 * x + 6;
                else
                    delta = delta + 4 * (x - y) + 10;
                    y = y - 1;
                end
                %x����
                x = x + 1;
            end
        end                
    end
end

