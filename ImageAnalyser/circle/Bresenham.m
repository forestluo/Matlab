classdef Bresenham
    methods (Static = true)
        %获得Bresenham算法点矢量
        function [count,coordinates] = GetCoordinates(radius)
            %计数器
            count = 0;
            %创建矩阵
            coordinates = zeros(8 * radius,2);

            %执行Breseham算法
            x = 0;
            y = radius;
            %起点(0,R),下一点中点(1,R-0.5)
            %delta = 1 * 1 + (R - 0.5) * (R - 0.5) - R * R = 1.25 - R
            %delta只参与整数运算，所以小数部分可省略
            delta = 3 - 2 * radius;
            %执行循环
            while y >= x
                %检查
                if x == 0
                    %增加坐标点
                    count = count + 1;
                    coordinates(count,1) = 0;coordinates(count,2) = y;
                    count = count + 1;
                    coordinates(count,1) = y;coordinates(count,2) = 0;
                    count = count + 1;
                    coordinates(count,1) = 0;coordinates(count,2) = -y;
                    count = count + 1;
                    coordinates(count,1) = -y;coordinates(count,2) = 0;
                elseif y == x
                    %增加坐标点
                    count = count + 1;
                    coordinates(count,1) = x;coordinates(count,2) = y;
                    count = count + 1;
                    coordinates(count,1) = x;coordinates(count,2) = -y;
                    count = count + 1;
                    coordinates(count,1) = -x;coordinates(count,2) = y;
                    count = count + 1;
                    coordinates(count,1) = -x;coordinates(count,2) = -y;
                else
                    %增加坐标点
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
                %检查误差
                if delta < 0
                    delta = delta + 4 * x + 6;
                else
                    delta = delta + 4 * (x - y) + 10;
                    y = y - 1;
                end
                %x增加
                x = x + 1;
            end
        end                
    end
end

