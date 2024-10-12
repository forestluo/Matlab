%定义密度函数
function [vector] = getLinearDensityVector(image,x,y)
    %全局变量
    global range;
    
    %对坐标取整数
    x = ceil(x); y = ceil(y);
    %打印坐标
    %fprintf('x = %d, y = %d\r\n',x,y);
    
    %定义密度数组
    vector = zeros(1,range + 1);
    %进行循环
    for i = 0 : range
        %计算像素点积分
        vector(1,i + 1) = integrateCirclePixel(image,x,y,i);
    end
end
