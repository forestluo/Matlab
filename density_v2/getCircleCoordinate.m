%���ԲȦ�ϵ������
function [result] = getCircleCoordinate(r,value)
    %ȫ�ֱ���
    global range;
    
    %�ֲ��־ñ���
    persistent circleMatrix;
    %���������
    if isempty(circleMatrix)
        %���ɾ���
        circleMatrix = zeros(range + 1,range + 1);
        %��ʼ���ֲ�����
        for R = 0 : range
            for k = 0 : R
                %����Բ�ϵĵ�����
                circleMatrix(R + 1,k + 1) = ceil(sqrt(R * R - k * k));
            end
        end
    end
    
    %���������ֵ
    if r < 0 || r > range
        %��ӡ�쳣����
        fprintf('getCircleCoordinate : invalid r(%f) !\r\n',r); return;
    end
    %���������ֵ
    if value < 0 || value > r
        %��ӡ�쳣����
        fprintf('getCircleCoordinate : invalid value(%f) !\r\n',value); return;
    end
    %������ֵ
    result = circleMatrix(r + 1,value + 1);
end