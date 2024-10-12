classdef CoordinateList < SimpleList
    methods
        %增加坐标
        function object = ...
            AddCoordinate(object,coordinate)
            %增加对象
            object = object.AddElement(coordinate);
        end

        %将所有点绘制在图中
        function Plot(object)
            %获得遍历器
            browser = object.GetBrowser();
            %获得当前位置
            position = browser.GetPosition();
            %执行循环
            while ~isempty(position)
                %获得当前坐标
                coordinate = position.Data;
                %移动到下一个位置
                browser = ...
                    browser.GetNextPosition();
                %获得当前坐标
                position = browser.GetPosition();
                %绘制坐标点
                plot(coordinate.GetX(),coordinate.GetY(),'go'); hold on;
            end
        end
    end
end
