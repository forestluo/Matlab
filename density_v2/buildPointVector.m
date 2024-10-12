function [pointCount] = buildPointVector(fileName)
    
    %ȫ�ֱ���
    global sample;
    global row;
    global column;
    %ȫ�ֱ���
    global pointVector;
    
    %��ӡ��Ϣ
    fprintf('Corresponding data file(%s) of image !\r\n',fileName);
    
    %������
    pointCount = 0;
    %����ļ��Ƿ����
    if exist(fileName,'file')
        %װ�������ļ�
        load(fileName,'pointCount','pointVector');
        %��ӡ��Ϣ
        fprintf('Point count(%d) and vector was loaded !\r\n',pointCount);
    else
        %��ͼ����
        invertedSample = ~sample;
        %��ʼ����ֵ
        for n = 1 : row
            %ִ��ѭ��
            for m = 1 : column
                %���������ɫ
                if invertedSample(m,n) == 1
                    %���Ӽ�����
                    pointCount = pointCount + 1;
                end
            end
        end
        %��ӡ��Ϣ
        fprintf('Point vector(count = %d) was created !\r\n',pointCount);
        %��ʼ����������
        pointVector = cell(pointCount);
        %������
        pointCount = 0;
        %��ʼ����ֵ
        for n = 1 : row
            %��ӡ��Ϣ
            fprintf('Initialize line(%d) of point vector !\r\n',n);
            %ִ��ѭ��
            for m = 1 : column
                %���������ɫ
                if invertedSample(m,n) == 1
                    %���Ӽ�����
                    pointCount = pointCount + 1;
                    %��ʼ��ʸ��
                    positionVector = zeros(1,3);
                    %X������
                    positionVector(1,1) = m;
                    %Y������
                    positionVector(1,2) = n;
                    %����֮��
                    positionVector(1,3) = 0;
                    %������������
                    pointVector(pointCount) = {positionVector};
                end
            end
        end
        
        %���������Ϣ
        for n = 1 : pointCount
            %��ӡ��Ϣ
            fprintf('Initialize distance of point(%d) !\r\n',n);
            %���ʸ������
            originalVector = cell2mat(pointVector(n));
            %��������
            x0 = originalVector(1,1);
            y0 = originalVector(1,2);
            %������ֵ
            distance = 0;
            %ͳ�Ƽ������
            for m = 1 : pointCount
                %���ʸ������
                positionVector = cell2mat(pointVector(m));
                %��������
                x1 = positionVector(1,1);
                y1 = positionVector(1,2);
                %�������
                distance = distance + sqrt((x1 - x0) * (x1 - x0) + (y1 - y0) * (y1 - y0));
            end
            %���þ���
            originalVector(1,3) = log(distance);
            %�������þ������
            pointVector(n) = {originalVector};
        end
        
        %��ӡ��Ϣ
        fprintf('Point vector(count = %d) was created !\r\n',pointCount);
        %�����������ļ�
        save(fileName,'pointCount','pointVector');
    end
end