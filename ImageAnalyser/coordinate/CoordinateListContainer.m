classdef CoordinateListContainer < SimpleList
    methods
        %增加矢量
        function object = ...
            AddVector(object,vector)
            %增加对象
            object = object.AddElement(vector);
        end
        
        %将矢量长度绘制在图中
        function Plot(object)
            %获得遍历器
            browser = object.GetBrowser();
            %获得当前位置
            position = browser.GetPosition();
            %执行循环
            while ~isempty(position)
                %获得当前坐标
                vector = position.Data;
                %移动到下一个位置
                browser = ...
                    browser.GetNextPosition();
                %获得当前坐标
                position = object.GetPosition();
                %绘制图形
                plot(vector.GetRadius(),vector.GetLength(),'go'); hold on;
            end
            %设置标题及其他文本标识
            title('矢量长度与取点数对比图'); legend('取点数'); hold off;
        end        
    end
end