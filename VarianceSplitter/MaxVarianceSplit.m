function [xMean,yMean,beta,deviation] = MaxVarianceSplit(xValues,yValues)
    %预处理检测
    count = length(xValues);
    if count <= 0
        fprintf('输入的数组没有元素！\n');
        return;
    end
    if count ~= length(yValues)
        fprintf('输入的X，Y数组长度不一致！\n');
        return;
    end
    %求X，Y平均值
    xMean = mean(xValues);
    yMean = mean(yValues);
    %平移所有点至中心点位置
    xNewValues = xValues - xMean;
    yNewValues = yValues - yMean;
    %计算几个常用数值
    xyNewValue = xNewValues * yNewValues';
    xxNewValue = xNewValues * xNewValues';
    yyNewValue = yNewValues * yNewValues';
    %计算beta角度
    beta = atan(2 * xyNewValue / (xxNewValue - yyNewValue)) / 2;
    %计算二阶导数判别式
    delta = - 2 * (xyNewValue * sin(2 * beta) + (xxNewValue - yyNewValue) * cos(2 * beta));
    %检查判别式
    if delta > 0
        %二阶导数大于零，说明是极小值
        %另外一个垂直方向就是极大值方向
        beta = beta + pi / 2.0;
    end
    %检查计算结果
    %调整输出方向在（0,pi）区间内
    if beta < 0
        beta = beta + pi;
    elseif beta > pi
        beta = beta - pi;
    end
    %计算投影点之间的标准数值
    deviation = sqrt((cos(2 * beta) * (xxNewValue - yyNewValue) + 2 * sin(2 * beta) * xyNewValue + (xxNewValue + yyNewValue)) / (2 * count));
end