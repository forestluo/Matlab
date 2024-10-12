%���ԲȦ�ϵ������
function [distance] = getDistance(x,y)
    %�ֲ��־ñ���
    persistent MAX_RANGE;
    persistent DISTANCE_MATRIX;
    %��鷶Χ����
    if isempty(MAX_RANGE)
        %�������Χ
        MAX_RANGE = 128; %������ȫ�ֱ����Խ�
    end
    %���������
    if isempty(DISTANCE_MATRIX)
        %���ɾ���
        DISTANCE_MATRIX = zeros(MAX_RANGE);
        %��ʼ���ֲ�����
        for a = 1 : MAX_RANGE
            for b = 1 : MAX_RANGE
                %�������
                DISTANCE_MATRIX(a,b) = sqrt(a * a + b * b);
            end
        end
    end
    
    %ת��������
    x = int32(abs(x));
    y = int32(abs(y));
    %���������ֵ
    if x > MAX_RANGE || y > MAX_RANGE
        %��ʾ����
        error('getCricleCoordinate : ���곬����Χ');
    end
    %���������ֵ
    if x == 0
        %������ֵ
        distance = y;
    elseif y == 0
        %������ֵ
        distance = x;
    else
        %������ֵ
        distance = DISTANCE_MATRIX(x,y);
    end
end