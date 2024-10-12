%绘制中心点树状结构
function DrawSubdivisionTree(axes,treeNodes,depth)
    %计算数量
    count = 2^(depth - 1) - 1;
    for i = 1:count
        %获得第一个中心点的参数
        node = treeNodes(i,:);
        xMean = node(1); yMean = node(2);
        %绘制中心点
        plot(axes,xMean,yMean,'o');
        hold on;
        text(axes,xMean,yMean,sprintf('%d',i),'Color','red');
        hold on;

        %获得第一个子索引
        subIndex = 2 * i;
        node = treeNodes(subIndex,:);
        xNewMean = node(1); yNewMean = node(2);
        %绘制中心点
        %plot(axes,xNewMean,yNewMean,'o');
        %text(axes,xMean,yMean,sprintf('%d',subIndex),'Color','red');
        %hold on;
        %绘制连接线
        plot(axes,[xMean xNewMean],[yMean yNewMean],'b--');
        hold on;

        %获得第一个子索引
        subIndex = 2 * i + 1;
        node = treeNodes(subIndex,:);
        xNewMean = node(1); yNewMean = node(2);
        %绘制中心点
        %plot(axes,xNewMean,yNewMean,'o');
        %text(axes,xMean,yMean,sprintf('%d',subIndex),'Color','red');
        %hold on;
        %绘制连接线
        plot(axes,[xMean xNewMean],[yMean yNewMean],'b--');
        hold on;
    end
    for i = count:2^depth - 1
        %获得第一个中心点的参数
        node = treeNodes(i,:);
        xMean = node(1); yMean = node(2);
        %绘制中心点
        plot(axes,xMean,yMean,'o');
        hold on;
        text(axes,xMean,yMean,sprintf('%d',i),'Color','red');
        hold on;
    end
end