%定义密度函数
function [vector] = getAngularDensityVector(image,x,y)
    %全局变量
    global range;
    
    %对坐标取整数
    x = ceil(x); y = ceil(y);
    %打印坐标
    %fprintf('x = %d, y = %d\r\n',x,y);
    
    %定义密度数组
    vector = zeros(1,4 * range);
    %开始计算像素点（第一象限）
    for n = 1 : range
        %求得相对坐标值
        %用查表发求得圆周上的坐标点
        m = getCircleCoordinate(range,n);
        %求得线上积分数值（第一像限）
        vector(1,range - n + 1) = integrateLinePixel(image,x,y,n,m);
        %求得线上积分数值（第二像限）
        vector(1,range + n) = integrateLinePixel(image,x,y,-n,m);
        %求得线上积分数值（第三像限）
        vector(1,3 * range - n + 1) = integrateLinePixel(image,x,y,-n,-m);
        %求得线上积分数值（第四像限）
        vector(1,3 * range + n) = integrateLinePixel(image,x,y,n,-m);
    end
end
