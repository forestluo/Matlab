%�����ܶȺ���
function [vector] = getLinearDensityVector(image,x,y)
    %ȫ�ֱ���
    global range;
    
    %������ȡ����
    x = ceil(x); y = ceil(y);
    %��ӡ����
    %fprintf('x = %d, y = %d\r\n',x,y);
    
    %�����ܶ�����
    vector = zeros(1,range + 1);
    %����ѭ��
    for i = 0 : range
        %�������ص����
        vector(1,i + 1) = integrateCirclePixel(image,x,y,i);
    end
end
