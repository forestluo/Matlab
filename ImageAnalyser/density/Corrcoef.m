classdef Corrcoef
    methods (Static = true)
        %获得相关系数
        function result = GetCorrcoef(v1,v2)
            %求两者之间的相关性
            value = corrcoef(v1,v2);
            %求平均值的绝对值
            result = (value(1,2) + value(2,1)) / 2.0;
        end
        
        %获得相关系数
        function result = GetCorrcoef2(v1,v2)
            %检查开始数据
            if v1(1) == 0 && v2(1) == 0
                %循环位移，去除前端数据
                i = 0;
                while v1(1) == 0 && ...
                        i < size(v1,1)
                    i = i + 1;
                    v1 = circshift(v1,-1);
                end
                %循环位移，去除前端数据
                i = 0;
                while v2(1) == 0 && ...
                        i < size(v2,1)
                    i = i + 1;
                    v2 = circshift(v1,-1);
                end
            elseif v1(1) == 1 && v2(1) == 1
                %循环位移，去除前端数据
                i = 0;
                while v1(1) == 1 && ...
                        i < size(v1,1)
                    i = i + 1;
                    v1(1) = 0;
                    v1 = circshift(v1,-1);
                end
                %循环位移，去除前端数据
                i = 0;
                while v2(1) == 1 && ...
                        i < size(v2,1)
                    i = i + 1;
                    v2(1) = 0;
                    v2 = circshift(v2,-1);
                end
            end
            %求两者之间的相关性
            value = corrcoef(v1,v2);
            %求平均值的绝对值
            result = (value(1,2) + value(2,1)) / 2.0;
        end
    end
end
