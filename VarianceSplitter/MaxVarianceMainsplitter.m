function [pointMarks,treeNodes] = MinVarianceMainsplitter(xValues,yValues,depth)
    %预处理检测
    count = length(xValues);
    if count ~= length(yValues)
        fprintf('输入的X，Y数组长度不一致！\n');
        return;
    end
    %预处理检测
    if depth <= 0
        fprintf('无效的迭代次数（%d）！\n',depth);
    end

    %创建树节点
    newNodes = zeros(1,4);
    %创建标记数组
    newMarks = zeros(1,count);
    %获得分割结果
    [xMean,yMean,beta,deviation] = MaxVarianceSplit(xValues,yValues);
    %设置树节点数值
    newNodes(1,:) = [xMean,yMean,beta,deviation];
    %计算判别式值
    k = tan(beta);
    delta = (yValues - yMean) - k * (xValues - xMean);
    %开始设置标记位
    for i = 1:count
        if delta(i) >= 0
            newMarks(i) = 1;
        else
            newMarks(i) = 2;
        end
    end
    %循环迭代
    while depth > 1
        depth = depth - 1;
        [newMarks,newNodes] = MaxVarianceSubsplitter(xValues,yValues,newMarks,newNodes);
    end
    %设置数值，继续迭代
    pointMarks = newMarks; treeNodes = newNodes;
end
