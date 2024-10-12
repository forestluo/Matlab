%获得圆圈上的坐标点
function [result] = getCircleCoordinate(r,value)
    %全局变量
    global range;
    
    %局部持久变量
    persistent circleMatrix;
    %检查矩阵变量
    if isempty(circleMatrix)
        %生成矩阵
        circleMatrix = zeros(range + 1,range + 1);
        %初始化局部矩阵
        for R = 0 : range
            for k = 0 : R
                %计算圆上的点坐标
                circleMatrix(R + 1,k + 1) = ceil(sqrt(R * R - k * k));
            end
        end
    end
    
    %检查输入数值
    if r < 0 || r > range
        %打印异常错误
        fprintf('getCircleCoordinate : invalid r(%f) !\r\n',r); return;
    end
    %检查输入数值
    if value < 0 || value > r
        %打印异常错误
        fprintf('getCircleCoordinate : invalid value(%f) !\r\n',value); return;
    end
    %返回数值
    result = circleMatrix(r + 1,value + 1);
end