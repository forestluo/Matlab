%获得圆圈上的坐标点
function [distance] = getDistance(x,y)
    %局部持久变量
    persistent MAX_RANGE;
    persistent DISTANCE_MATRIX;
    %检查范围变量
    if isempty(MAX_RANGE)
        %设置最大范围
        MAX_RANGE = 128; %可以与全局变量对接
    end
    %检查矩阵变量
    if isempty(DISTANCE_MATRIX)
        %生成矩阵
        DISTANCE_MATRIX = zeros(MAX_RANGE);
        %初始化局部矩阵
        for a = 1 : MAX_RANGE
            for b = 1 : MAX_RANGE
                %计算距离
                DISTANCE_MATRIX(a,b) = sqrt(a * a + b * b);
            end
        end
    end
    
    %转换成整数
    x = int32(abs(x));
    y = int32(abs(y));
    %检查输入数值
    if x > MAX_RANGE || y > MAX_RANGE
        %提示错误
        error('getCricleCoordinate : 坐标超出范围');
    end
    %检查特殊数值
    if x == 0
        %返回数值
        distance = y;
    elseif y == 0
        %返回数值
        distance = x;
    else
        %返回数值
        distance = DISTANCE_MATRIX(x,y);
    end
end