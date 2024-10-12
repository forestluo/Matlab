function [distanceCount] = buildDistanceMatrix(fileName)
    
    %ȫ�ֱ���
    global pointVector;
    global distanceMatrix;

    %����ȱʡ��ֵ
    distanceCount = 0;
    %��������С
    pointCount = size(pointVector);
    %��ӡ��Ϣ
    fprintf('Corresponding data file(%s) of image !\r\n',fileName);

    %����ļ��Ƿ����
    if exist(fileName,'file')
        %װ�������ļ�
        load(fileName,'distanceCount','distanceMatrix');
        %��ӡ��Ϣ
        fprintf('Point count(%d) and matrix was loaded !\r\n',pointCount);
    else
        %��������
        tempMatrix = zeros(pointCount,3);
        %���þ���
        distance = 0;
        %���������Ϣ
        for n = 1 : pointCount
            %Ѱ����С�����
            value = findMinDistance(distance);
            %�����
            if value == distance
                break; %����ѭ��
            else
                %������ֵ
                distance = value;
                %����1
                distanceCount = distanceCount + 1;
                %��ӡ��Ϣ
                fprintf('Find minimum distance(%f) !\r\n',distance);
            end
            %������ʱ������ֵ
            tempMatrix(n,1) = distance;
            %ͳ����С����������
            tempMatrix(n,2) = countMinDistance(distance);
            %������ʱ�����־��ֵ
            tempMatrix(n,3) = 1;
        end
        
        %������ֵ
        distanceMatrix = zeros(distanceCount,2);
        %��������
        for n = 1 : distanceCount
            %��������
            distanceMatrix(n,1) = tempMatrix(n,1);
            %����ͳ������
            distanceMatrix(n,2) = tempMatrix(n,2);
        end
        
        %�������
        clear tempMatrix;
        %��ӡ��Ϣ
        fprintf('Distance matrix(count = %d) was created !\r\n',distanceCount);
        %��������������ļ�
        save(fileName,'distanceCount','distanceMatrix');
    end
end
