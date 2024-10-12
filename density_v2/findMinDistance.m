function [distance] = findMinDistance(lowerLimit)

    %ȫ�ֱ���
    global pointVector;
    
    %��������С
    pointCount = size(pointVector);

    %��־
    flag = 0;
    %��С����
    distance = lowerLimit;
    %�����������
    for n = 1 : pointCount
        %���ʸ������
        positionVector = cell2mat(pointVector(n));
        %��þ�����ֵ
        value = positionVector(1,3);
        %��þ���ֵ
        if value > lowerLimit
            %����־
            if flag == 0
                %���ñ�־
                flag = 1;
                %���ó�ʼֵ
                distance = value;
            else
                %�����ֵ
                if value < distance
                    distance = value;
                end
            end
        end
    end
end