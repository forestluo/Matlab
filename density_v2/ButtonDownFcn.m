function ButtonDownFcn(src,event)
    %����ȫ�ֱ���
    global row;
    global column;
    %���Է�������
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
    
        %���ȫ�������ܶ�����
        vector = zeros(1,range + 1);
        %��һ������������
        for k = 1 : range + 1
            %����������ֵ
            vector(1,k) = linearDensityMatrix(y,x,k);
        end
        %�ڼ�¼�������ͼ��
        figure(1); subplot(2,2,4); plot(vector);
        %�������
        clear vector;

        %ȫ��Ƕ��ܶ�����
        vector = zeros(1,4 * range);
        %���ȫ��Ƕ��ܶ�����
        for k = 1 : 4 * range
            %����������ֵ��ָ�����Ŵ�
            vector(1,k) = angularDensityMatrix(y,x,k);
        end
        %��������ʾ����Ҷ���
        figure(1); subplot(2,2,3); stem(fftshift(fft(vector)));
        %��ͼ����ʾ�ܶ�����
        figure(1); subplot(2,2,4); hold on; plot(vector,'color','r'); hold off;
        %�������
        clear vector;
        
        %��ԭͼ�������
        %plotLinearCoffPixel(x,y);
        plotAngularCoffPixel(x,y);
        %figure(1); subplot(2,2,1); text(x,y,'*');
        
        %����ԭ��������ϵ
        figure(1); subplot(2,2,1);
    end
end
