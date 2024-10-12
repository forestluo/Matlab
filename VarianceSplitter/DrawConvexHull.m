%�������ָ�����͹��
function DrawConvexHull(axes,xValues,yValues,pointMarks,depth)
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
        %����͹�������ص���������
        K = convhull(xNewValues,yNewValues);
        %����͹��
        plot(axes,xNewValues(K),yNewValues(K)); hold on;
    end
end
