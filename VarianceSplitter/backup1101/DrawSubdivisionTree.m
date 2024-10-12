%�������ĵ���״�ṹ
function DrawSubdivisionTree(axes,treeNodes,depth)
    %��������
    count = 2^(depth - 1) - 1;
    for i = 1:count
        %��õ�һ�����ĵ�Ĳ���
        node = treeNodes(i,:);
        xMean = node(1); yMean = node(2);
        %�������ĵ�
        plot(axes,xMean,yMean,'o');
        hold on;
        text(axes,xMean,yMean,sprintf('%d',i),'Color','red');
        hold on;

        %��õ�һ��������
        subIndex = 2 * i;
        node = treeNodes(subIndex,:);
        xNewMean = node(1); yNewMean = node(2);
        %�������ĵ�
        %plot(axes,xNewMean,yNewMean,'o');
        %text(axes,xMean,yMean,sprintf('%d',subIndex),'Color','red');
        %hold on;
        %����������
        plot(axes,[xMean xNewMean],[yMean yNewMean],'b--');
        hold on;

        %��õ�һ��������
        subIndex = 2 * i + 1;
        node = treeNodes(subIndex,:);
        xNewMean = node(1); yNewMean = node(2);
        %�������ĵ�
        %plot(axes,xNewMean,yNewMean,'o');
        %text(axes,xMean,yMean,sprintf('%d',subIndex),'Color','red');
        %hold on;
        %����������
        plot(axes,[xMean xNewMean],[yMean yNewMean],'b--');
        hold on;
    end
    for i = count:2^depth - 1
        %��õ�һ�����ĵ�Ĳ���
        node = treeNodes(i,:);
        xMean = node(1); yMean = node(2);
        %�������ĵ�
        plot(axes,xMean,yMean,'o');
        hold on;
        text(axes,xMean,yMean,sprintf('%d',i),'Color','red');
        hold on;
    end
end