function [distanceCount] = countMinDistance(distance)

    %ȫ�ֱ���
    global pointVector;
    
    %��������С
    pointCount = size(pointVector);

    %����ͳ����ֵ
    distanceCount = 0;
    %�����������
    for n = 1 : pointCount
        %���ʸ������
        positionVector = cell2mat(pointVector(n));
        %��þ�����ֵ
        value = positionVector(1,3);
        %��������ֵ
        if value == distance
            %����ͳ����ֵ��1
            distanceCount = distanceCount + 1;
        end
    end
end