%�����ܶȺ���
function [vector] = getAngularDensityVector(image,x,y)
    %ȫ�ֱ���
    global range;
    
    %������ȡ����
    x = ceil(x); y = ceil(y);
    %��ӡ����
    %fprintf('x = %d, y = %d\r\n',x,y);
    
    %�����ܶ�����
    vector = zeros(1,4 * range);
    %��ʼ�������ص㣨��һ���ޣ�
    for n = 1 : range
        %����������ֵ
        %�ò�����Բ���ϵ������
        m = getCircleCoordinate(range,n);
        %������ϻ�����ֵ����һ���ޣ�
        vector(1,range - n + 1) = integrateLinePixel(image,x,y,n,m);
        %������ϻ�����ֵ���ڶ����ޣ�
        vector(1,range + n) = integrateLinePixel(image,x,y,-n,m);
        %������ϻ�����ֵ���������ޣ�
        vector(1,3 * range - n + 1) = integrateLinePixel(image,x,y,-n,-m);
        %������ϻ�����ֵ���������ޣ�
        vector(1,3 * range + n) = integrateLinePixel(image,x,y,n,-m);
    end
end
