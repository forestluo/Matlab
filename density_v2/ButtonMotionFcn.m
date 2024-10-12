function ButtonMotionFcn(src,event)
    %����ȫ�ֱ���
    global row;
    global column;
    %����ȫ�ֱ���
    global range;
    global linearDensityMatrix;
    global angularDensityMatrix;
    
    %��õ�ǰ�������
    pt = get(gca,'CurrentPoint');
    x = ceil(pt(1,1));
    y = ceil(pt(1,2));
    %fprintf('x = %d, y = %d\r\n',x,y);
    
    %��鷶Χ
    if y > 0 && y <= row ...
        && x > 0 && x <= column
    
        %ȫ�������ܶ�����
        vector = zeros(1,range + 1);
        %���ȫ�������ܶ�����
        for k = 1 : range + 1
            %����������ֵ��ָ�����Ŵ�
            vector(1,k) = linearDensityMatrix(y,x,k);
        end
        %��ͼ����ʾ�ܶ�����
        figure(1); subplot(2,2,2); plot(vector);
        %�������
        clear vector;
        
        %ȫ�������ܶ�����
        vector = zeros(1,4 * range);
        %���ȫ�������ܶ�����
        for k = 1 : 4 * range
            %����������ֵ��ָ�����Ŵ�
            vector(1,k) = angularDensityMatrix(y,x,k);
        end
        %��ͼ����ʾ�ܶ�����
        figure(1); subplot(2,2,2); hold on; plot(vector,'color','r'); hold off;
        %�������
        clear vector;
        
        %����ԭ��������ϵ
        figure(1); subplot(2,2,1);
    end
end
