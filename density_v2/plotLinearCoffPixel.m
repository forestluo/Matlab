function plotLinearCoffPixel(x,y)
    %ȫ�ֱ���
    global sample;
    global row;
    global column;
    %���Է�������
    global range;
    global linearDensityMatrix;
    
    %�������㷶Χ
    if y > 0 && y <= row ...
        && x > 0 && x <= column
    
        %ȫ�������ܶ�����
        vector = zeros(1,range);
        %���ȫ�������ܶ�����
        for k = 1 : range
            %����������ֵ
            vector(1,k) = linearDensityMatrix(y,x,k);
        end
        %����ԭͼ�β����
        figure(1); subplot(2,2,1);
        imshow(sample,'InitialMagnification','fit');
        hold on; scatter(x,y,1);
        
        %ȫ������
        for n = 1 : row
            %��ӡ��Ϣ
            fprintf('Analyse line(%d) !\r\n',n);
            for m = 1 : column
                %ȫ�������ܶ�����
                vector1 = zeros(1,range);
                %���ȫ�������ܶ�����
                for k = 1 : range
                    %����������ֵ
                    vector1(1,k) = linearDensityMatrix(n,m,k);
                end
                %������֮��������
                value = corrcoef(vector,vector1);
                %��ƽ��ֵ�ľ���ֵ
                value = (value(1,2) + value(2,1)) / 2.0;
                %��ԭͼ�ϴ�㣨������������ݵ㣩
                if value >= 0.90
                    scatter(m,n,1); end
            end
        end
        hold off;
        %�������
        clear vector;
        clear vector1;
    end
end