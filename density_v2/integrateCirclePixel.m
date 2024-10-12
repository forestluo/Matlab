function [result] = integrateCirclePixel(image,x,y,r)
   
    %全局变量
    global row;
    global column;

    %检查范围
    if y <= 0 || y > row ...
        || x <= 0 || x > column
        %设置返回值
        result = 0; return;
    elseif r <= 0
        %设置返回值
        result = image(y,x); return;
    end

    %设置缺省数值
    result = 0;
    %开始计算像素点（以第一象限为基础）
    for n = 0 : r
        %求得相对坐标值
        %用查表发求得圆周上的坐标点
        m = getCircleCoordinate(r,n);
        %计算坐标（第一像限）
        dx = x + n;
        dy = y + m;
        %检查模板距离
        if dy > 0 && dy <= row ...
            && dx > 0 && dx <= column
            %累积像素值
            result = result + image(dy,dx);
        end
        %计算坐标（第二像限）
        dx = x - n;
        dy = y + m;
        %检查模板距离
        if dy > 0 && dy <= row ...
            && dx > 0 && dx <= column
            %累积像素值
            result = result + image(dy,dx);
        end
        %计算坐标（第三像限）
        dx = x - n;
        dy = y - m;
        %检查模板距离
        if dy > 0 && dy <= row ...
            && dx > 0 && dx <= column
            %累积像素值
            result = result + image(dy,dx);
        end
        %计算坐标（第四像限）
        dx = x + n;
        dy = y - m;
        %检查模板距离
        if dy > 0 && dy <= row ...
            && dx > 0 && dx <= column
            %累积像素值
            result = result + image(dy,dx);
        end
    end
    %归一化最终数值
    result = result / (2 * pi * r);
end