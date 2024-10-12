function [result] = integrateLinePixel(image,x,y,dx,dy)

    %全局变量
    global row;
    global column;
    %全局变量
    global range;

    %设置缺省数值
    result = 0;
    %DDA直线算法
    %检查斜率
    if abs(dx) > abs(dy)
        %设置增量范围
        eps = abs(dx);
    else
        %设置增量范围
        eps = abs(dy);
    end
    %求得增量
    ddx = dx / eps;
    ddy = dy / eps;
    %循环执行
    for k = 0 : 1: eps
        %求得图像上的坐标点
        ix = ceil(x + 0.5);
        iy = ceil(y + 0.5); 
        %检查范围
        if iy > 0 && iy <= row ...
            && ix > 0 && ix <= column
            %加和结果数值
            result = result + image(iy,ix);
        end
        %增加坐标量
        x = x + ddx; y = y + ddy;
    end
    %对结果进行归一化处理
    result = result / range;
end