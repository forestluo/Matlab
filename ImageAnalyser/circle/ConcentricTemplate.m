classdef ConcentricTemplate
    properties (Access = private)
        %最大半径
        radius;
        %圆模板
        circles;
    end
    
    methods
        %构造函数
        function object = ConcentricTemplate(radius)
            %获得整数
            radius = int32(radius);
            %检查结果
            if radius < 3
                error('ConcentricTemplate半径不能小于3');
            end
            %设置半径
            object.radius = radius;
            %创建圆模板
            object.circles = ...
                repmat(CircleTemplate.empty,radius);
            %创建所有圆坐标模板
            for i = 1 : radius
                %增加圆坐标模板
                object.circles(i) = CircleTemplate(i);
            end
        end

        %获得半径
        function radius = GetRadius(object)
            %返回半径数值
            radius = object.radius;
        end
        %获得模板
        function circle = GetCircle(object,index)
            %获得整数
            index = int32(index);
            %检查结果
            if index < 1 || index > object.radius
                error('索引超出模板数量范围');
            end
            %返回模板
            circle = object.circles(index);
        end

        %获得点状密度矢量
        function vector = GetDensity(object,x,y,image)
            %获得整数
            x = int32(x); y = int32(y);
            %检查坐标值
            if y < 1 || y > image.GetRow() ...
                || x < 1 || x > image.GetColumn()
                error('坐标处于图像范围之外');
            end
            %积分数值数组
            vector = ...
                zeros(1,object.radius);
            %执行循环
            for i = 1 : object.radius
                %获得矩阵
                circle = object.circles(i);
                %获得单个积分数值
                vector(1,i) = circle.GetDensity(x,y,image);
            end
        end
        %获得点状密度矢量
        function vector = GetFastDensity(object,x,y,image)
            %获得整数
            x = int32(x); y = int32(y);
            %检查坐标值
            if y < 1 || y > image.GetRow() ...
                || x < 1 || x > image.GetColumn()
                error('坐标处于图像范围之外');
            end
            %积分数值数组
            vector = ...
                zeros(1,object.radius);
            %执行循环
            for i = 1 : object.radius
                %获得矩阵
                circle = object.circles(i);
                %获得单个积分数值
                vector(1,i) = circle.GetFastDensity(x,y,image);
            end
        end
        
        %将矢量长度绘制在图中
        function Plot(object)
            %执行循环
            for i = 1 : object.radius
                %圆模板
                circle = object.circles(i);
                %绘制图形
                plot(circle.GetRadius(),circle.GetLength(),'go'); hold on;
            end
            %画直线
            plot([1 object.radius],[2 * pi,2 * pi * object.radius],'r-');
            %设置标题及其它相关文本标识
            text(double(1 + object.radius) / 2 , ...
                pi * double(1 + object.radius),'圆周长公式：C = 2\piR');
            title('圆模板长度与取点数对比图'); legend('取点数'); hold off;
        end
    end
end
