%画各个分割结果的凸包
function DrawConvexHull(axes,xValues,yValues,pointMarks,depth)
    %预处理检测
    if length(xValues) ~= length(yValues)
        fprintf('输入的X，Y数组长度不一致！\n');
        return;
    end
    %预处理检测
    if length(xValues) ~= length(pointMarks)
        fprintf('输入点数组与标记数组长度不一致！\n');
        return;
    end   
    %预处理检测
    marksTable = tabulate(pointMarks);
    row = size(marksTable,1);
    for i = 1:row
        mark = marksTable(i,1);
        if mark < 0 || mark > 2^depth
            fprintf('数组标记号（%d）是错误的！\n',mark);
            return;
        end
    end
    
    %循环分割
    for i = 1:2^depth
        %查找所有符合标记的索引
        indexes = find(pointMarks(:) == i);
        %获得结果数量
        count = size(indexes,1);
        %检查结果
        if count <= 0
            continue;
        end
        %生成新的数据组
        xNewValues = zeros(1,count);
        yNewValues = zeros(1,count);
        %对数组进行赋值操作
        xNewValues(:) = xValues(indexes);
        yNewValues(:) = yValues(indexes);
        %求点的凸包，返回点索引数组
        K = convhull(xNewValues,yNewValues);
        %绘制凸包
        plot(axes,xNewValues(K),yNewValues(K)); hold on;
    end
end
