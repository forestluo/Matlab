function [newMarks,newNodes] = MinVarianceSubsplitter(xValues,yValues,pointMarks,treeNodes)
    %树深度
    %至少要有一个节点
    depth = 1;
    %预处理检测
    [row,column] = size(treeNodes);
    if column ~= 4
        fprintf('无效节点长度（%d）!\n',column);
        return;
    end
    %转换成整数处理
    row = int64(row);
    while row ~= 1
        if mod(row,2) == 0
            fprintf('节点数量（%d）不正确!\n',row);
            return;
        end
        depth = depth + 1; row = idivide(row,int64(2));
    end
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
    
    %创建节点数组
    row = 2^depth - 1;
    newNodes = zeros(row + 2^depth,4);
    newNodes(1:row,:) = treeNodes(:,:);
    %创建标记数组
    markValue = 1;
    newMarks = zeros(length(pointMarks),1);
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
        %获得分割结果
        [xNewMean,yNewMean,beta,deviation] = MinVarianceSplit(xNewValues,yNewValues);
        %设置节点数值
        row = row + 1;
        newNodes(row,:) = [xNewMean,yNewMean,beta,deviation];
        %计算判别式值
        k = tan(beta);
        delta = (yNewValues - yNewMean) - k * (xNewValues - xNewMean);
        %开始设置标记位
        for j = 1:count
            if delta(j) >= 0
                newMarks(indexes(j)) = markValue;
            else
                newMarks(indexes(j)) = markValue + 1;
            end
        end
        %标记值累加
        markValue = markValue + 2;
    end
end