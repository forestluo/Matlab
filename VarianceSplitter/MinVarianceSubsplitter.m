function [newMarks,newNodes] = MinVarianceSubsplitter(xValues,yValues,pointMarks,treeNodes)
    %�����
    %����Ҫ��һ���ڵ�
    depth = 1;
    %Ԥ������
    [row,column] = size(treeNodes);
    if column ~= 4
        fprintf('��Ч�ڵ㳤�ȣ�%d��!\n',column);
        return;
    end
    %ת������������
    row = int64(row);
    while row ~= 1
        if mod(row,2) == 0
            fprintf('�ڵ�������%d������ȷ!\n',row);
            return;
        end
        depth = depth + 1; row = idivide(row,int64(2));
    end
    %Ԥ������
    if length(xValues) ~= length(yValues)
        fprintf('�����X��Y���鳤�Ȳ�һ�£�\n');
        return;
    end
    %Ԥ������
    if length(xValues) ~= length(pointMarks)
        fprintf('����������������鳤�Ȳ�һ�£�\n');
        return;
    end   
    %Ԥ������
    marksTable = tabulate(pointMarks);
    row = size(marksTable,1);
    for i = 1:row
        mark = marksTable(i,1);
        if mark < 0 || mark > 2^depth
            fprintf('�����Ǻţ�%d���Ǵ���ģ�\n',mark);
            return;
        end
    end
    
    %�����ڵ�����
    row = 2^depth - 1;
    newNodes = zeros(row + 2^depth,4);
    newNodes(1:row,:) = treeNodes(:,:);
    %�����������
    markValue = 1;
    newMarks = zeros(length(pointMarks),1);
    %ѭ���ָ�
    for i = 1:2^depth
        %�������з��ϱ�ǵ�����
        indexes = find(pointMarks(:) == i);
        %��ý������
        count = size(indexes,1);
        %�����
        if count <= 0
            continue;
        end
        %�����µ�������
        xNewValues = zeros(1,count);
        yNewValues = zeros(1,count);
        %��������и�ֵ����
        xNewValues(:) = xValues(indexes);
        yNewValues(:) = yValues(indexes);
        %��÷ָ���
        [xNewMean,yNewMean,beta,deviation] = MinVarianceSplit(xNewValues,yNewValues);
        %���ýڵ���ֵ
        row = row + 1;
        newNodes(row,:) = [xNewMean,yNewMean,beta,deviation];
        %�����б�ʽֵ
        k = tan(beta);
        delta = (yNewValues - yNewMean) - k * (xNewValues - xNewMean);
        %��ʼ���ñ��λ
        for j = 1:count
            if delta(j) >= 0
                newMarks(indexes(j)) = markValue;
            else
                newMarks(indexes(j)) = markValue + 1;
            end
        end
        %���ֵ�ۼ�
        markValue = markValue + 2;
    end
end