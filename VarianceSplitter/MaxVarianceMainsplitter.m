function [pointMarks,treeNodes] = MinVarianceMainsplitter(xValues,yValues,depth)
    %Ԥ������
    count = length(xValues);
    if count ~= length(yValues)
        fprintf('�����X��Y���鳤�Ȳ�һ�£�\n');
        return;
    end
    %Ԥ������
    if depth <= 0
        fprintf('��Ч�ĵ���������%d����\n',depth);
    end

    %�������ڵ�
    newNodes = zeros(1,4);
    %�����������
    newMarks = zeros(1,count);
    %��÷ָ���
    [xMean,yMean,beta,deviation] = MaxVarianceSplit(xValues,yValues);
    %�������ڵ���ֵ
    newNodes(1,:) = [xMean,yMean,beta,deviation];
    %�����б�ʽֵ
    k = tan(beta);
    delta = (yValues - yMean) - k * (xValues - xMean);
    %��ʼ���ñ��λ
    for i = 1:count
        if delta(i) >= 0
            newMarks(i) = 1;
        else
            newMarks(i) = 2;
        end
    end
    %ѭ������
    while depth > 1
        depth = depth - 1;
        [newMarks,newNodes] = MaxVarianceSubsplitter(xValues,yValues,newMarks,newNodes);
    end
    %������ֵ����������
    pointMarks = newMarks; treeNodes = newNodes;
end
